unit ClientUnit;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, System.Win.ScktComp, Vcl.StdCtrls,
  Vcl.ExtCtrls;

type
  TClientForm = class(TForm)
    Client: TClientSocket;
    Panel1: TPanel;
    Edit1: TEdit;
    Button1: TButton;
    StatusLabel: TLabel;
    Panel2: TPanel;
    Panel3: TPanel;
    Memo1: TMemo;
    Panel4: TPanel;
    Memo2: TMemo;
    Edit2: TEdit;
    Label1: TLabel;
    Button2: TButton;
    Panel5: TPanel;
    Label2: TLabel;
    ListBox1: TListBox;
    procedure FormCreate(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure ClientConnect(Sender: TObject; Socket: TCustomWinSocket);
    procedure ClientDisconnect(Sender: TObject; Socket: TCustomWinSocket);
    procedure Button1Click(Sender: TObject);
    procedure ClientError(Sender: TObject; Socket: TCustomWinSocket;
      ErrorEvent: TErrorEvent; var ErrorCode: Integer);
    procedure Edit1Change(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure Button2Click(Sender: TObject);
    procedure Edit2Change(Sender: TObject);
    procedure ClientRead(Sender: TObject; Socket: TCustomWinSocket);
  private
    { Private declarations }
    ClientName, RecieverName: string;
  public
    { Public declarations }
  end;

var
  ClientForm: TClientForm;

implementation

{$R *.dfm}

procedure TClientForm.Button1Click(Sender: TObject);
begin
  if Client.Active then Client.Close
  else
  if Trim(ClientName)<>'' then Client.Open
  else ShowMessage('Введите имя.');
end;

procedure TClientForm.Button2Click(Sender: TObject);
var
  S: string;
begin
  if Trim(RecieverName)<>'' then
  begin
    S:= 'M'+'<'+ClientName+'>'+ '['+RecieverName+']'+ Memo2.Text;
    Client.Socket.SendText(S);

    Memo1.Lines.Add('<-'+RecieverName+' : '+Memo2.Text);
    Memo2.Clear;
  end else ShowMessage('Введите имя.');
end;

procedure TClientForm.ClientConnect(Sender: TObject; Socket: TCustomWinSocket);
begin
  ClientName:= Trim(Edit1.Text);
  Edit1.Enabled:= false;
  Socket.SendText('I'+ClientName);

  StatusLabel.Caption:=' В сети ';
  Button1.Caption:= 'Выход';
  Button2.Enabled:= true;
  Edit2.Enabled:= true;
  Memo2.Enabled:= true;
end;

procedure TClientForm.ClientDisconnect(Sender: TObject;
  Socket: TCustomWinSocket);
begin
  Socket.SendText('O'+ClientName);

  Edit1.Enabled:= true;
  Edit1.Clear;
  StatusLabel.Caption:=' Не подключен ';
  Button1.Caption:= 'Вход';
  Button2.Enabled:= false;
  Edit2.Clear;
  Edit2.Enabled:= false;
  Memo2.Enabled:= false;

  ListBox1.Clear;
end;

procedure TClientForm.ClientError(Sender: TObject; Socket: TCustomWinSocket;
  ErrorEvent: TErrorEvent; var ErrorCode: Integer);
begin
  ShowMessage('Ошибка подключения '+IntToStr(ErrorCode));
end;

procedure TClientForm.ClientRead(Sender: TObject; Socket: TCustomWinSocket);
var
  S: string;
begin
  S:= Socket.ReceiveText;

  if S[1]='C' then
  begin
    ListBox1.Clear;
    Delete(S,1,1);
    ListBox1.Items.Text:=S;
  end else
  Memo1.Lines.Add(S);
end;

procedure TClientForm.Edit1Change(Sender: TObject);
begin
  ClientName:= Trim(Edit1.Text);
end;

procedure TClientForm.Edit2Change(Sender: TObject);
begin
  RecieverName:= Trim(Edit2.Text);
end;

procedure TClientForm.FormClose(Sender: TObject; var Action: TCloseAction);
begin
  if Client.Active then Client.Close;
end;

procedure TClientForm.FormCreate(Sender: TObject);
begin
  Client.Host:= 'localhost';
  Client.Port:= 6000;
end;

procedure TClientForm.FormShow(Sender: TObject);
begin
  Memo1.SetFocus;
end;

end.
