unit Lists;

interface
uses System.SysUtils;
type

    TPointsInfo = record
    id,x0,y0,x,y: integer;
  end;
  PPointsList = ^TPointsList;
  TPointsList = record
    Info: TPointsInfo;
    Adr:PPointsList;
  end;
  TType = (Def,MetaVar,MetaConst, Line, None);

  TFigureInfo = record
  Txt: string[255];
  x1,x2,y1,y2: integer;

  end;
  PFigList = ^FigList;
  FigList = record
    Info: TFigureInfo;
    Adr: PFigList;
  end;
  procedure createFigureHead(var head:PFigList);
  procedure insertFigure(head:PFigList; points:TFigureInfo);
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
  Result:=temp.Info.y2;
  end
  else
  result:=0;
end;
procedure createFigureHead(var head:PFigList);
begin
  new(head);
  head.Adr:=nil;
end;
procedure insertFigure(head:PFigList; points:TFigureInfo);
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

end.
