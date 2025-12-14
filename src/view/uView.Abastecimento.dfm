inherited frmAbastecimento: TfrmAbastecimento
  Caption = 'Abastecimento'
  ClientHeight = 232
  ClientWidth = 678
  StyleElements = [seFont, seClient, seBorder]
  ExplicitWidth = 694
  ExplicitHeight = 271
  TextHeight = 13
  object lblAbastecimento: TLabel [0]
    Left = 8
    Top = 16
    Width = 98
    Height = 13
    Caption = 'IdAbastecimento'
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -11
    Font.Name = 'Tahoma'
    Font.Style = [fsBold]
    ParentFont = False
  end
  object lblDataHora: TLabel [1]
    Left = 8
    Top = 62
    Width = 54
    Height = 13
    Caption = 'DataHora'
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -11
    Font.Name = 'Tahoma'
    Font.Style = [fsBold]
    ParentFont = False
  end
  object lblBomba: TLabel [2]
    Left = 145
    Top = 16
    Width = 39
    Height = 13
    Caption = 'Bomba'
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -11
    Font.Name = 'Tahoma'
    Font.Style = [fsBold]
    ParentFont = False
  end
  object lblQtdeLitros: TLabel [3]
    Left = 144
    Top = 62
    Width = 106
    Height = 13
    Caption = 'Quantidade Listros'
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -11
    Font.Name = 'Tahoma'
    Font.Style = [fsBold]
    ParentFont = False
  end
  object lblPrecoLitro: TLabel [4]
    Left = 278
    Top = 62
    Width = 61
    Height = 13
    Caption = 'Pre'#231'o Litro'
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -11
    Font.Name = 'Tahoma'
    Font.Style = [fsBold]
    ParentFont = False
  end
  object lblValorTotal: TLabel [5]
    Left = 412
    Top = 62
    Width = 61
    Height = 13
    Caption = 'Valor Total'
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -11
    Font.Name = 'Tahoma'
    Font.Style = [fsBold]
    ParentFont = False
  end
  object lblImposto: TLabel [6]
    Left = 8
    Top = 110
    Width = 48
    Height = 13
    Caption = 'Imposto'
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -11
    Font.Name = 'Tahoma'
    Font.Style = [fsBold]
    ParentFont = False
  end
  object edtAbastecimento: TEdit [7]
    Left = 8
    Top = 35
    Width = 128
    Height = 21
    ImeName = 'edtProjectCode'
    ReadOnly = True
    TabOrder = 0
  end
  inherited pnlControl: TPanel
    Left = 548
    Height = 232
    TabOrder = 1
    StyleElements = [seFont, seBorder]
    ExplicitLeft = 548
    ExplicitHeight = 232
    inherited spbRestore: TSpeedButton
      Top = 5
      ExplicitTop = 5
    end
    inherited spbOK: TSpeedButton
      Top = 49
      ExplicitTop = 49
    end
    inherited spbExit: TSpeedButton
      Top = 182
      ExplicitTop = 182
    end
  end
  object lkpBomba: TDBLookupComboBox
    Left = 146
    Top = 35
    Width = 396
    Height = 21
    KeyField = 'id_bomba'
    ListField = 'descricao'
    ListSource = dsBomba
    TabOrder = 2
    OnExit = lkpBombaExit
  end
  object dtpDataHora: TDateTimePicker
    Left = 8
    Top = 81
    Width = 128
    Height = 21
    Date = 46004.000000000000000000
    Time = 0.897409675926610400
    Kind = dtkDateTime
    TabOrder = 3
  end
  object edtQtdeLitros: TEdit
    Left = 144
    Top = 81
    Width = 128
    Height = 21
    ImeName = 'edtProjectCode'
    TabOrder = 4
    OnChange = edtQtdeLitrosChange
    OnKeyPress = edtQtdeLitrosKeyPress
  end
  object edtPrecoLitro: TEdit
    Left = 278
    Top = 81
    Width = 128
    Height = 21
    ImeName = 'edtProjectCode'
    ReadOnly = True
    TabOrder = 5
    OnChange = edtPrecoLitroChange
    OnKeyPress = edtPrecoLitroKeyPress
  end
  object edtValorTotal: TEdit
    Left = 412
    Top = 81
    Width = 128
    Height = 21
    ImeName = 'edtProjectCode'
    ReadOnly = True
    TabOrder = 6
    OnChange = edtValorTotalChange
    OnKeyPress = edtValorTotalKeyPress
  end
  object edtImposto: TEdit
    Left = 8
    Top = 129
    Width = 128
    Height = 21
    ImeName = 'edtProjectCode'
    ReadOnly = True
    TabOrder = 7
    OnKeyPress = edtImpostoKeyPress
  end
  object dsBomba: TDataSource
    DataSet = cdsBomba
    Left = 448
    Top = 24
  end
  object cdsBomba: TClientDataSet
    Aggregates = <>
    Params = <>
    Left = 448
    Top = 120
    object cdsBombaID_BOMBA: TIntegerField
      FieldName = 'ID_BOMBA'
    end
    object cdsBombaID_TANQUE: TIntegerField
      FieldName = 'ID_TANQUE'
    end
    object cdsBombaNUMERO_BOMBA: TIntegerField
      FieldName = 'NUMERO_BOMBA'
    end
    object cdsBombaDESCRICAO: TStringField
      FieldName = 'DESCRICAO'
    end
    object cdsBombaPRECO_LITRO: TCurrencyField
      FieldName = 'PRECO_LITRO'
    end
  end
end
