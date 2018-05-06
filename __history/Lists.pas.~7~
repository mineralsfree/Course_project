unit Lists;

interface


uses System.SysUtils,Vcl.Graphics,Vcl.ExtCtrls,Types_const;
  procedure CreateNode(head:PFigList; points:TFigureInfo; LRec:TFigureInfo);
  function GetClickFig(x,y:integer; const head:PFigList; var selected:Boolean):TFigureInfo;
  procedure createFigureHead(var head:PFigList);
procedure insertFigure({pb1:TPaintBox;}head:PFigList; points:TFigureInfo;LRec:TFigureInfo);
  function GetY2(const head:PFigList):Integer;
  procedure DrawArrow(pb1:TPaintBox; inp,outp:TFigureInfo;isRight:Boolean);
implementation
function GetY2(const head:PFigList):Integer;
var temp:PFigList;
begin
  temp:=head;
  if   temp^.Adr<> nil then
  begin
  while temp^.Adr<> nil do
    temp:=temp^.Adr;
  Result:=temp.Info.y+temp.Info.Height;
  end
  else
  result:=80;
end;
procedure createFigureHead(var head:PFigList);
begin
  new(head);
  head.Adr:=nil;
  head.Info.x:=startX;
  head.Info.y:=startY;
  head.Info.width:=RectMinWidth;
  head.Info.Height:=2*radius;
  head.Info.level:=1;
  head.R:=nil;
  head.Info.FigType:=TaskFig;
end;
 function GetAdr(const head:PFigList; info:TFigureInfo):PFigList;
  var temp:PFigList;
  begin
  Result:=nil;
  temp:=head;
  while temp<> nil do
    begin
      if temp.R<>nil then
      begin
        Result:=Getadr(temp.R,info);
      end;
    if (temp^.Info.x = info.x) and (temp^.Info.y = info.y) then result:=temp;
      temp:=temp^.Adr;
    end;
  end;

procedure insertFigure({pb1:TPaintBox;}head:PFigList; points:TFigureInfo;LRec:TFigureInfo);
var LRecAdr,temp:PFigList;
begin
  LRecAdr:=getadr(head,LRec);

  new(LRecAdr^.Adr);
  temp:=LRecAdr^.Adr;

  temp^.Adr:=nil;
  temp^.L:=nil;
  temp^.R:=nil;
  temp^.Info:=points;

end;
function GetClickFig(x,y:integer; const head:PFigList; var selected:Boolean):TFigureInfo;
var temp:PfigList;
begin
    temp:=head;
  while (temp<> nil) do
    begin
    if temp.R<>nil then
      begin
      Result:=GetClickFig(x,y,temp.R,selected);
      end;
    if (x > temp.Info.x) and
       (x < temp.Info.x+temp.Info.width) and
       (y > temp.Info.y) and
       (y < temp.Info.y + temp.Info.Height)
    then
       begin
        Result:=temp.Info;
        selected:=True;
        exit;
       end
    else temp:=temp^.Adr;
    selected:=False;
    end;

    end;



procedure CreateNode(head: PFigList;Points:TFigureInfo; LRec:TFigureInfo);
var LRecAdr,temphead,temp:PFigList;

  begin
  LRecAdr:=getadr(head,LRec);
    new(LRecAdr^.R);

    temp:=LRecAdr^.R;

    temp^.L:=LRecAdr;
    temp^.Adr:=nil;
    temp^.R:=nil;
    temp^.Info:=points;
    temp^.Info.level:=LRec.level+1;



  end;

  procedure DrawArrow(pb1:TPaintBox; inp,outp:TFigureInfo;isRight:Boolean);
  var x,y:Integer;
  begin
   if isRight then
   begin
    x:=inp.x;
    y:=inp.y+half(inp.Height);
      case outp.FigType of
        taskFig:
        begin
        with pb1.Canvas do
          begin
            MoveTo((outp.width+outp.x),outp.y+half(outp.Height));
            LineTo(x,y);
          end;
        end;

       end;
   end
   else
   begin
    x:=half(inp.width)+inp.x;
    y:=inp.y;
     case outp.FigType of
      taskFig:
      begin
      with pb1.Canvas do
        begin
          MoveTo((half(outp.width)+outp.x),outp.y+outp.Height);
          LineTo(x,y);
        end;
      end;

     end;

     end;
   end;
end.

