unit DrawItems;

interface

uses 	 System.SysUtils,System.Types, Types_const,Vcl.Graphics,Lists,Vcl.ExtCtrls,vcl.Dialogs;
procedure DrawBlocks(canv:TCanvas; head:PFigList; var maxX,maxY:integer; ifst:TIfStates);
procedure defaultDraw(head:PFigList;canv:TCanvas);
procedure DrawDirectArrows(canv:TCanvas; p:TFigureInfo; left:boolean; ifState:TIfStates);
procedure drawRect(canv:TCanvas;p:TFigureInfo;Color:Tcolor);
 procedure InsertTXT(canv:TCanvas;var p:TFigureInfo);
function IsEmptyTXT(p:TFigureInfo):Boolean;
procedure DrawArrow(canv:TCanvas; inp,outp:TFigureInfo;isRight:Boolean;ifstate:TIfStates);


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
  procedure InsertTXT(canv:TCanvas;var p:TFigureInfo);
var
  txt:TLabeledEdit;
  TX,TY:Integer;
  TextW,TextH: Integer;
  cap:String;
  Rectan:Trect;
  border:Integer;
  oldStyle:TBrushStyle;
begin
cap:=(p.Txt);
oldStyle:=Canv.Brush.Style;
//pb1.Canvas.Brush.Style:={bsClear;}bsSolid;
border:=2;
TextW:=Canv.TextWidth(cap);
TextH:=Canv.TextHeight(cap);
  case p.FigType of
    TaskFig:
    Rectan:=
    Rect(p.x+border,p.y+border,p.x + p.width-2*border,p.y + p.Height-2*border);
    IfFig: //SuperHard Formula
    Rectan:=
    Rect(p.x+ round(p.width*(TextH/p.Height)),p.y+half(p.height-textH),p.x + p.width-round(p.width*(TextH/p.Height)),p.y+half(p.height-textH)+TextH);
    WhileFig:  Rectan:=
    Rect(p.x+ round(p.width*(TextH/p.Height)),p.y+half(p.height-textH),p.x + p.width-round(p.width*(TextH/p.Height)),p.y+half(p.height-textH)+TextH);
    StartFig: ;
    untilFig: ;
  end;
//Rectan:=Rect(p.x+border,p.y+border,p.x + p.width-2*border,p.y + p.Height-2*border);

//cap:=TextUtil(cap);

TX:=half(p.width)-half(TextW)+p.x;
TY:=half(p.Height)-half(TextH)+p.y;
//pb1.Canvas.Brush.Color:=clRed;
Canv.TextRect(Rectan,cap,[tfVerticalCenter ,tfNoPrefix,tfWordBreak]);
//pb1.Canvas.FillRect(rectan);
Canv.Brush.Style:=oldStyle;
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
 procedure drawRect(canv:TCanvas;p:TFigureInfo;Color:Tcolor);
 var prev:TColor;
begin
  if p.FigType <> IfFig then
   begin
    prev:=Canv.Pen.Color;
    Canv.Pen.Color:=color;
    with Canv do
    begin
      MoveTo(p.x,p.y);
      LineTo(p.x,p.y + p.Height);
      LineTo(p.x +p.width,p.y + p.Height);
      LineTo(p.x +p.width,p.y);
      LineTo(p.x,p.y);
    end;
    Canv.Pen.Color:=prev;
    InsertTXT(canv,p);
   end;
end;

procedure drawA(canv:TCanvas;p:TArrowInfo; Color:TColor);
var x,y:Integer;
var prevColor:TColor;
begin
  prevColor:=Canv.Pen.Color;
  Canv.Pen.Color:=Color;
  x:=Round(arrowk*sin(arrAngel));
  y:=Round(arrowk*cos(arrAngel));
  with Canv do
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
    Canv.Pen.Color:=prevColor;
  end;
end;
//Draws  semicircle around Input Rectangle
procedure drawEllipse(canv:TCanvas;x,y,width,height:Integer);
var R:Integer;
begin
R:=half(height);
with Canv do
  begin
   Arc(x,y,x+height,y+height,x+R,y,x+R,y+height);
   Arc(x+width-height,y,x+width,y+height,x+width-R,y+height,x+width-R,y);
   MoveTo(x+r,y);
   LineTo(x+width-r,y);
   MoveTo(x+r,y+height);
   LineTo(x+width-r,y+height);
   end;
end;

procedure defaultDraw(head:PFigList;canv:TCanvas);
var p:TFigureInfo;
  x,y:integer;
  TX,TY:Integer;
  TextW,TextH: Integer;
begin
 canv.Pen.Width:=3;
  with Canv do
  begin
  drawEllipse(canv,head.Info.x ,head.Info.y,Head.info.width,Head.Info.Height);
  //drawEllipse(pb1,p.x ,p.y,100,50);
  p.Txt:=strBegin;
  TextW:=Canv.TextWidth(strBegin);
  TextH:=Canv.TextHeight(strBegin);
  TX:=head.Info.x+half(Head.info.width)-half(TextW);
  TY:=head.Info.y+half(Head.Info.Height)-half(TextH);
  Canv.Brush.Style:=bsClear;
  TextOut(TX,TY,strBegin);
  Canv.Brush.Style:=bsSolid;
//  p.FigType:=TaskFig;
 // InsertTXT(pb1,p);
  end;
end;

procedure DrawIF(canv:TCanvas; p:TFigureInfo; color:TColor);
var prev:TColor;
begin
prev:=Canv.Pen.Color;
  Canv.Pen.Color:=color;
  with Canv do
  begin
    MoveTo(p.x+half(p.width),p.y);
    LineTo(p.x+p.width,p.y + half(p.Height));
    LineTo(p.x +half(p.width),p.y + p.Height);
    LineTo(p.x ,p.y+half(p.Height));
    LineTo(p.x+half(p.width),p.y);
  end;
  InsertTXT(canv,p);
  Canv.Pen.Color:=prev;
end;

procedure DrawWhile(canv:TCanvas; p:TFigureInfo; color:TColor);
var prev:TColor;
begin
prev:=Canv.Pen.Color;
  Canv.Pen.Color:=color;
  with Canv do
  begin
    MoveTo(p.x+forth(p.width),p.y);
    LineTo(p.x+3*forth(p.width),p.y);
    LineTo(p.x+p.width,p.y + half(p.Height));
    LineTo(p.x +3*forth(p.width),p.y + p.Height);
    LineTo(p.x +forth(p.width),p.y + p.Height);
    LineTo(p.x ,p.y+half(p.Height));
    LineTo(p.x+forth  (p.width),p.y);
  end;
  InsertTXT(canv,p);
  Canv.Pen.Color:=prev;
end;

procedure DrawFigure(canv:TCanvas; p:TFigureInfo; color:TColor);
begin
  case p.FigType of
      TaskFig:
        begin
        drawRect(canv,p,color);

        end;
        IfFig:
        begin
        DrawIF(canv,p,color);
        end;
        WhileFig:
        begin
        drawWhile(canv,p,color);
        end;
        RepeatFig:
        begin
        DrawWhile(canv,p,color);
        end;

  end;

end;

procedure DrawBlocks(canv:TCanvas; head:PFigList; var maxX,maxY:integer; ifst:TIfStates);
var temp,temphead:PFigList;
var isRight:boolean;
var inp,outp:PFigList;
var flag:Boolean;
begin
  maxX:=0;
  maxY:=0;
    isRight:=False;
   temp:=head;
   if temp.Info.x > maxX then
        maxX:=temp.Info.x;
   if temp.R<>nil  then
      begin
      isRight:=true;
      temphead:=temp.R;
      DrawArrow(canv,temp.r.info,temp.info,isRight,ifst);
      DrawFigure(canv,temphead.info,clblack);
      DrawBlocks(canv,temp.R,maxX,maxY,ifst);
      isRight:=false;
        if temp.Info.x > maxX then
        maxX:=temp.Info.x;
     end;
     if temp.L<>nil  then
      begin
      isRight:=true;
      temphead:=temp.l;
      DrawArrow(canv,temp.l.info,temp.info,isRight,ifst);
      DrawFigure(canv,temphead.info,clblack);
      DrawBlocks(canv,temp.l,maxX,maxY,ifst);
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
      if temp.Info.x > maxX then
        maxX:=temp.Info.x;
    DrawFigure(canv,temp.Info,clBlack);
    inp:=temp;
      DrawArrow(canv,inp.info,outp.info,isRight,ifst);
      if temp.R<>nil  then
      begin
      isRight:=true;
      temphead:=temp.R;
      DrawArrow(canv,temp.r.info,temp.info,isRight,ifst);
      DrawFigure(canv,temphead.info,clblack);
      DrawBlocks(canv,temp.R,maxX,maxY,ifst);
      isRight:=false;
      end;
      if temp.L<>nil  then
      begin
      isRight:=true;
      temphead:=temp.l;
      DrawArrow(canv,temp.l.info,temp.info,isRight,ifst);
      DrawFigure(canv,temphead.info,clblack);
      DrawBlocks(canv,temp.l,maxX,maxY,ifst);
      isRight:=false;
      end;
   end;
end;

procedure DrawDirectArrows(canv:TCanvas; p:TFigureInfo; left:boolean; ifState:TIfStates);
var x,y:Integer;
var arrow:TArrowInfo;
var predC: TColor;
begin
predC:=Canv.Pen.Color;
Canv.Pen.Color:=clBlue;
case p.FigType of
  TaskFig: ;
  IfFig:
  begin
    case ifState of
        RUP:
      begin
        with Canv do
        begin
          MoveTo((p.width+p.x-half(half(p.width))),p.y+half(half(p.Height)));
          LineTo(p.x+p.width+2*offset,p.y-half(offset));
          LineTo(p.x+p.width+2*offset+Rectminwidth+half(RectMinWidth),p.y-half(offset));
          LineTo(p.x+p.width+2*offset+Rectminwidth+half(RectMinWidth),p.y);
        end;
      end;
      RDOWN:
      begin
      with Canv do
      begin
        MoveTo((p.width+p.x-half(half(p.width))),p.y+3*forth(p.Height));
        LineTo(p.x+p.width,PenPos.y+forth(p.height));
        LineTo(penpos.x+RectMinWidth,penpos.y);
        LineTo(PenPos.X ,penpos.y + offset);
      end;
      end;
      DOWN:
      begin
      arrow.Direction:=Vertical;
      arrow.x:=p.x+half(p.width);
      arrow.y:=p.y+p.Height;
      arrow.length:=offset;
       drawA(canv,arrow,clBlue);
      end
  end;
  end;
{  WhileFig:
  begin
  with pb1.Canvas do
      begin
        MoveTo((p.width+p.x-half(half(p.width))),p.y+3*forth(p.Height));
        LineTo(p.x+p.width,PenPos.y+forth(p.height));
        LineTo(penpos.x+RectMinWidth,penpos.y);
        LineTo(PenPos.X ,penpos.y + offset);
      end;
  end;       }
  StartFig: ;
  untilFig: ;
  RepeatFig: ;
end;
if p.FigType = IfFig then
  begin

   end
else
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
     drawA(canv,arrow,clBlue);
   end;
   Canv.Pen.Color:=predC;
end;


  procedure DrawArrow(canv:TCanvas; inp,outp:TFigureInfo;isRight:Boolean;ifstate:TIfStates);
  var x,y:Integer;
  begin
   if isRight then
   begin
    x:=inp.x;
    y:=inp.y+half(inp.Height);
    with Canv do
          begin
        case outp.FigType of
          taskFig:
          begin
          MoveTo((outp.width+outp.x),outp.y+half(outp.Height));
          LineTo(x,y);
            end;
          IfFig:
           begin
           if (outp.x < inp.x) and(outp.y =  inp.y)  then
             begin                            //3/4
             MoveTo((outp.width+outp.x-half(half(outp.width))),outp.y+half(half(outp.Height)));
             LineTo(inp.x,inp.y-half(offset));
             LineTo(inp.x+half(inp.width),inp.y-half(offset));
             LineTo(inp.x+half(inp.width),inp.y);
              end;
            if (outp.x < inp.x) and(outp.y < inp.y)  then
             begin                             //3/4
             MoveTo((outp.width+outp.x-half(half(outp.width))),outp.y+3*forth(outp.Height));
             LineTo(inp.x,inp.y-half(offset));
             LineTo(inp.x+half(inp.width),inp.y-half(offset));
             LineTo(inp.x+half(inp.width),inp.y);
              end;
           end;
           WhileFig:
           begin
            MoveTo((outp.width+outp.x -half(forth(outp.width))),outp.y+3*forth(outp.Height));
             LineTo(inp.x,inp.y-half(offset));
             LineTo(inp.x+half(inp.width),inp.y-half(offset));
             LineTo(inp.x+half(inp.width),inp.y);
           end;
           RepeatFig:
           begin
              MoveTo((outp.width+outp.x-half(forth(outp.width))),outp.y+half(half(outp.Height)));
             LineTo(inp.x,inp.y-half(offset));
             LineTo(inp.x+half(inp.width),inp.y-half(offset));
             LineTo(inp.x+half(inp.width),inp.y);
           end;
        end;
       end;
   end
   else
   begin
    x:=half(inp.width)+inp.x;
    y:=inp.y;
     with Canv do
        begin
     case outp.FigType of
      taskFig:
      begin
          MoveTo((half(outp.width)+outp.x),outp.y+outp.Height);
          LineTo(x,y);
      end;
      IfFig:
      Begin
      MoveTo((half(outp.width)+outp.x),outp.y+outp.Height);
      LineTo(x,y);
      End;
      WhileFig:
      begin
        MoveTo((half(outp.width)+outp.x),outp.y+outp.Height);
         LineTo(x,y);
      end;
      RepeatFig:
      begin
        MoveTo((half(outp.width)+outp.x),outp.y+outp.Height);
         LineTo(x,y);
      end;
     end;

     end;
   end;
  end;


end.
