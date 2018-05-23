unit Types_const;

interface
uses System.classes;
const strBegin = 'BEGIN';
  FieldLeft:Integer = 0;
  FieldTop:Integer = 0;
  FieldWidth:Integer = 750;
  FieldHeight:Integer = 1500;
  RectMinWidth:Integer = 150;
  RectMinHeight:Integer = 100;
  offset:Integer = 75;
  startX:Integer = 50;
  startY:Integer = 20;
  Radius:Integer = 30;
  arrowk:Integer = 12;
  arrAngel: real = Pi/6;
type
  TIfStates = (RUP, RDOWN, DOWN);
   TFigType = (TaskFig,IfFig,WhileFig,StartFig,untilFig, RepeatFig);
   TDirection = (Horizontal, Vertical);

    TArrowInfo = record
    id,x,y,length: integer;
    Direction: TDirection;
    ArrowType:TFigType;
  end;
  PArrowList = ^TArrowList;
  TArrowList = record
    Info: TArrowInfo;
    Adr:PArrowList;
  end;

  TFigureInfo = record
  Txt: string ;
  x,width,y,Height,level,Row:integer;
  FigType: TFigType;
  end;
  PFigList = ^FigList;
  FigList = record
    Info: TFigureInfo;
    Adr: PFigList;
    L: PFigList;
    R: PFiglist;
  end;
  function third(x:integer):integer;
  function half(x:integer):integer;
  function forth(x:integer):integer;

implementation
function half(x:integer):integer;
begin
  result:=Round(x/2)
end;
function third(x:integer):integer;
begin
  result:=Round(x/3)
end;
function forth(x:integer):integer;
begin
  result:=Round(x/4)
end;

end.
