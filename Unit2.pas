unit Unit2;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.ExtCtrls, Vcl.StdCtrls, math,
  Vcl.Menus,Vcl.Buttons, Lists;
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
    BtnRect: TBitBtn;
    BtnIF: TBitBtn;
    pb1: TPaintBox;
    procedure FormCreate(Sender: TObject);
    procedure BtnRectClick(Sender: TObject);
    procedure FormResize(Sender: TObject);
    procedure BtnIFClick(Sender: TObject);

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
procedure DrawVerticalArrows(img1:TPaintBox;p:TFigureInfo);
var x,y:integer;
begin
img1.canvas.Pen.Width:=3;
x:=Round(arrowk*sin(pi/6));
y:=Round(arrowk*cos(pi/6));
with img1.Canvas do
  begin
  MoveTo(Round((p.x2-p.x1)/2+startX),p.y2);
  LineTo(Round((p.x2-p.x1)/2+startX),p.y2+offset);
  LineTo(Round((p.x2-p.x1)/2+startX)+x,p.y2+offset-y);
  MoveTo(Round((p.x2-p.x1)/2+startX),p.y2+offset);
    LineTo(Round((p.x2-p.x1)/2+startX)-x,p.y2+offset-y);

  end;
end;
procedure defaultDraw(img1:TPaintBox);
var p:TFigureInfo;
begin
img1.canvas.Pen.Width:=3;
  with img1.Canvas do
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
  DrawVerticalArrows(img1,p);
  insertFigure(FigureHead,p);
  end;
end;



procedure TForm2.FormCreate(Sender: TObject);
begin

img1.canvas.Pen.Width:=3;
ButtonWidth:=Round(screen.width/12*1);
img1.Left:=ButtonWidth;
img1.width:=ClientWidth-buttonWidth;
img1.Height:=ClientHeight;

BtnRect.Width:=ButtonWidth;
BtnIF.Width:=ButtonWidth;

createFigureHead(FigureHead);
defaultDraw(img1);
end;

procedure clrscreen(img1:TPaintBox);
begin
  img1.Canvas.Rectangle(0,0,img1.width,img1.Height);
end;

procedure TForm2.FormResize(Sender: TObject);
begin
//img1.Margins.Left:=ButtonWidth;
//img1.Align:=alClient;
//clrscreen(img1);
//img1.Picture.Bitmap.Height:=ClientHeight;
//img1.Picture.Bitmap.Width:= ClientWidth-buttonWidth;
//img1.Left:=ButtonWidth;
//img1.Repaint;
//drawFrame(img1);
//clrscreen(img1);
//defaultDraw(img1);
end;

procedure drawRect(img1:TPaintBox;p:TFigureInfo);
begin
img1.canvas.Pen.Width:=3;
  with img1.Canvas do
  begin
    MoveTo(p.x1,p.y1);
    LineTo(p.x1,p.y2);
    LineTo(p.x2,p.y2);
    LineTo(p.x2,p.y1);
    LineTo(p.x1,p.y1);
  end;
end;

procedure TForm2.BtnIFClick(Sender: TObject);
begin
 img1.Height:=img1.Height+200;
 img1.Width:=img1.Width+200;
end;

procedure TForm2.BtnRectClick(Sender: TObject);
var p:TFigureInfo;

begin

p.x1:=startX;
p.y1:=GetY2(FigureHead)+offset;
p.x2:=p.x1+rectMinWidth;
p.y2:=p.y1+rectMinHeight;
if p.y1>img1.Height-200 then
img1.Height:=img1.Height+200;

DrawVerticalArrows(img1,p);
insertFigure(FigureHead,p) ;
drawRect(img1,p);
end;




end.

