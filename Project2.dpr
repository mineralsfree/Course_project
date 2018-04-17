program Project2;

uses
  Vcl.Forms,
  Unit2 in '..\..\Embarcadero\Studio\Projects\Unit2.pas' {Form2},
  Lists in '..\..\Embarcadero\Studio\Projects\Lists.pas';

{$R *.res}

begin
  Application.Initialize;
  Application.MainFormOnTaskbar := True;
  Application.CreateForm(TForm2, Form2);
  Application.Run;
end.
