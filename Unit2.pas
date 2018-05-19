unit Unit2;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.ExtCtrls, Vcl.StdCtrls, math,
  Vcl.Menus,Vcl.Buttons, Lists, System.ImageList, Vcl.ImgList, Vcl.ComCtrls,
  Vcl.ToolWin,Types_const, DrawItems;
type

  TKek = class(TForm)
    mm1: TMainMenu;
    File1: TMenuItem;
    New1: TMenuItem;
    Open1: TMenuItem;
    Save1: TMenuItem;
    Export1: TMenuItem;
    Undo1: TMenuItem;
    ScrollBox1: TScrollBox;
    pb1: TPaintBox;
    tlb1: TToolBar;
    il1: TImageList;
    btn1: TToolButton;
    btn2: TToolButton;
    btnWhile: TToolButton;
    lbl1: TLabel;
    mmoInput: TMemo;
    notalabel: TLabel;
    procedure getCharParams(var Chrwidth, Chrheight:Integer);
    procedure FormCreate(Sender: TObject);
    procedure ScrollBox1MouseWheelDown(Sender: TObject; Shift: TShiftState;
      MousePos: TPoint; var Handled: Boolean);
    procedure ScrollBox1MouseWheelUp(Sender: TObject; Shift: TShiftState;
      MousePos: TPoint; var Handled: Boolean);
    procedure pb1Paint(Sender: TObject);
    procedure btntaskClick(Sender: TObject);
    procedure btnIfClick(Sender: TObject);
    procedure pb1MouseDown(Sender: TObject; Button: TMouseButton;
      Shift: TShiftState; X, Y: Integer);
    procedure FormKeyDown(Sender: TObject; var Key: Word; Shift: TShiftState);
    procedure btnWhileClick(Sender: TObject);
    procedure InputMode(x,y,chrwidth,chrheight:Integer);



  private
    { Private declarations }
  public
    { Public declarations }
  end;
var
increment:Integer;
k:Integer;
  MaxInlineChars:integer = 30;
  Maxlines:integer = 5;
  FieldLeft:Integer = 0;
  FieldTop:Integer = 0;
  FieldWidth:Integer = 750;
  FieldHeight:Integer = 1500;
  ButtonWidth:Integer;
  RectMinWidth:Integer = 150;
  RectMinHeight:Integer = 100;
  offset:Integer = 75;
  startX:Integer = 20;
  startY:Integer = 20;
  Radius:Integer = 30;
  arrowk:Integer = 12;
  arrAngel: real = Pi/6;
  IsRight,Selected:Boolean;
  Kek: TKek;
  Rect: TRect;
  FigureHead:PFigList;
  maxX, maxY:Integer;
ClickFigure: TFigureInfo;
lol:PFigList;
implementation

{$R *.dfm}

procedure clrscreen(pb1:TPaintBox);
begin
  pb1.Canvas.Brush.Color:=clWhite;
  pb1.Canvas.Rectangle(0,0,pb1.width,pb1.Height);
end;
procedure TKek.FormCreate(Sender: TObject);
var INIT:TFigureInfo;
begin
pb1.canvas.Pen.Width:=3;
createFigureHead(FigureHead);
ClickFigure:=FigureHead.Info;
clrscreen(pb1);
Selected:=False;
notalabel.Visible:=False;
end;

procedure TKek.FormKeyDown(Sender: TObject; var Key: Word;
  Shift: TShiftState);
var ClickAdr:PFigList;

begin

 if Selected then
begin
  ClickAdr:=GetAdr(FigureHead,ClickFigure);
  if Key = 46  then
    DeleteBlock(Figurehead, Clickfigure);


   if key = 40 then  //  showmessage('down');
  if ClickAdr.Adr<>nil then ClickFigure:=ClickAdr.Adr.Info;
if Key = 39 then  //   showmessage('left');
 if ClickAdr.R<>nil then
    try
    ClickFigure:=ClickAdr.R.Info;
   except

   end;

 if key = 38 then  //  showmessage('up');
  begin
   try
    ClickAdr:=GetParentAdr(figurehead, ClickAdr);
    ClickFigure:=Clickadr.Info;
   except

   end;

  end;
end;
//ShowMessage(IntToStr(key));
// if key = 37 then  //  showmessage('left');

if key = 40 then  //  showmessage('down');
  IsRight:=False;
if Key = 39 then  //   showmessage('left');
  IsRight:= True;
  pb1.Repaint;

end;
procedure TKek.InputMode(x,y,chrwidth,chrheight:Integer);
 var prex:TFigureInfo;
begin
  prex:=GetClickFig(x,y,FigureHead,Selected);
   if (ClickFigure.x = prex.x) and (ClickFigure.y = prex.y) and not(ahead(FigureHead,prex)) then
   begin
   mmoInput.Left:=prex.x;
   mmoInput.Top:=prex.y;
   mmoInput.Width:=MaxInlineChars* ChrWidth;
   mmoInput.Height:=Maxlines * ChrHeight;
   mmoInput.Visible:=True;
   mmoInput.Lines.Clear;
   mmoInput.SelStart:=0;
   mmoInput.Lines.Add(prex.Txt);
   end;
end;
procedure TKek.getCharParams(var Chrwidth, Chrheight:Integer);
var DC: HDC;
SaveFont: HFONT;
TTM: TTextMetric;
begin
DC := GetDC(mmoInput.Handle);
if (DC <> 0) then
  begin
  SaveFont := SelectObject(DC,mmoInput.Font.Handle);
  if (GetTextMetrics(DC,TTM)) then
    begin
    ChrWidth:=TTM.tmAveCharWidth+TTM.tmExternalLeading;
    Chrheight:=TTM.tmHeight;
    end;
  SelectObject(DC,SaveFont);
  ReleaseDC(mmoinput.handle,DC);
  end;
end;
procedure TKek.pb1MouseDown(Sender: TObject; Button: TMouseButton;
  Shift: TShiftState; X, Y: Integer);
var x0,y0:Integer;
var lol:PFigList;
 var sel,maxStr:string;
 var prex:TFigureInfo;
  var lvlwidth:integer;
ChrWidth:integer;
var i,maxStrLength:Integer;
Chrheight,CurrStrWidth:Integer;
begin
getCharParams(ChrWidth,Chrheight);
if Selected  then
  begin
  // ShowMessage('lol');
  prex:=GetClickFig(x,y,FigureHead,Selected);
   if (ClickFigure.x = prex.x) and (ClickFigure.y = prex.y)  then
   begin
   //ShowMessage('KEK');
   mmoInput.Left:=prex.x;
   mmoInput.Top:=prex.y;
   mmoInput.Width:=MaxInlineChars* ChrWidth;
   mmoInput.Height:=Maxlines * ChrHeight;
   mmoInput.Visible:=True;
   mmoInput.Lines.Clear;
   mmoInput.SelStart:=0;
   mmoInput.Lines.Add(prex.Txt);
    Exit;
   end;
  end;

if (mmoInput.Visible = True) then
  begin
  prex:=GetClickFig(mmoInput.left,mmoInput.top,FigureHead,Selected);
   if (prex.x = -1) then
    begin
    maxStrLength:=0;
    maxStr:='';
    for i := 0 to mmoInput.Lines.Count do
      begin
      if mmoInput.Lines[i].Length >maxStrLength then
        begin
          maxStrLength:=mmoInput.Lines[i].Length;
          maxStr:=mmoInput.Lines[i];
        end;
      end;
      if (maxStrLength>maxinlinechars)  or (mmoInput.Lines.Count>Maxlines)  then
      begin
        ShowMessage('Too long string for damke method');
        Exit;
      end;
    CurrStrWidth:=pb1.Canvas.TextWidth(maxStr);
      lol:=GetAdr(FigureHead,ClickFigure);
      lvlwidth:=Levelwidth(FigureHead,lol.info.level);
      lol.Info.Txt:=mmoInput.Text;
      increment:=-(ClickFigure.width);
    if (lol.Info.width<CurrStrWidth) and  (CurrStrWidth>RectMinWidth)  then
    lol.Info.width:=CurrStrWidth
    else
     lol.Info.width:=RectMinWidth;
    increment:=increment+lol.Info.width;
    if (lol.Info.Height<>(mmoInput.Lines.Count)*Chrheight) and ((mmoInput.Lines.Count)*Chrheight>RectMinHeight)  then
    begin
    lol.Info.Height:=(mmoInput.Lines.Count)*Chrheight;
    //  HorizontalAdjust(figurehead,lol);
    end
    else
      lol.Info.Height:=RectMinHeight;
     // ShowMessage(IntToStr((mmoInput.Lines.Count+1)*Chrheight));
    InsertTXT(pb1,prex);
        // ShowMessage(IntToStr(increment));

    if RectMinWidth + increment>lvlwidth then
    //showmessage(IntToStr(Levelwidth(FigureHead,lol.Info.level)));
    SetLevelWidth(FigureHead,lol.Info.level,lol.Info.width,increment)
    else
    lol.info.width:=lvlwidth;
    increment:=0;
    mmoInput.Visible:= False;
    end;
  end;
ClickFigure:=GetClickFig(x,y,FigureHead,Selected);
sel:= 'Not selected';
if selected then
sel:= 'selected' else sel:='Not selected';
  lbl1.Caption:=
     'width: '+ IntToStr(ClickFigure.width) +#10#13
    +'height: '+ IntToStr(ClickFigure.height) +#10#13
    +'x: '+ IntToStr(ClickFigure.x) +#10#13
    +'y: '+ IntToStr(ClickFigure.y) +#10#13
    +'level: '+ IntToStr(ClickFigure.level) +#10#13
    +'pb1width: '+ IntToStr(Kek.pb1.width) +#10#13
    +'Selected: '+ sel +#10#13
    +'maxX: ' + IntToStr(maxX) + #10#13
    +'Memo1.CaretPos.y: ' + IntToStr(mmoInput.CaretPos.y) + #10#13
    +'Memo1.CaretPos.X: ' + IntToStr(mmoInput.CaretPos.X*ChrWidth) + #10#13 ;
   // +'level MaxWidth: '  + IntToStr(Levelwidth(FigureHead,lol.info.level));
//  +'TXT '+ ClickFigure.Txt+#10#13;
  mmoInput.Visible:= False;
  pb1.Repaint;
 //ShowMessage(IntToStr(Levelwidth(FigureHead, 1)));
  end;

procedure ButtonReaction(Figure: TFigType);
var p:TFigureInfo;
begin
  if Selected then
  begin
  if IsRight then
    begin
      case Figure of
        TaskFig:
        begin
          p.x:=ClickFigure.x+ClickFigure.width+offset;
          p.y:=ClickFigure.y+half(ClickFigure.Height)-half(RectMinHeight);
        end;
        IfFig:
        begin
          p.x:=ClickFigure.x+ClickFigure.width+offset;
          p.y:=ClickFigure.y+half(ClickFigure.Height)-half(RectMinHeight);
        end;
      end;
    end
    else
    begin
      p.x:=ClickFigure.x;
      p.y:=ClickFigure.y+ClickFigure.Height+offset;
    end;
  p.height:=rectMinHeight;
  p.FigType:=Figure;
  p.Txt:='';
  if (IsRight) {or (Figure = IfFig) }then
    begin
    p.width:=RectMinWidth;
    p.level:=ClickFigure.level+1;
    CreateNode(FigureHead,p,ClickFigure);
    end
  else
    begin
    p.width:=ClickFigure.width;
    p.level:=ClickFigure.level;
    insertFigure(FigureHead,p,ClickFigure);
    end;
  Kek.pb1.Repaint;
  end;
end;

procedure TKek.pb1Paint(Sender: TObject);
var temp:PFigList;
begin
  if maxY>(Kek.pb1.Height- 400) then
begin
Kek.ScrollBox1.Height:=Kek.ScrollBox1.Height+200;
Kek.pb1.Height:=Kek.pb1.Height+200;
end;
if maxX>(Kek.pb1.Width-600) then
begin
Kek.ScrollBox1.width:=Kek.ScrollBox1.width+500;
Kek.pb1.width:=Kek.pb1.width+500;
end;
  DrawBlocks(pb1,FigureHead,maxX,maxY);
if Selected then
  begin
  DrawDirectArrows(pb1,ClickFigure,IsRight);
  drawRect(pb1,ClickFigure,clBlue);
  end;
  defaultDraw(FigureHead,pb1);
end;

procedure TKek.btntaskClick(Sender: TObject);
begin
ButtonReaction(TaskFig);
end;

procedure TKek.btnWhileClick(Sender: TObject);
begin
ButtonReaction(WhileFig);
end;

procedure TKek.btnIfClick(Sender: TObject);
begin
ButtonReaction(IfFig);
end;

procedure TKek.ScrollBox1MouseWheelDown(Sender: TObject; Shift: TShiftState;
  MousePos: TPoint; var Handled: Boolean);
begin
if ssShift
 in Shift then
 begin
 scrollbox1.HorzScrollBar.Position:=scrollbox1.HorzScrollBar.position + scrollbox1.VertScrollBar.Increment;
 end
 else
begin
scrollbox1.VertScrollBar.Position:=scrollbox1.VertScrollBar.position + scrollbox1.VertScrollBar.Increment;
end;
end;

procedure TKek.ScrollBox1MouseWheelUp(Sender: TObject; Shift: TShiftState;
  MousePos: TPoint; var Handled: Boolean);
begin
if ssShift in Shift then
 begin
 scrollbox1.HorzScrollBar.Position:=scrollbox1.HorzScrollBar.position - scrollbox1.VertScrollBar.Increment;
 end
 else
begin
scrollbox1.VertScrollBar.Position:=scrollbox1.VertScrollBar.position - scrollbox1.VertScrollBar.Increment;
end;
end;

end.








