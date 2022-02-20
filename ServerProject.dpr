program ServerProject;

uses
  Vcl.Forms,
  ServerUnit in 'ServerUnit.pas' {ServerForm},
  CommUnit in 'CommUnit.pas';

{$R *.res}

begin
  Application.Initialize;
  Application.MainFormOnTaskbar := True;
  Application.CreateForm(TServerForm, ServerForm);
  Application.Run;
end.
