unit DrawItems;

interface

uses System.SysUtils, Types_const,Vcl.Graphics,Lists,Vcl.ExtCtrls,vcl.Dialogs;
procedure DrawBlocks(pb1:TPaintBox; head:PFigList);
procedure insertVerticalArrows(p:TFigureInfo;head:PArrowList);
procedure defaultDraw(pb1:TPaintBox;head:PArrowList);
procedure DrawArrows(pb1:TPaintBox;head:PArrowList);
procedure DrawDirectArrows(pb1:TPaintBox;p:TFigureInfo;left:boolean);
procedure drawRect(pb1:TPaintBox;p:TFigureInfo;Color:Tcolor);


implementation
var
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
function half(x:integer):integer;
begin
  result:=Round(x/2)
end;
function third(x:integer):integer;
begin
  result:=Round(x/3)
end;
 procedure drawRect(pb1:TPaintBox;p:TFigureInfo;Color:Tcolor);
 var prev:TColor;
begin
  prev:=pb1.Canvas.Pen.Color;
  pb1.Canvas.Pen.Color:=color;
  with pb1.Canvas do
  begin
    MoveTo(p.x,p.y);
    LineTo(p.x,p.y + p.Height);
    LineTo(p.x +p.width,p.y + p.Height);
    LineTo(p.x +p.width,p.y);
    LineTo(p.x,p.y);
  end;
  pb1.Canvas.Pen.Color:=prev;
end;
procedure insertVerticalArrows(p:TFigureInfo;head:PArrowList);
var x,y:integer;
lol:TArrowInfo;
begin
  if p.y>0 then
  begin
  x:=Round(arrowk*sin(arrAngel));
  y:=Round(arrowk*cos(arrAngel));
  lol.x:= round((p.width)/2+startX);
  lol.y:=p.y + p.Height;
  lol.length:=offset;
  lol.ArrowType:=TaskFig;
  lol.Direction:=Vertical;
  insertArow(head,lol);
  end;
end;
procedure drawA(pb1:TPaintBox;p:TArrowInfo; Color:TColor);
var x,y:Integer;
var prevColor:TColor;
begin
  prevColor:=pb1.Canvas.Pen.Color;
  pb1.Canvas.Pen.Color:=Color;
  x:=Round(arrowk*sin(arrAngel));
  y:=Round(arrowk*cos(arrAngel));
  with pb1.Canvas do
  begin
  MoveTo(p.x,p.y);
   case p.Direction of
    Vertical:
    begin
     LineTo(p.x,p.y+p.length);
     LineTo(p.x+x,p.y+p.length-y);
     MoveTo(p.x,p.y+p.length);
     LineTo(p.x-x,p.y+p.length-y);
    end;
    Horizontal:
    begin
     LineTo(p.x+p.length,p.y);
     LineTo(p.x+p.length-y,p.y+x);
     MoveTo(p.x+p.length,p.y);
     LineTo(p.x+p.length-y,p.y-x)
    end;
   end;
    pb1.Canvas.Pen.Color:=prevColor;
  end;
end;
procedure DrawArrows(pb1:TPaintBox;head:PArrowList);
var temp:PArrowList;
var x,y:Integer;
begin
  x:=Round(arrowk*sin(arrAngel));
  y:=Round(arrowk*cos(arrAngel));
temp:=head;
    while temp^.Adr<>nil do
      begin
      drawA(pb1,temp.Info, clBlack);
      temp:=temp^.Adr;
       end;
end;
procedure InsertTXT(pb1:TPaintBox;p:TFigureInfo);
var
  txt:TLabeledEdit;
  TX,TY:Integer;
  TextW,TextH: Integer;
  cap:String;
begin
cap:=p.Txt;
TextW:=pb1.Canvas.TextWidth(cap);
TextH:=pb1.Canvas.TextHeight(cap);
TX:=Round(((p.width)/2)-(TextW/2))+p.x;
TY:=Round(((p.Height)/2)-(TextH/2))+p.y;
pb1.Canvas.TextOut(TX,TY,cap);
end;

procedure defaultDraw(pb1:TPaintBox;head:PArrowList);
var p:TFigureInfo;
  x,y:integer;
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
   p.x:=startX;
   p.y:=startY;
   p.height:=2*Radius;
   p.width:=RectMinWidth;
   p.Txt:=strBegin;
  //insertFigure(Fighead,p);
  InsertTXT(pb1,p);
  insertVerticalArrows(p,head);
  end;
end;
procedure DrawIF(pb1:TPaintBox; p:TFigureInfo; color:TColor);
var prev:TColor;
begin
prev:=pb1.Canvas.Pen.Color;
  pb1.Canvas.Pen.Color:=color;
  with pb1.Canvas do
  begin
    MoveTo(p.x+half(p.width),p.y);
    LineTo(p.x+p.width,p.y + half(p.Height));
    LineTo(p.x +half(p.width),p.y + p.Height);
    LineTo(p.x ,p.y+half(p.Height));
    LineTo(p.x+half(p.width),p.y);
  end;
  pb1.Canvas.Pen.Color:=prev;
end;
procedure DrawWhile(pb1:TPaintBox; p:TFigureInfo; color:TColor);
var prev:TColor;
begin
prev:=pb1.Canvas.Pen.Color;
  pb1.Canvas.Pen.Color:=color;
  with pb1.Canvas do
  begin
    MoveTo(p.x+third(p.width),p.y);
    LineTo(p.x+2*third(p.width),p.y);
    LineTo(p.x+p.width,p.y + half(p.Height));
    LineTo(p.x +2*third(p.width),p.y + p.Height);
    LineTo(p.x +third(p.width),p.y + p.Height);
    LineTo(p.x ,p.y+half(p.Height));
    LineTo(p.x+third(p.width),p.y);
  end;
  pb1.Canvas.Pen.Color:=prev;
end;
procedure DrawFigure(pb1:TPaintBox; p:TFigureInfo; color:TColor);
begin
  case p.FigType of
      TaskFig:
        begin
        drawRect(pb1,p,color);
        end;
        IfFig:
        begin
        DrawIF(pb1,p,color);
        end;
        WhileFig:
        begin
        drawWhile(pb1,p,color);
        end;
  end;
end;
procedure DrawBlocks(pb1:TPaintBox; head:PFigList);
var temp:PFigList;
begin
   temp:=head;
   while temp^.Adr<> nil do
   begin
    temp:=temp^.Adr; //TFigType = (TaskFig,IfFig,WhileFig,StartFig,untilFig);
    DrawFigure(pb1,temp.Info,clBlack);
   end;
end;
procedure DrawDirectArrows(pb1:TPaintBox; p:TFigureInfo; left:boolean);
var x,y:Integer;
var arrow:TArrowInfo  ;
begin
 if left then
 begin
  arrow.Direction:=Horizontal;
  arrow.x:=p.x+p.width;
  arrow.y:=p.y+half(p.Height);
  end
 else
 begin
 arrow.Direction:=Vertical;
 arrow.x:=p.x+half(p.width);
 arrow.y:=p.y+p.Height;
 end;
 arrow.length:=offset;
 drawA(pb1,arrow,clLime);

end;
end.
