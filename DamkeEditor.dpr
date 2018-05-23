program DamkeEditor;

uses
  Vcl.Forms,
  Unit2 in 'Unit2.pas' {Kek},
  Lists in 'Lists.pas',
  DrawItems in 'DrawItems.pas',
  Types_const in 'Types_const.pas';

{$R *.res}

begin
  Application.Initialize;
  Application.MainFormOnTaskbar := True;
  Application.CreateForm(TKek, Kek);
  Application.Run;
end.
