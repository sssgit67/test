unit ServerUnit;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, System.Win.ScktComp, Vcl.StdCtrls,
  Vcl.ExtCtrls, System.StrUtils, CommUnit;

type

  TServerForm = class(TForm)
    Server: TServerSocket;
    Panel1: TPanel;
    Panel2: TPanel;
    Panel3: TPanel;
    Label1: TLabel;
    ListBox1: TListBox;
    StatusLabel: TLabel;
    Label2: TLabel;
    Memo1: TMemo;
    Panel4: TPanel;
    Timer1: TTimer;
    Button1: TButton;
    Button2: TButton;
    Panel5: TPanel;
    Button3: TButton;
    Button4: TButton;
    procedure FormCreate(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure ServerClientConnect(Sender: TObject; Socket: TCustomWinSocket);
    procedure ServerClientDisconnect(Sender: TObject; Socket: TCustomWinSocket);
    procedure ServerClientRead(Sender: TObject; Socket: TCustomWinSocket);
    procedure Timer1Timer(Sender: TObject);
    procedure Button2Click(Sender: TObject);
    procedure Button1Click(Sender: TObject);
    procedure Button3Click(Sender: TObject);
    procedure Button4Click(Sender: TObject);
  private
    { Private declarations }
    Clients: TStringList;
    ClientsTable: array of TClientsRec;
    Buffer: TCommunicator;

    function ExtractCmd(var S: string): string;
    procedure MemberIn(S: string);
    procedure MemberOut(S: string);
    procedure PutBuffer(S: string);
    procedure CheckClientName(S: string; ASocket: TCustomWinSocket);
    procedure PublicMsg;

    {Debug}
    procedure ShowClientsTable;
    procedure ShowConnections;
    procedure ShowBuffer;
  public
    { Public declarations }
  end;

var
  ServerForm: TServerForm;
  AComm:  TCommunicatorRec;

implementation

{$R *.dfm}

procedure TServerForm.ShowClientsTable;
var
  i: integer;
begin
  for i:= low(ClientsTable) to high(ClientsTable) do
  begin
    Memo1.Lines.Add('ClientsTable : '+inttostr(i)+'['+ClientsTable[i].Name+']'+ClientsTable[i].Addr+':'+ inttostr(ClientsTable[i].Port));
  end;  Memo1.Lines.Add('-------- clients end ---------');
end;

procedure TServerForm.ShowConnections;
var
  i: integer;
begin
  for i:= 0 to Server.Socket.ActiveConnections-1 do
  begin
    Memo1.Lines.Add('connections : '+inttostr(i)+'>'+Server.Socket.Connections[i].RemoteAddress+':'+ inttostr(Server.Socket.Connections[i].RemotePort));
  end;  Memo1.Lines.Add('--------- sockets end ---------');
end;

procedure TServerForm.ShowBuffer;
var
  i: integer;
begin
  for i:=0 to Buffer.BufferLength-1 do
  begin
    Buffer.Position:= i;
    AComm:= Buffer.Pop;
    Memo1.Lines.Add('buffer : '+inttostr(i)+' = '+AComm.SenderName+'->'+AComm.RecieverName+' : '+AComm.MessageString)
  end;  Memo1.Lines.Add('--------- buffer end -----------');
end;

procedure TServerForm.PublicMsg;
begin
  Memo1.Lines.Add(AComm.SenderName+'->'+AComm.RecieverName+' : '+AComm.MessageString);
end;

function TServerForm.ExtractCmd(var S: string): string;
begin
  Result:= S;
  Delete(Result,1,1);
  case S[1] of
    'I': MemberIn(Result);
    'O': MemberOut(Result);
    'M': PutBuffer(Result);
  end;
end;

procedure TServerForm.MemberIn(S: string);
var
  i: integer;
begin
  if Clients.IndexOf(S)=-1 then
  begin
    Clients.Add(S);
    ListBox1.Items.Add(S);
    ClientsTable[high(ClientsTable)].Name:= S;

    for i := Low(ClientsTable) to High(ClientsTable) do
    Server.Socket.Connections[i].SendText('C'+ListBox1.Items.Text);
  end
  else
  begin
    Server.Socket.Connections[Server.Socket.ActiveConnections-1].Close;
    ShowMessage('Уже в сети. Выберите другое имя.');
  end;
end;

procedure TServerForm.MemberOut(S: string);
begin
  ListBox1.Items.Delete(ListBox1.Items.IndexOf(S));
  Clients.Delete(Clients.IndexOf(S));
end;

procedure TServerForm.PutBuffer(S: string);
var
  s1, s2, s3: string;
begin
//имя ClientName <от кого>
  delete(S,1,pos('<',S));
  s3:=copy(S,1,pos('>',S)-1);
//имя RecieverName [кому]
  delete(S,1,pos('[',S));
  s1:=copy(S,1,pos(']',S)-1);
//текст сообщения
  s2:= RightStr(S,Length(S)-Pos(']',S)) ;

  Buffer.Push(s3, s1, s2);
end;

procedure TServerForm.FormClose(Sender: TObject; var Action: TCloseAction);
begin
  Clients.Free;
  Buffer.Free;
  ClientsTable:= nil;

  Server.Close;
end;

procedure TServerForm.FormCreate(Sender: TObject);
begin
  Server.Port:= 6000;
  Server.Open;
  if  Server.Active then
  StatusLabel.Caption:= '  '+Server.Socket.LocalHost+'  '+
  Server.Socket.LocalAddress+' : '+IntToStr(Server.Socket.LocalPort)
  else
  StatusLabel.Caption:= 'Сервер не запущен';

   Clients:= TStringList.Create;
   Buffer:= TCommunicator.Create;
   ClientsTable:= nil;
   AComm.Clear;
end;

procedure TServerForm.ServerClientConnect(Sender: TObject;
  Socket: TCustomWinSocket);
begin
  SetLength(ClientsTable, length(ClientsTable)+1);
  ClientsTable[high(ClientsTable)].Name:= '';
  ClientsTable[high(ClientsTable)].Addr:= Socket.RemoteAddress;
  ClientsTable[high(ClientsTable)].Port:= Socket.RemotePort;
  Label1.Caption:= 'В сети - '+IntToStr(length(ClientsTable));
end;

{$R-}
procedure TServerForm.ServerClientDisconnect(Sender: TObject;
  Socket: TCustomWinSocket);
var
  i: integer;
begin
  for i := Low(ClientsTable) to High(ClientsTable) do
  begin
    if ((ClientsTable[i].Addr = Socket.RemoteAddress) and
    (ClientsTable[i].Port = Socket.RemotePort))
    then
    begin
      ClientsTable[i]:= ClientsTable[high(ClientsTable)];
      SetLength(ClientsTable,Length(ClientsTable)-1);
    end;
  end;

  Label1.Caption:= 'В сети - '+IntToStr(length(ClientsTable));

  for i := 0 to Server.Socket.ActiveConnections-1 do
  Server.Socket.Connections[i].SendText('C'+ListBox1.Items.Text);
end;
{$R+}

procedure TServerForm.Button1Click(Sender: TObject);
begin
  ShowClientsTable;
end;

procedure TServerForm.Button2Click(Sender: TObject);
begin
  ShowConnections;
end;

procedure TServerForm.Button3Click(Sender: TObject);
begin
  Memo1.Clear;
end;

procedure TServerForm.Button4Click(Sender: TObject);
begin
  ShowBuffer;
end;

procedure TServerForm.CheckClientName(S: string; ASocket: TCustomWinSocket);
var
  i: integer;
  s1: string;
begin
  if S[1]='M' then
  begin
// 'M'+'<'+ClientName+'>'+ '['+RecieverName+']'+ Memo2.Text
    delete(S,1,pos('<',S));
    s1:=copy(S,1,pos('>',S)-1);
    for i := Low(ClientsTable) to High(ClientsTable) do
    if ((ClientsTable[i].Addr = ASocket.RemoteAddress) and
    (ClientsTable[i].Port = ASocket.RemotePort))
    then ClientsTable[i].Name:= s1;
  end;
end;

procedure TServerForm.ServerClientRead(Sender: TObject;
  Socket: TCustomWinSocket);
var
  S,SS: string;
begin
  S:= Socket.ReceiveText;
  SS:=S;
  CheckClientName(SS, Socket);
  S:= ExtractCmd(S);
end;

procedure TServerForm.Timer1Timer(Sender: TObject);
var
  i,j: integer;
begin
  Button4.Caption:= 'Очередь - '+IntToStr(Buffer.BufferLength);

  if not Buffer.Empty then
  for i := Low(ClientsTable) to High(ClientsTable) do
  begin
    for j:=0 to Buffer.BufferLength-1 do
    begin
      Buffer.Position:= j;
      AComm:= Buffer.Pop;
      if AComm.RecieverName = ClientsTable[i].Name then
      begin
        Server.Socket.Connections[i].SendText('->'+AComm.SenderName+' : '+AComm.MessageString);
        Buffer.DelPosition(j);
        PublicMsg;
      end;
    end;
  end;

end;

end.
