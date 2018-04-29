unit Unit2;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.ExtCtrls, Vcl.StdCtrls, math,
  Vcl.Menus,Vcl.Buttons, Lists, System.ImageList, Vcl.ImgList, Vcl.ComCtrls,
  Vcl.ToolWin,Types_const, DrawItems;
type

  TForm2 = class(TForm)
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
  Form2: TForm2;
  Rect: TRect;
  FigureHead:PFigList;
ArrowHead:PArrowList;
ClickFigure: TFigureInfo;
ClickFigureAdr:PFigList;
implementation

{$R *.dfm}

procedure clrscreen(pb1:TPaintBox);
begin
  pb1.Canvas.Brush.Color:=clWhite;
  pb1.Canvas.Rectangle(0,0,pb1.width,pb1.Height);
end;
procedure TForm2.FormCreate(Sender: TObject);
var INIT:TFigureInfo;
begin
pb1.canvas.Pen.Width:=3;
createFigureHead(FigureHead);
ClickFigure:=FigureHead.Info;
createArrowHead(ArrowHead);
clrscreen(pb1);
Selected:=False;
end;

procedure TForm2.FormKeyDown(Sender: TObject; var Key: Word;
  Shift: TShiftState);
begin
if key = 40 then  //  showmessage('down');
  IsRight:=False;
if Key = 39 then  //   showmessage('left');
  IsRight:= True;
  pb1.Repaint;
  DrawDirectArrows(pb1,ClickFigure,IsRight);
  drawRect(pb1,ClickFigure,clLime);
end;

procedure TForm2.pb1MouseDown(Sender: TObject; Button: TMouseButton;
  Shift: TShiftState; X, Y: Integer);
var x0,y0:Integer;
begin

//ShowMessage(IntToStr(x));
ClickFigure:=GetClickFig(x,y,FigureHead,Selected);
  if Selected then
  begin
  pb1.Repaint;
  DrawDirectArrows(pb1,ClickFigure,IsRight);
  drawRect(pb1,ClickFigure,clLime);
  //showMessage(IntToStr(ClickFigure.y1));
  end;

end;
procedure ButtonReaction(Figure: TFigType);
var p:TFigureInfo;
begin
  if IsRight then
  begin
  p.x:=ClickFigure.x+ClickFigure.width+offset;
  p.y:=ClickFigure.y;
  end
  else
  begin
  p.x:=ClickFigure.x;
  p.y:=ClickFigure.y+ClickFigure.Height+offset;
  end;
  p.width:=rectMinWidth;
  p.height:=rectMinHeight;
p.FigType:=Figure;

if p.y>Form2.pb1.Height-200 then
begin
Form2.ScrollBox1.Height:=Form2.ScrollBox1.Height+200;
Form2.pb1.Height:=Form2.pb1.Height+200;
end;
insertVerticalArrows(p,arrowhead);
if (IsRight) or (Figure = IfFig) then
  CreateNode(FigureHead,p,ClickFigure)
else
insertFigure(FigureHead,p);

Form2.pb1.Repaint;
end;

procedure TForm2.pb1Paint(Sender: TObject);
var temp:PFigList;
begin
  defaultDraw(pb1,ArrowHead);
  DrawBlocks(pb1,FigureHead);
  DrawArrows(pb1,ArrowHead);
if Selected then
  begin
  DrawDirectArrows(pb1,ClickFigure,IsRight);
  drawRect(pb1,ClickFigure,clLime);
  end;
end;

procedure TForm2.btntaskClick(Sender: TObject);
begin
ButtonReaction(TaskFig);
end;

procedure TForm2.btnWhileClick(Sender: TObject);
begin
ButtonReaction(WhileFig);
end;

procedure TForm2.btnIfClick(Sender: TObject);
begin
ButtonReaction(IfFig);
end;

procedure TForm2.ScrollBox1MouseWheelDown(Sender: TObject; Shift: TShiftState;
  MousePos: TPoint; var Handled: Boolean);
begin
scrollbox1.VertScrollBar.Position:=scrollbox1.VertScrollBar.position + scrollbox1.VertScrollBar.Increment;
end;

procedure TForm2.ScrollBox1MouseWheelUp(Sender: TObject; Shift: TShiftState;
  MousePos: TPoint; var Handled: Boolean);
begin
scrollbox1.VertScrollBar.Position:=scrollbox1.VertScrollBar.position - scrollbox1.VertScrollBar.Increment;
end;
end.




