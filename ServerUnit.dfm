object ServerForm: TServerForm
  Left = 0
  Top = 0
  Caption = 'ServerForm'
  ClientHeight = 361
  ClientWidth = 424
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -12
  Font.Name = 'Segoe UI'
  Font.Style = []
  KeyPreview = True
  OnClose = FormClose
  OnCreate = FormCreate
  PixelsPerInch = 96
  TextHeight = 15
  object Panel1: TPanel
    Left = 0
    Top = 0
    Width = 424
    Height = 41
    Align = alTop
    TabOrder = 0
    object StatusLabel: TLabel
      Left = 1
      Top = 1
      Width = 110
      Height = 39
      Align = alLeft
      Caption = #1057#1077#1088#1074#1077#1088' '#1085#1077' '#1079#1072#1087#1091#1097#1077#1085' '
      Layout = tlCenter
      ExplicitHeight = 15
    end
    object Button1: TButton
      Left = 224
      Top = 10
      Width = 75
      Height = 25
      Caption = 'Clients'
      TabOrder = 0
      OnClick = Button1Click
    end
    object Button2: TButton
      Left = 305
      Top = 10
      Width = 75
      Height = 25
      Caption = 'Sockets'
      TabOrder = 1
      OnClick = Button2Click
    end
  end
  object Panel2: TPanel
    Left = 0
    Top = 41
    Width = 185
    Height = 320
    Align = alLeft
    BorderWidth = 4
    TabOrder = 1
    object Label1: TLabel
      Left = 5
      Top = 5
      Width = 175
      Height = 32
      Align = alTop
      Alignment = taCenter
      AutoSize = False
      Caption = #1042' '#1089#1077#1090#1080
      Layout = tlCenter
      ExplicitLeft = 1
      ExplicitTop = 1
      ExplicitWidth = 183
    end
    object ListBox1: TListBox
      Left = 5
      Top = 37
      Width = 175
      Height = 237
      Align = alClient
      ItemHeight = 15
      TabOrder = 0
    end
    object Panel4: TPanel
      Left = 5
      Top = 274
      Width = 175
      Height = 41
      Align = alBottom
      TabOrder = 1
      object Button4: TButton
        Left = 48
        Top = 6
        Width = 75
        Height = 25
        Caption = #1054#1095#1077#1088#1077#1076#1100' - 0'
        TabOrder = 0
        OnClick = Button4Click
      end
    end
  end
  object Panel3: TPanel
    Left = 185
    Top = 41
    Width = 239
    Height = 320
    Align = alClient
    BorderWidth = 4
    TabOrder = 2
    object Label2: TLabel
      Left = 5
      Top = 5
      Width = 229
      Height = 32
      Align = alTop
      Alignment = taCenter
      AutoSize = False
      Caption = #1063#1072#1090
      Layout = tlCenter
      ExplicitLeft = 1
      ExplicitTop = 1
      ExplicitWidth = 437
    end
    object Memo1: TMemo
      Left = 5
      Top = 37
      Width = 229
      Height = 237
      Align = alClient
      ReadOnly = True
      ScrollBars = ssVertical
      TabOrder = 0
    end
    object Panel5: TPanel
      Left = 5
      Top = 274
      Width = 229
      Height = 41
      Align = alBottom
      TabOrder = 1
      object Button3: TButton
        Left = 144
        Top = 6
        Width = 75
        Height = 25
        Caption = 'Clear'
        TabOrder = 0
        OnClick = Button3Click
      end
    end
  end
  object Server: TServerSocket
    Active = False
    Port = 0
    ServerType = stNonBlocking
    OnClientConnect = ServerClientConnect
    OnClientDisconnect = ServerClientDisconnect
    OnClientRead = ServerClientRead
    Left = 16
    Top = 48
  end
  object Timer1: TTimer
    OnTimer = Timer1Timer
    Left = 16
    Top = 113
  end
end
