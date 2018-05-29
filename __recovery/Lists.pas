  unit Lists;

  interface

  uses System.SysUtils,Vcl.Graphics,Vcl.ExtCtrls,vcl.Dialogs,Types_const;
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
      function LeftBorn(const head:PFigList;p:TFigureInfo):boolean;
  function GetAdjust(head:PFigList;lvl:integer;p:TFigureInfo;var d:Integer):integer;
  function GetRow(head:PFigList;lvl:integer;p:TFigureInfo):integer;
    procedure SaveFile(const head:PFigList; filename,location:string);
    procedure ReadFile(const head:PFigList; filename,location:string);
  implementation
  procedure SaveFile(const head:PFigList; filename,location:string);
  var temp:PFigList;
  f: TPFile;
procedure saveF(head:PFigList; var f:TPFile);
    var temp:PFigList;
    begin
    if head<>nil then
      begin
      temp:=head;
        while temp<>nil do
        begin
          write(f,temp.Info);

          if temp.R<>nil then
          saveF(temp.R,f);

          if temp.L<>nil then
          saveF(temp.L,f);

          temp:=temp^.Adr;
        end;
      end;
    end;
begin
  Assign(f,filename);
  Rewrite(f);
  saveF(head.adr,f);

end;
procedure ReadFile(const head:PFigList; filename,location:string);
var f:TPFile;
temp2:TFigureInfo;

procedure ReadF(head:PFigList;{temp2:PFigList;} var f:TPFile);
var ttemp,temp:Pfiglist;
temp1:TFigureInfo;
begin
temp:=head;
  if not (Eof(f)) then
  begin
    if temp.Info.RC then
    begin
    ttemp:=temp;
    read(f,temp1);
    New(temp^.R);
    temp:=temp^.R;
    temp^.Adr:=nil;
    temp^.L:=nil;
    temp^.R:=nil;
    temp^.Info:=temp1;
    readf(temp,f);
    temp:=ttemp;
    //if not (Eof(f)) then read(f,temp1);
    end;
    if temp.Info.LC then
    begin
    ttemp:=temp;
    read(f,temp1);
    New(temp^.l);
    temp:=temp^.l;
    temp^.Adr:=nil;
    temp^.L:=nil;
    temp^.R:=nil;
    temp^.Info:=temp1;
    ReadF(temp,F);
    temp:=ttemp;
    //if not (Eof(f)) then read(f,temp1);
    end;
    if temp.info.DC then
    begin
    ttemp:=temp;
    read(f,temp1);
    New(temp^.Adr);
    temp:=temp^.Adr;
    temp^.Adr:=nil;
    temp^.L:=nil;
    temp^.R:=nil;
    temp^.Info:=temp1;
    ReadF(temp,F);
    temp:=ttemp;
   //if not (Eof(f)) then  read(f,temp1);
    end;
  end;
end;
begin
if FileExists(filename) then
begin
  Assignfile(f,filename);
  Reset(f);
 { read(f,temp2);   }
  ReadF(head,{temp2,}f);
end;

end;

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
    head.Info.RC:=False;
    head.Info.LC:=False;
    head.Info.DC:=True;
    head.Info.txt:='';
  end;

  function GetAdjust(head:PFigList;lvl:integer;p:TFigureInfo;var d:Integer):integer;
  var max:Integer;
    function GetAdj(head:PFigList;lvl:integer; var max,d:integer):integer;
    var temp,temphead:Pfiglist;
    begin
    temp:=head;
         while (temp<>nil)  do
         begin
         //TFigType = (TaskFig,IfFig,WhileFig,StartFig,untilFig);
           if (temp.Info.level>lvl) and  (temp.Info.y>max )then
           begin
           max:=temp.Info.y+temp.Info.Height;
           d:=temp.info.row;
           end;
            if temp.R<>nil  then
            begin
              result:=GetAdj(temp.R,lvl,max,d);
            end;
            if temp.L<>nil  then
            begin
              result:=GetAdj(temp.L,lvl,max,d);
            end;
            temp:=temp^.Adr;
         end;
    result:=max;
    end;
  begin
  //d:=1;
  max:=p.y+p.Height;
  result:=GetAdj(head,lvl,max,d)+offset;
  end;
  function eqInfo(a,b:TFigureInfo):Boolean;
  begin
  result:= False;
  if (a.x = b.x) and (a.y = b.y) then
  result:=True;
  end;
  function GetRow(head:PFigList;lvl:integer;p:TFigureInfo):integer;
  var max:Integer;
    function GetR(head:PFigList;lvl:integer; var max:Integer):integer;
    var temp,temphead:Pfiglist;
    begin
    temp:=head;
         while (temp<>nil)  do
         begin
          //if not(eqInfo(p,temp.Info)) then
           begin
         //TFigType = (TaskFig,IfFig,WhileFig,StartFig,untilFig);
           if (temp.Info.level>=lvl) and  (temp.Info.Row>max) and not(eqInfo(p,temp.Info))then
           begin
           max:=temp.Info.Row
           end;

            if temp.R<>nil  then
            begin
              result:=GetR(temp.R,lvl,max);
            end;
            if temp.L<>nil  then
            begin
              result:=GetR(temp.L,lvl,max);
            end;
            temp:=temp^.Adr;
           end;
         end;
    result:=max;
    end;
  begin
  max:=0;
  result:=GetR(head,lvl,max)+1;
  end;

  procedure JustAdjust( head:PFigList);
  var temp,temphead:PFigList;
  begin
  temp:=head;
   while (temp<>nil)  do
   begin
     temp.info.y:=temp.info.y + temp.Info.Height + offset;
     temp.Info.Row:=temp.Info.Row + 1;
     temp:=temp^.Adr;
   end;
  end;
  procedure SetAdjustment(const head:PFigList; lvl,row:Integer);
  var temp,temphead:PFigList;
  begin
       temp:=head;
       while (temp<>nil)  do
       begin
       //TFigType = (TaskFig,IfFig,WhileFig,StartFig,untilFig);
          if {  (temp.info.level < lvl) and }(row <= temp.Info.row) then
          begin
          temp.info.y:=temp.info.y + temp.Info.Height + offset;
          temp.Info.Row:=temp.Info.Row + 1;
          end;
          if temp.R<>nil  then
          begin
            SetAdjustment(temp.R,lvl,row);
          end;
          if temp.L<>nil  then
          begin
            SetAdjustment(temp.L,lvl,row);
           // JustAdjust(temp.L);
          end;
          temp:=temp^.Adr;
       end;
  end;
  function GetParentAdr(const head:PFigList; P:PFigList):PFigList;
    function GetP(const head:PFigList; P:PFiglist):PFigList;
      var temp:PFigList;
      begin
      temp:=head;
      while temp<> nil do
        begin
        if (temp^.Adr = P) or(temp^.L = P) or (temp^.R = P)   then
          begin
          result:=temp;
          exit;
          end;
          if temp.R<>nil then
          begin
            Result:=GetP(temp.R,P);
          end;
          if temp.L<>nil then
          begin
            Result:=GetP(temp.L,P);
          end;

          temp:=temp^.Adr;
        end;
      end;
    begin
    result:=nil;
     result:=GetP(head,p);
    end;
  function GetAdr(const head:PFigList; info:TFigureInfo):PFigList;
      var temp:PFigList;
      begin
      temp:=head;
      while temp<> nil do
        begin
        if (temp^.Info.x = info.x) and (temp^.Info.y = info.y) then
        begin
        result:=temp;
        exit;
        end;
          if temp.R<>nil then
          begin
            Result:=Getadr(temp.R,info);
          end;
           if temp.L<>nil then
          begin
            Result:=Getadr(temp.L,info);
          end;

          temp:=temp^.Adr;
        end;
      end;

   function Levelwidth(head:PFigList; lvl:integer):Integer;
   var temp,temphead:PFigList;
   begin
   //result:=RectMinWidth;
   with TBitmap.Create do        //lol
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
         if temp.L<>nil  then
        begin
        temphead:=temp.L;
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
   { begin
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
    end;      }
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
          if temp.L<>nil then
          begin
          Result:=GClickFig(x,y,temp.L,selected);
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

  procedure DeleteBlock(head: PFigList; P:TFigureInfo);
  var temp,PAdr: PFigList;
  begin
   PAdr:=Getadr(head,P);
   temp:=GetParentAdr(head,PAdr);
   if temp<>nil then
   begin
   if temp.Info.Rc then
   temp.R:=nil;
   if temp.Info.Lc then
   temp.L:=nil;
   if temp.Info.Dc then
   temp.adr:=nil;
   end;
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

    function LeftBorn(const head:PFigList;p:TFigureInfo):boolean;

    var exitbool:boolean;
      function LeftB(const head:PFigList;p:TFigureInfo;var ex:Boolean):boolean;
       var temp,temp2:PFigList;
      begin
        if not(ex) then
        begin
         temp2:=GetAdr(head,p);
         //showmessage(IntToStr(temp2.Info.x));
        temp:=head;
        while temp<> nil do
          begin
            if temp.R<>nil then
            begin
              Result:=LeftB(temp.R,p,ex);
            end;
            if temp.L<>nil then
            begin
              Result:=LeftB(temp.L,p,ex);
            end;
          if (temp^.r = temp2) then
          begin
           result:=True;
           ex:=True;
            Exit;
          end;
            temp:=temp^.Adr;
          end;
        end;
      end;
    begin
    exitbool:=False;
     LeftB(head,p,exitbool);
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

