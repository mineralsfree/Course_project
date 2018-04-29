unit Types_const;

interface

const strBegin = 'BEGIN';
  FieldLeft:Integer = 0;
  FieldTop:Integer = 0;
  FieldWidth:Integer = 750;
  FieldHeight:Integer = 1500;
  RectMinWidth:Integer = 150;
  RectMinHeight:Integer = 100;
  offset:Integer = 75;
  startX:Integer = 20;
  startY:Integer = 20;
  Radius:Integer = 30;
  arrowk:Integer = 12;
  arrAngel: real = Pi/6;
type

   TFigType = (TaskFig,IfFig,WhileFig,StartFig,untilFig);
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
  Txt: string[255];
  x,width,y,Height,level:integer;
  FigType: TFigType;
  end;
  PFigList = ^FigList;
  FigList = record
    Info: TFigureInfo;
    Adr: PFigList;
    L: PFigList;
    R: PFiglist;
  end;
implementation

end.
