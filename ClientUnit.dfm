object ClientForm: TClientForm
  Left = 0
  Top = 0
  Caption = 'ClientForm'
  ClientHeight = 505
  ClientWidth = 397
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -12
  Font.Name = 'Segoe UI'
  Font.Style = []
  KeyPreview = True
  OnClose = FormClose
  OnCreate = FormCreate
  OnShow = FormShow
  PixelsPerInch = 96
  TextHeight = 15
  object Panel1: TPanel
    Left = 0
    Top = 0
    Width = 397
    Height = 41
    Align = alTop
    TabOrder = 0
    object StatusLabel: TLabel
      Left = 1
      Top = 1
      Width = 97
      Height = 39
      Align = alLeft
      Alignment = taCenter
      AutoSize = False
      Caption = #1053#1077' '#1087#1086#1076#1082#1083#1102#1095#1077#1085
      Layout = tlCenter
    end
    object Edit1: TEdit
      Left = 104
      Top = 10
      Width = 121
      Height = 23
      ParentShowHint = False
      ShowHint = True
      TabOrder = 0
      TextHint = #1048#1084#1103
      OnChange = Edit1Change
    end
    object Button1: TButton
      Left = 231
      Top = 9
      Width = 75
      Height = 25
      Caption = #1042#1093#1086#1076
      TabOrder = 1
      OnClick = Button1Click
    end
  end
  object Panel2: TPanel
    Left = 0
    Top = 41
    Width = 397
    Height = 199
    Align = alClient
    BorderWidth = 4
    TabOrder = 1
    object Memo1: TMemo
      Left = 5
      Top = 5
      Width = 275
      Height = 189
      Align = alClient
      ReadOnly = True
      ScrollBars = ssVertical
      TabOrder = 0
    end
    object Panel5: TPanel
      Left = 280
      Top = 5
      Width = 112
      Height = 189
      Align = alRight
      BevelOuter = bvNone
      BorderWidth = 4
      Caption = 'Panel5'
      TabOrder = 1
      object Label2: TLabel
        Left = 4
        Top = 4
        Width = 104
        Height = 15
        Align = alTop
        Alignment = taCenter
        Caption = #1042' '#1089#1077#1090#1080
        Layout = tlCenter
        ExplicitWidth = 34
      end
      object ListBox1: TListBox
        Left = 4
        Top = 19
        Width = 104
        Height = 166
        Align = alClient
        ItemHeight = 15
        TabOrder = 0
      end
    end
  end
  object Panel3: TPanel
    Left = 0
    Top = 240
    Width = 397
    Height = 265
    Align = alBottom
    BorderWidth = 4
    TabOrder = 2
    object Panel4: TPanel
      Left = 5
      Top = 184
      Width = 387
      Height = 76
      Align = alBottom
      BevelOuter = bvNone
      TabOrder = 0
      object Label1: TLabel
        Left = 0
        Top = 11
        Width = 29
        Height = 15
        Caption = #1050#1086#1084#1091
      end
      object Edit2: TEdit
        Left = 0
        Top = 32
        Width = 121
        Height = 23
        Enabled = False
        ParentShowHint = False
        ShowHint = True
        TabOrder = 0
        TextHint = #1048#1084#1103
        OnChange = Edit2Change
      end
      object Button2: TButton
        Left = 127
        Top = 32
        Width = 75
        Height = 25
        Caption = #1054#1090#1087#1088#1072#1074#1080#1090#1100
        Enabled = False
        TabOrder = 1
        OnClick = Button2Click
      end
    end
    object Memo2: TMemo
      Left = 5
      Top = 5
      Width = 387
      Height = 179
      Align = alClient
      Enabled = False
      TabOrder = 1
    end
  end
  object Client: TClientSocket
    Active = False
    ClientType = ctNonBlocking
    Port = 0
    OnConnect = ClientConnect
    OnDisconnect = ClientDisconnect
    OnRead = ClientRead
    OnError = ClientError
    Left = 32
    Top = 56
  end
end
