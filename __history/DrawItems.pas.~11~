unit DrawItems;

interface

uses 	 System.SysUtils,System.Types, Types_const,Vcl.Graphics,Lists,Vcl.ExtCtrls,vcl.Dialogs;
procedure DrawBlocks(pb1:TPaintBox; head:PFigList; var maxX,maxY:integer);
procedure defaultDraw(head:PFigList;pb1:TPaintBox);
procedure DrawDirectArrows(pb1:TPaintBox;p:TFigureInfo;left:boolean);
procedure drawRect(pb1:TPaintBox;p:TFigureInfo;Color:Tcolor);
procedure InsertTXT(pb1:TPaintBox;var p:TFigureInfo);
function IsEmptyTXT(p:TFigureInfo):Boolean;

implementation
var
  FieldLeft:Integer = 0;
  FieldTop:Integer = 0;
  FieldWidth:Integer = 750;
  FieldHeight:Integer = 1500;
  ButtonWidth:Integer;
  RectMinWidth:Integer = 75;
  RectMinHeight:Integer = 100;
  ratio:real=1.5;
  offset:Integer = 75;
  startX:Integer = 50;
  startY:Integer = 20;
  Radius:Integer = 30;
  arrowk:Integer = 12;
  arrAngel: real = Pi/6;
  function TextUtil(cap:string):string;
  var lengthkek,i:Integer;
  begin
  lengthkek:=Length(cap);
    i:=1;
    while i<Lengthkek do

    begin
      if ( cap[i]=':') and (cap[i+1]= '=')  then
      begin
      Insert('#10#13',cap,i+2);
      lengthkek:=Length(cap);
      end;
      result:=cap;
      inc(i);
    end;

  end;
  procedure InsertTXT(pb1:TPaintBox;var p:TFigureInfo);
var
  txt:TLabeledEdit;
  TX,TY:Integer;
  TextW,TextH: Integer;
  cap:String;
  Rectan:Trect;
  border:Integer;
  oldStyle:TBrushStyle;
begin
oldStyle:=pb1.Canvas.Brush.Style;
pb1.Canvas.Brush.Style:=bsClear;
border:=0;
case p.FigType of
  TaskFig:
  Rectan:=
  Rect(p.x+border,p.y+border,p.x + p.width-2*border,p.y + p.Height-2*border);
  IfFig:
  Rectan:=
  Rect(p.x+third(p.width)+border,p.y+third(p.Height)+border,p.x + 2*third(p.width)-2*border,p.y + 2*third(p.Height)-2*border);
  WhileFig: ;
  StartFig: ;
  untilFig: ;
end;
//Rectan:=Rect(p.x+border,p.y+border,p.x + p.width-2*border,p.y + p.Height-2*border);
cap:=(p.Txt);
//cap:=TextUtil(cap);
TextW:=pb1.Canvas.TextWidth(cap);
TextH:=pb1.Canvas.TextHeight(cap);
TX:=half(p.width)-half(TextW)+p.x;
TY:=half(p.Height)-half(TextH)+p.y;
pb1.Canvas.Brush.Style:=bsClear;
pb1.Canvas.TextRect(Rectan,cap,[tfVerticalCenter ,tfNoPrefix,tfWordBreak]);
pb1.Canvas.Brush.Style:=oldStyle;
end;

 function IsEmptyTXT(p:TFigureInfo):Boolean;
 begin
 Result:=False;
   if p.Txt= ''  then
   result:=True;
 end;

 procedure HorizontalAdjust(head: PFigList; NewSize:PFigList);
 var temp:PFigList;
 begin

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
  InsertTXT(pb1,p);
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
//Draws  semicircle around Input Rectangle
procedure drawEllipse(pb1:TPaintBox;x,y,width,height:Integer);
var R:Integer;
begin
R:=half(height);
with pb1.Canvas do
  begin
   Arc(x,y,x+height,y+height,x+R,y,x+R,y+height);
   Arc(x+width-height,y,x+width,y+height,x+width-R,y+height,x+width-R,y);
   MoveTo(x+r,y);
   LineTo(x+width-r,y);
   MoveTo(x+r,y+height);
   LineTo(x+width-r,y+height);
   end;
end;

procedure defaultDraw(head:PFigList;pb1:TPaintBox);
var p:TFigureInfo;
  x,y:integer;
  TX,TY:Integer;
  TextW,TextH: Integer;
begin
 pb1.canvas.Pen.Width:=3;
  with pb1.Canvas do
  begin
  drawEllipse(pb1,head.Info.x ,head.Info.y,Head.info.width,Head.Info.Height);
  //drawEllipse(pb1,p.x ,p.y,100,50);
  p.Txt:=strBegin;
  TextW:=pb1.Canvas.TextWidth(strBegin);
  TextH:=pb1.Canvas.TextHeight(strBegin);
  TX:=head.Info.x+half(Head.info.width)-half(TextW);
  TY:=head.Info.y+half(Head.Info.Height)-half(TextH);
  pb1.Canvas.Brush.Style:=bsClear;
  TextOut(TX,TY,strBegin);
  pb1.Canvas.Brush.Style:=bsSolid;
//  p.FigType:=TaskFig;
 // InsertTXT(pb1,p);
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
        //InsertTXT(pb1,p);
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

procedure DrawBlocks(pb1:TPaintBox; head:PFigList;var maxX,maxY:integer);
var temp,temphead:PFigList;
var isRight:boolean;
var inp,outp:PFigList;
var flag:Boolean;
begin
  maxX:=0;
  maxY:=0;
    isRight:=False;
   temp:=head;
   if temp.R<>nil  then
      begin
      isRight:=true;
      temphead:=temp.R;
      DrawArrow(pb1,temp.r.info,temp.info,isRight);
      DrawFigure(pb1,temphead.info,clblack);
      DrawBlocks(pb1,temp.R,maxX,maxY);
      isRight:=false;
        if temp.Info.x > maxX then
        maxX:=temp.Info.x;
     end;
   while (temp^.Adr<>nil)  do
   begin
     outp:=temp;
     temp:=temp^.Adr;
   //TFigType = (TaskFig,IfFig,WhileFig,StartFig,untilFig);

      if temp.Info.y > maxY  then
        maxY:=temp.Info.y;
    DrawFigure(pb1,temp.Info,clBlack);
    inp:=temp;
      DrawArrow(pb1,inp.info,outp.info,isRight);
      if temp.R<>nil  then
      begin
      isRight:=true;
      temphead:=temp.R;
      DrawArrow(pb1,temp.r.info,temp.info,isRight);
      DrawFigure(pb1,temphead.info,clblack);
      DrawBlocks(pb1,temp.R,maxX,maxY);
      isRight:=false;
      end;
   end;
end;

procedure DrawDirectArrows(pb1:TPaintBox; p:TFigureInfo; left:boolean);
var x,y:Integer;
var arrow:TArrowInfo;
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
 drawA(pb1,arrow,clBlue);
end;



end.
