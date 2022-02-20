program ClientProject;

uses
  Vcl.Forms,
  ClientUnit in 'ClientUnit.pas' {ClientForm};

{$R *.res}

begin
  Application.Initialize;
  Application.MainFormOnTaskbar := True;
  Application.CreateForm(TClientForm, ClientForm);
  Application.Run;
end.
