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
    mmo1: TMemo;
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


  private
    { Private declarations }
  public
    { Public declarations }
  end;
var
k:Integer;
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
ClickFigureAdr:PFigList;
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
end;

procedure TKek.FormKeyDown(Sender: TObject; var Key: Word;
  Shift: TShiftState);
var ClickAdr:PFigList;
begin

 if Selected then
begin
  ClickAdr:=GetAdr(FigureHead,ClickFigure);

   if key = 40 then  //  showmessage('down');
  if ClickAdr.Adr<>nil then ClickFigure:=ClickAdr.Adr.Info;
if Key = 39 then  //   showmessage('left');
 if ClickAdr.R<>nil then ClickFigure:=ClickAdr.R.Info;
end;
if key = 40 then  //  showmessage('down');
  IsRight:=False;
if Key = 39 then  //   showmessage('left');
  IsRight:= True;
  pb1.Repaint;
  DrawDirectArrows(pb1,ClickFigure,IsRight);
 // drawRect(pb1,ClickFigure,clBlue);

end;

procedure TKek.pb1MouseDown(Sender: TObject; Button: TMouseButton;
  Shift: TShiftState; X, Y: Integer);
var x0,y0:Integer;
var lol:PFigList;
 var sel:string;
 var prex:TFigureInfo;

begin
if Selected and IsEmptyTXT(ClickFigure) then
begin
prex:=GetClickFig(x,y,FigureHead,Selected);
 if (ClickFigure.x = prex.x) and (ClickFigure.y
  = prex.y)  then
 begin
  lol:=GetAdr(FigureHead, ClickFigure);
  lol.info.Txt:=InputBox('','',prex.Txt);
  InsertTXT(pb1,ClickFigure);
  Exit;
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
  +'TXT '+ ClickFigure.Txt +#10#13;

  if Selected then
  begin
  pb1.Repaint;
  DrawDirectArrows(pb1,ClickFigure,IsRight);
  drawRect(pb1,ClickFigure,clBlue);
  end;
end;
procedure ButtonReaction(Figure: TFigType);
var p:TFigureInfo;
begin

  if IsRight then
  begin
    case Figure of
      TaskFig:
      begin
        p.x:=ClickFigure.x+ClickFigure.width+offset;
        p.y:=ClickFigure.y;
      end;
      IfFig:
      begin
        p.x:=ClickFigure.x+ClickFigure.width+offset;
        p.y:=ClickFigure.y;
      end;
    end;
  end
  else
  begin
  p.x:=ClickFigure.x;
  p.y:=ClickFigure.y+ClickFigure.Height+offset;
  end;
  p.width:=rectMinWidth;
  p.height:=rectMinHeight;
p.FigType:=Figure;
p.Txt:='';
if (IsRight) {or (Figure = IfFig) }then
  CreateNode(FigureHead,p,ClickFigure)
else
begin
p.level:=ClickFigure.level;
insertFigure(FigureHead,p,ClickFigure);
end;
Kek.pb1.Repaint;
end;
procedure TKek.pb1Paint(Sender: TObject);
var temp:PFigList;
begin
  if maxY>(Kek.pb1.Height-200) then
begin
Kek.ScrollBox1.Height:=Kek.ScrollBox1.Height+200;
Kek.pb1.Height:=Kek.pb1.Height+200;
end;
if maxX>(Kek.pb1.Width-600) then
begin
Kek.ScrollBox1.width:=Kek.ScrollBox1.width+500;
Kek.pb1.width:=Kek.pb1.width+500;
end;
  defaultDraw(pb1);
  DrawBlocks(pb1,FigureHead,maxX,maxY);
if Selected then
  begin
  DrawDirectArrows(pb1,ClickFigure,IsRight);
  drawRect(pb1,ClickFigure,clBlue);
  end;
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
if ssShift
 in Shift then
 begin
 scrollbox1.HorzScrollBar.Position:=scrollbox1.HorzScrollBar.position - scrollbox1.VertScrollBar.Increment;
 end
 else
begin
scrollbox1.VertScrollBar.Position:=scrollbox1.VertScrollBar.position - scrollbox1.VertScrollBar.Increment;
end;
end;
end.





