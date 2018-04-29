unit Unit2;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.ExtCtrls, Vcl.StdCtrls, math,
  Vcl.Menus,Vcl.Buttons, Lists, System.ImageList, Vcl.ImgList, Vcl.ComCtrls,
  Vcl.ToolWin;
{  const
  FieldLeft = 0;
  FieldTop = 0;
  FieldWidth = 750;
  FieldHeight = 1500;
  ButtonWidth = 125;
  RectMinWidth = 150;
  RectMinHeight = 50;
  offset = 30;
  startX = 20;
  startY = 20;
  Radius = 30;
  arrowk = 12;}
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
    btn3: TToolButton;
    procedure FormCreate(Sender: TObject);


    procedure BtnIFClick(Sender: TObject);
    procedure ScrollBox1MouseWheelDown(Sender: TObject; Shift: TShiftState;
      MousePos: TPoint; var Handled: Boolean);
    procedure ScrollBox1MouseWheelUp(Sender: TObject; Shift: TShiftState;
      MousePos: TPoint; var Handled: Boolean);
    procedure pb1Paint(Sender: TObject);
    procedure btn1Click(Sender: TObject);


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
  Form2: TForm2;
  Rect: TRect;
  FigureHead:PFigList;
implementation

{$R *.dfm}
procedure DrawVerticalArrows(pb1:TPaintBox;p:TFigureInfo);
var x,y:integer;
begin
  pb1.canvas.Pen.Width:=3;
  x:=Round(arrowk*sin(pi/6));
  y:=Round(arrowk*cos(pi/6));
  with pb1.Canvas do
  begin
  MoveTo(Round((p.x2-p.x1)/2+startX),p.y2);
  LineTo(Round((p.x2-p.x1)/2+startX),p.y2+offset);
  LineTo(Round((p.x2-p.x1)/2+startX)+x,p.y2+offset-y);
  MoveTo(Round((p.x2-p.x1)/2+startX),p.y2+offset);
  LineTo(Round((p.x2-p.x1)/2+startX)-x,p.y2+offset-y);
  end;
end;
procedure defaultDraw(pb1:TPaintBox);
var p:TFigureInfo;
begin
pb1.canvas.Pen.Width:=3;
  with pb1.Canvas do
  begin
   Arc(startX,startY,startX+2*Radius,startY+2*Radius,startX+Radius,startY,startX+Radius,startY+2*Radius);
   Arc(startX+RectMinWidth-2*radius,startY,startX+RectMinWidth,startY+2*Radius,startX+RectMinWidth-Radius,startY+2*Radius,startX+RectMinWidth-Radius,startY);
   MoveTo(startX+Radius,StartY);
   LineTo(startX+RectMinWidth-radius,startY);
   MoveTo(startX+Radius-1,StartY+2*Radius);
   LineTo(startX+RectMinWidth-radius,startY+2*Radius);
  p.x1:=startX;
  p.y1:=startY;
  p.x2:=startX+rectMinWidth;
  p.y2:=p.y1+2*Radius;
  DrawVerticalArrows(pb1,p);
  //insertFigure(FigureHead,p);
  end;
end;

procedure TForm2.FormCreate(Sender: TObject);
begin
pb1.canvas.Pen.Width:=3;
createFigureHead(FigureHead);
end;

procedure clrscreen(pb1:TPaintBox);
begin
  pb1.Canvas.Brush.Color:=clWhite;
  pb1.Canvas.Rectangle(0,0,pb1.width,pb1.Height);
end;


 procedure drawRect(pb1:TPaintBox;p:TFigureInfo);
begin
  with pb1.Canvas do
  begin
    MoveTo(p.x1,p.y1);
    LineTo(p.x1,p.y2);
    LineTo(p.x2,p.y2);
    LineTo(p.x2,p.y1);
    LineTo(p.x1,p.y1);
  end;
end;
procedure TForm2.pb1Paint(Sender: TObject);
var temp:PFigList;
begin
  with pb1.Canvas do
  begin
  defaultDraw(pb1);
   temp:=FigureHead;
   while temp^.Adr<> nil do
   begin
    drawRect(pb1,temp.Info);
    DrawVerticalArrows(pb1,temp.Info);
    temp:=temp^.Adr;
   end;
  end;
end;

procedure TForm2.btn1Click(Sender: TObject);
var p:TFigureInfo;
begin
p.x1:=startX;
p.y1:=GetY2(FigureHead)+offset;
p.x2:=p.x1+rectMinWidth;
p.y2:=p.y1+rectMinHeight;
if p.y1>pb1.Height-200 then
begin
ScrollBox1.Height:=ScrollBox1.Height+200;
pb1.Height:=pb1.Height+200;
end;
insertFigure(FigureHead,p) ;
pb1.Repaint;
end;




procedure TForm2.BtnIFClick(Sender: TObject);
begin
 pb1.Height:=pb1.Height+200;
 pb1.Width:=pb1.Width+200;
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



