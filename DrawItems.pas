unit DrawItems;

interface

uses 	 System.SysUtils,System.Types, Types_const,Vcl.Graphics,Lists,Vcl.ExtCtrls,vcl.Dialogs,Vcl.StdCtrls,StrUtils;
procedure DrawBlocks(canv:TCanvas; head:PFigList; var maxX,maxY:integer; ifst:TIfStates);
procedure defaultDraw(head:PFigList;canv:TCanvas);
procedure DrawDirectArrows(canv:TCanvas; p:TFigureInfo; left:boolean; ifState:TIfStates);
procedure drawRect(canv:TCanvas;p:TFigureInfo;Color:Tcolor);
 procedure InsertTXT(canv:TCanvas;var p:TFigureInfo);
 procedure drawend(head:PFigList; Canvas:TCanvas);
function IsEmptyTXT(p:TFigureInfo):Boolean;
  function MaxLength(canv:TCanvas;kek:string):integer;
procedure DrawArrow(canv:TCanvas; inp,outp:TFigureInfo;isRight:Boolean;ifstate:TIfStates);
procedure DrawRectEx(const Canvas: TCanvas; const Rect: TRect;
  Text: string);


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
  function MaxLength(Canv:TCanvas;kek:string):integer;
var str:String;
temp:Integer;
begin
  Str:='';
  result:=0;
  while pos(' ',kek)<>0 do
  begin
    if Pos(' ',kek)>length(str) then
    str:=Copy(kek,0,pos(' ',kek));
    Delete(kek,Pos(' ',kek),Pos(' ',kek)+1);
  end;
  if length(kek)>Result then
  str:=kek;
  Result:=Canv.TextWidth(str);
end;
  function CenterText(canv:TCanvas;Rect:TRect;H,W,L:Integer; Cap:string):TRect;
  var FullH,FullW,adjustH,adjustL:integer;
  begin

  FullW:=MaxLength(canv,cap);
  adjustL:=Round((Rect.Width-FullW)/2);
  FullH:=L*H+L*3;
  adjustH:=Round((Rect.Height-Fullh)/2);
  result.Top:=rect.Top+adjustH;
  Result.Bottom:=Rect.Bottom-adjustH;
  Result.Left:=Rect.Left{+adjustL};


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
Canv.Brush.Style:=bsClear;
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
{if cap<>'' then
begin
Rectan:=CenterText(canv,Rectan,TextH,TextW,p.Lines,cap);
end;  }
//hDC:=GetDC(canvas.GetParent())
//Canv.TextRect(Rectan,cap,[tfVerticalCenter ,tfNoPrefix,tfWordBreak]);
if cap<>'' then
begin
Drawrectex(canv,Rectan,cap);
end;
//Drawrectex(canv,Rectan,cap);
//pb1.Canvas.FillRect(rectan);
Canv.Brush.Style:=oldStyle;
end;

procedure DrawRectEx(const Canvas: TCanvas; const Rect: TRect;
  Text: string);
var
  i, oldWidth, Width: Integer;
  PoleWidth, PoleWidth2: Integer;
  l, t: Integer;
  CharHeight: Integer;
  s, NewS, TextSpace: string;
begin
  i := 1;
  s := '';

  TextSpace := Text + ' ';              // ������ � ���� ��� ���������� ������
                                        // ����� while

  CharHeight := Canvas.TextHeight('V'); // ������ ��������

  oldWidth := 0;

  PoleWidth := Rect.right-rect.Left;  // ����� ����� ���� ��� ���������
  PoleWidth2 := PoleWidth div 2;        // �������� ����� ����
  t := Rect.Top;                        // ������, �� ������� ��������� ������

  while PosEx(' ', TextSpace, i) <> 0 do
  begin
    NewS := Copy(TextSpace, i, PosEx(' ', TextSpace, i) - i + 1);

    Width := Canvas.TextWidth(NewS);
    if Width + oldWidth < PoleWidth then
    begin
      s := s + NewS;
      Inc(oldWidth, Width);
    end
    else
    begin
      if oldWidth > 0 then
      begin
        // ��������� ������ � ������� ���
        l := PoleWidth2 - oldWidth div 2 + Rect.Left;
        Canvas.TextOut(l, t, s);
        s := NewS;
        oldWidth := Width;
      end
      else
      begin
        // ������ ���� �����
        oldWidth := 0;
        s := '';

        l := PoleWidth2 - Width div 2 + Rect.Left;
        Canvas.TextOut(l, t, NewS);
      end;

      Inc(t, CharHeight);
      if t + CharHeight > Rect.Bottom then
      begin
        oldWidth := 0;
        Break;
      end;
    end;

    // ��������� �����
    i := PosEx(' ', TextSpace, i) + 1;
  end;

  // ����� �������� ������
  if oldWidth > 0 then
  begin
    l := PoleWidth2 - oldWidth div 2 + Rect.Left;
    Canvas.TextOut(l, t, s);
  end;
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
procedure drawend(head:PFigList; Canvas:TCanvas);
var temp:PFigList;
  x,y:integer;
  TX,TY:Integer;
  TextW,TextH: Integer;
begin
temp:=head;
while temp.adr<>nil do
    temp:=temp^.Adr;
TextW:=Canvas.TextWidth(strBegin);
TextH:=Canvas.TextHeight(strBegin);

  with Canvas do
  begin
  MoveTo(temp.Info.x + half(temp.Info.width), temp.Info.y+temp.Info.Height);
  LineTo(PenPos.X,PenPos.Y+offset);
  TX:=startX-radius+half(Head.info.width)-half(TextW);
  TY:=PenPos.Y+half(Head.Info.Height)-half(TextH);
  drawEllipse(Canvas,startX-radius,PenPos.Y, temp.Info.width,2*radius);

  end;
  Canvas.Brush.Style:=bsClear;
  canvas.TextOut(TX,TY,strEnd1);
  Canvas.Brush.Style:=bsSolid;
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
          LineTo(p.x+p.width+offset,p.y-half(offset));
          LineTo(PenPos.X+RectMinWidth,p.y-half(offset));
          LineTo(p.x+p.width+offset+RectMinWidth,p.y);
        end;
        {MoveTo((outp.width+outp.x-half(half(outp.width))),outp.y+half(half(outp.Height)));
             LineTo(inp.x,inp.y-half(offset));
             LineTo(inp.x+half(inp.width),inp.y-half(offset));
             LineTo(inp.x+half(inp.width),inp.y);    }
      end;
      RDOWN:
      begin
      with Canv do
      begin

        {  LineTo(p.x+p.width+offset,p.y-half(offset));
          LineTo(PenPos.X+RectMinWidth,p.y-half(offset));
          LineTo(p.x+p.width+offset,p.y+half(offset));
          }
        MoveTo((p.width+p.x-half(half(p.width))),p.y+3*forth(p.Height));
        LineTo(p.x+p.width+offset,p.y+p.Height+half(offset));
        LineTo(penpos.x+RectMinWidth,penpos.y);
        LineTo(PenPos.X ,penpos.y + half(offset));
        {     MoveTo((outp.width+outp.x-half(half(outp.width))),outp.y+3*forth(outp.Height));
             LineTo(inp.x,inp.y-half(offset));
             LineTo(inp.x+half(inp.width),inp.y-half(offset));
             LineTo(inp.x+half(inp.width),inp.y);}
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
