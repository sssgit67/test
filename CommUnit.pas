unit CommUnit;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes;


type

  TClientsRec = record
    Name: string;
    Addr: string;
    Port: integer;
  end;

  TCommunicatorRec = record
    SenderName: string;
    RecieverName: string;
    MessageString: string;

    procedure Clear;
  end;

  TCommunicator = class
  private
    FBuffer: array of TCommunicatorRec;
    FEmpty: boolean;
    FPosition: integer;
    FBufferLength: integer;

    function GetBufferLength: integer;
  public
    constructor Create;
    destructor Destroy; override;

    procedure Push(ASenderName, ARecieverName, AMessageString: string);
    function Pop: TCommunicatorRec;
    procedure DelPosition(APos: integer);

    property Empty: boolean read FEmpty;
    property Position: integer read FPosition write FPosition;
    property BufferLength: integer read GetBufferLength;
  end;

implementation

procedure TCommunicatorRec.Clear;
begin
  Self.SenderName:='';
  Self.RecieverName:='';
  Self.MessageString:='';
end;

constructor TCommunicator.Create;
begin
  inherited;
  FBuffer:= nil;
  FEmpty:= true;
  FPosition:= 0;
end;

destructor TCommunicator.Destroy;
begin
  FBuffer:= nil;
  inherited;
end;

{$R-}
function TCommunicator.Pop: TCommunicatorRec;
begin
  Result.Clear;
  if ((length(FBuffer) > 0)) and (FPosition <= high(FBuffer))  then
  begin
    Result.SenderName:= FBuffer[Position].SenderName;
    Result.recieverName:= FBuffer[Position].recieverName;
    Result.MessageString:= FBuffer[Position].MessageString;
  end;
end;
{$R+}

procedure TCommunicator.DelPosition(APos: integer);
begin
  if ((APos > high(FBuffer)) or (APos < 0)) then exit;

  FBuffer[APos]:= FBuffer[high(FBuffer)];
  SetLength(FBuffer,Length(FBuffer)-1);
  if Length(FBuffer) = 0 then FEmpty:= true;
end;

procedure TCommunicator.Push(ASenderName, ArecieverName, AMessageString: string);
var
  TempValue: TCommunicatorRec;
begin
  TempValue.SenderName:= ASenderName;
  TempValue.recieverName:= ArecieverName;
  TempValue.MessageString:= AMessageString;
  SetLength(FBuffer, Length(FBuffer)+1);
  FBuffer[high(FBuffer)]:= TempValue;
  FEmpty:= false;
end;

function TCommunicator.GetBufferLength: integer;
begin
  FBufferLength:= Length(FBuffer);
  Result:=FBufferLength;
end;

end.
