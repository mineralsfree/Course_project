unit Lists;

interface


uses System.SysUtils,Types_const;
  function GetClickFig(x,y:integer; const head:PFigList; var selected:Boolean):TFigureInfo;
  procedure createFigureHead(var head:PFigList);
  procedure insertFigure(head:PFigList; points:TFigureInfo;isleft:Boolean);
  procedure createArrowHead(var head:PArrowList);
  procedure insertArow(head:PArrowList; p:TArrowInfo);
  function GetY2(const head:PFigList):Integer;

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
  head.Info.level:=0;
end;


procedure createArrowHead(var head:PArrowList);
begin
  new(head);
  head.Adr:=nil;
end;
procedure insertFigure(head:PFigList; points:TFigureInfo;isleft:Boolean);
var temp:PFigList;
begin
  temp:=head;
  while temp^.Adr<> nil do
    temp:=temp^.Adr;
  new(temp^.Adr);
  temp:=temp^.Adr;
  temp^.Adr:=nil ;
  temp^.Info:=points;
end;
procedure insertArow(head:PArrowList; p:TArrowInfo);
var temp:PArrowList;
begin
  temp:=head;
  while temp^.Adr<> nil do
    temp:=temp^.Adr;
  new(temp^.Adr);
  temp:=temp^.Adr;
  temp^.Adr:=nil;
  temp^.Info:=p;
end;
function GetClickFig(x,y:integer; const head:PFigList; var selected:Boolean):TFigureInfo;
var temp:PfigList;
begin
    temp:=head;
  while temp<> nil do
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
end.

