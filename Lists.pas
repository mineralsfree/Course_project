unit Lists;

interface


uses System.SysUtils,Vcl.Graphics,Vcl.ExtCtrls,Types_const;
function aHead(head: PFigList;lol:TFigureInfo):boolean;
procedure DeleteBlock(head: PFigList; P:TFigureInfo);
 function Levelwidth(head:PFigList; lvl:integer):Integer;
procedure SetLevelWidth(var head:PFigList; lvl,width,increment:Integer);
  procedure CreateNode(head:PFigList; points:TFigureInfo; LRec:TFigureInfo);
  function GetClickFig(x,y:integer; const head:PFigList; var selected:Boolean):TFigureInfo;
  procedure createFigureHead(var head:PFigList);
procedure insertFigure({pb1:TPaintBox;}head:PFigList; points:TFigureInfo;LRec:TFigureInfo);
  function GetAdr(const head:PFigList; info:TFigureInfo):PFigList;
   function GetParentAdr(const head:PFigList; P:PFigList):PFigList;
    procedure createleft(head: PFigList;Points:TFigureInfo; LRec:TFigureInfo);
  procedure SetAdjustment(const head:PFigList; lvl,row:Integer);

implementation
procedure createFigureHead(var head:PFigList);
begin
  new(head);
  head.Adr:=nil;
  head.Info.x:=startX-radius;
  head.Info.y:=startY;
  head.Info.width:=RectMinWidth;
  head.Info.Height:=2*radius;
  head.Info.level:=1;
  head.R:=nil;
  head.Info.FigType:=TaskFig;
  head.Info.Row:=0;
end;
procedure SetAdjustment(const head:PFigList; lvl,row:Integer);
var temp,temphead:PFigList;
begin
     temp:=head;
     while (temp<>nil)  do
     begin
     //TFigType = (TaskFig,IfFig,WhileFig,StartFig,untilFig);
        if  (temp.info.level < lvl) and (temp.Info.row>=row) then
        begin
        temp.info.y:=temp.info.y + temp.Info.Height + offset;
        temp.Info.Row:=temp.Info.Row + 1;
        end;

        if temp.R<>nil  then
        begin
          temphead:=temp.R;
          SetAdjustment(temphead,lvl,row);
        end;
        temp:=temp^.Adr;
     end;

end;
 function GetParentAdr(const head:PFigList; P:PFigList):PFigList;
 var temp:PFigList;
  begin
  Result:=nil;
  temp:=head;
  while temp<> nil do
    begin
      if temp.R<>nil then
      begin
        Result:=GetParentAdr(temp.R,P);
      end;
    if (temp^.Adr = P) then result:=temp;
      temp:=temp^.Adr;
    end;
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
 function Levelwidth(head:PFigList; lvl:integer):Integer;
 var temp,temphead:PFigList;
 //var str:
 begin
 //result:=RectMinWidth;
 with TBitmap.Create do
 begin
     temp:=head;
   if (head.Info.level = lvl) and (Canvas.TextWidth(head.Info.Txt)>Result) then
      Result:=Canvas.TextWidth(head.Info.Txt);
   while (temp^.Adr<>nil)  do
   begin

   if (temp.Info.level = lvl) and (Canvas.TextWidth(temp.Info.Txt)>Result) then
      Result:=Canvas.TextWidth(temp.Info.Txt);
      if temp.R<>nil  then
      begin
      temphead:=temp.R;
      if (temphead.Info.level = lvl) and (Canvas.TextWidth(temphead.Info.Txt)>Result) then
        Result:=Canvas.TextWidth(temphead.Info.Txt);
      Result:=Levelwidth(temphead,lvl);
      end;
      temp:=temp^.Adr;
   end;
   if (Result = 0) and (temp.Info.level = lvl) then
    // result:=rectMinWidth;
    Free;
    end;

 end;
procedure insertFigure(head:PFigList; points:TFigureInfo;LRec:TFigureInfo);
var LRecAdr,temp,temp2:PFigList;
begin
  LRecAdr:=getadr(head,LRec);
  if LRecadr.Adr = nil then
  begin
  new(LRecAdr^.Adr);
  temp:=LRecAdr^.Adr;
  temp^.Adr:=nil;
  temp^.L:=nil;
  temp^.R:=nil;
  temp^.Info:=points;
  temp^.Info.Txt:='';
  end
  else
  begin
    temp2:=LRecAdr^.Adr;
      while temp2 <>nil do
    begin
      temp2.Info.y:=temp2.Info.y+points.Height+offset;
      temp2:=temp2^.Adr;
    end;
  temp2:=LRecAdr^.Adr;
  LRecAdr^.Adr:=nil;

  New(LRecAdr^.Adr);
  temp:=LRecAdr^.Adr;
  temp^.L:=nil;
  temp^.R:=nil;
  temp^.Info:=points;
  temp^.Adr:=temp2;
  end;
end;
function GetClickFig(x,y:integer; const head:PFigList; var selected:Boolean):TFigureInfo;
  function GClickFig(x,y:integer; const head:PFigList; var selected:Boolean):TFigureInfo;
  var temp:PfigList;
  begin
    selected:=False;
      temp:=head;
       if (x > temp.Info.x) and
         (x < temp.Info.x+temp.Info.width) and
         (y > temp.Info.y) and
         (y < temp.Info.y + temp.Info.Height)
      then
         begin
          Result:=temp.Info;
          selected:=True;
          Exit;
         end;
    while (temp<> nil) do
      begin
      if temp.R<>nil then
        begin
        Result:=GClickFig(x,y,temp.R,selected);
        if selected then exit;
        end;
        if (x > temp.Info.x) and
           (x < temp.Info.x+temp.Info.width) and
           (y > temp.Info.y) and
           (y < temp.Info.y + temp.Info.Height)
        then
           begin
            Result:=temp.Info;
            selected:=True;
            Exit;
           end
        else temp:=temp^.Adr;

      end;

      if selected then
      Exit;

      Result.x:=-1;
  end;
  begin

    Result:=GClickFig(x,y,head,selected);

  end;
function aHead(head: PFigList;lol:TFigureInfo):boolean;
begin
result:= false;
  if (head.Info.x = lol.x)  and (head.info.y = lol.y) then
  result:=true;
end;
procedure SetLevelWidth(var head:PFigList; lvl,width,increment:Integer);
var temp,temphead:PFigList;
var isRight:boolean;
var max:integer;
begin
    begin
     temp:=head;
     while (temp<>nil)  do
     begin
     //TFigType = (TaskFig,IfFig,WhileFig,StartFig,untilFig);
        if  temp.info.level=lvl then
        temp.info.width:=width;
        if head.Info.level > lvl  then
        head.info.x:=head.info.x+increment;
        if temp.R<>nil  then
        begin
          temphead:=temp.R;
          if  temphead.info.level=lvl then
           temphead.info.width:=width;
          if head.Info.level > lvl  then
           head.info.x:=head.info.x+increment;
          SetLevelWidth(temphead,lvl,width,increment);
        end;
        temp:=temp^.Adr;
     end;
    end;
end;

procedure DeleteBlock(head: PFigList; P:TFigureInfo);
var temp: PFigList;
begin
 temp:=GetParentAdr(head,GetAdr(head,P));
 temp.adr:=nil;
end;
procedure CreateNode(head: PFigList;Points:TFigureInfo; LRec:TFigureInfo);
var LRecAdr,temphead,temp:PFigList;

  begin
  LRecAdr:=getadr(head,LRec);
    {if LRecadr.l = nil then}
    begin
    new(LRecAdr^.R);
    temp:=LRecAdr^.R;
    temp^.L:=nil;
    temp^.Adr:=nil;
    temp^.R:=nil;
    temp^.Info:=points;
    temp^.Info.Txt:='';
    end;
  end;
  procedure createleft(head: PFigList;Points:TFigureInfo; LRec:TFigureInfo);
var LRecAdr,temphead,temp:PFigList;

  begin
  LRecAdr:=getadr(head,LRec);
    {if LRecadr.l = nil then}
    begin
    new(LRecAdr^.L);
    temp:=LRecAdr^.L;
    temp^.L:=nil;
    temp^.Adr:=nil;
    temp^.R:=nil;
    temp^.Info:=points;
    temp^.Info.Txt:='';
    end;
  end;


end.

