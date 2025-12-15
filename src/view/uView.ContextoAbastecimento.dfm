object frmContextoAbastecimento: TfrmContextoAbastecimento
  Left = 0
  Top = 0
  Caption = 'Contexto de Abastecimentos'
  ClientHeight = 91
  ClientWidth = 316
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -12
  Font.Name = 'Segoe UI'
  Font.Style = []
  Position = poScreenCenter
  TextHeight = 15
  object lblDataIni: TLabel
    Left = 4
    Top = 6
    Width = 64
    Height = 13
    Caption = 'Data Inicial'
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -11
    Font.Name = 'Tahoma'
    Font.Style = [fsBold]
    ParentFont = False
  end
  object lblEntre: TLabel
    Left = 97
    Top = 28
    Width = 7
    Height = 13
    Caption = 'a'
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -11
    Font.Name = 'Tahoma'
    Font.Style = [fsBold]
    ParentFont = False
  end
  object lblDataFinal: TLabel
    Left = 110
    Top = 6
    Width = 56
    Height = 13
    Caption = 'Data Final'
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -11
    Font.Name = 'Tahoma'
    Font.Style = [fsBold]
    ParentFont = False
  end
  object dtpDataIni: TDateTimePicker
    Left = 4
    Top = 25
    Width = 87
    Height = 21
    Date = 46006.000000000000000000
    Time = 0.897409675926610400
    TabOrder = 0
  end
  object dtpDataFinal: TDateTimePicker
    Left = 110
    Top = 25
    Width = 87
    Height = 21
    Date = 46006.000000000000000000
    Time = 0.897409675926610400
    TabOrder = 1
  end
  object btnExecutar: TButton
    Left = 150
    Top = 58
    Width = 75
    Height = 25
    Caption = 'Executar'
    TabOrder = 2
    OnClick = btnExecutarClick
  end
  object btnFechar: TButton
    Left = 231
    Top = 58
    Width = 75
    Height = 25
    Caption = 'Fechar'
    TabOrder = 3
    OnClick = btnFecharClick
  end
end
