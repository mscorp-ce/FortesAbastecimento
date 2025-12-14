inherited frmAbastecimento: TfrmAbastecimento
  Caption = 'Abastecimento'
  ClientHeight = 232
  ClientWidth = 655
  StyleElements = [seFont, seClient, seBorder]
  ExplicitWidth = 671
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
    Left = 136
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
    Left = 135
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
    Left = 262
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
    Left = 389
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
    Width = 121
    Height = 21
    ImeName = 'edtProjectCode'
    ReadOnly = True
    TabOrder = 0
  end
  inherited pnlControl: TPanel
    Left = 525
    Height = 232
    TabOrder = 1
    StyleElements = [seFont, seBorder]
    ExplicitLeft = 525
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
    Left = 135
    Top = 35
    Width = 366
    Height = 21
    KeyField = 'id_bomba'
    ListField = 'descricao'
    ListSource = dsBomba
    TabOrder = 2
  end
  object dtpDataHora: TDateTimePicker
    Left = 8
    Top = 81
    Width = 121
    Height = 21
    Date = 46004.000000000000000000
    Time = 0.897409675926610400
    Kind = dtkDateTime
    TabOrder = 3
  end
  object nubQtdeLitros: TNumberBox
    Left = 135
    Top = 81
    Width = 121
    Height = 21
    Mode = nbmFloat
    MinValue = 1.000000000000000000
    TabOrder = 4
  end
  object nubPrecoLitro: TNumberBox
    Left = 262
    Top = 81
    Width = 121
    Height = 21
    Mode = nbmCurrency
    MinValue = 1.000000000000000000
    TabOrder = 5
  end
  object nubValorTotal: TNumberBox
    Left = 389
    Top = 81
    Width = 121
    Height = 21
    Mode = nbmCurrency
    MinValue = 1.000000000000000000
    TabOrder = 6
  end
  object nubImposto: TNumberBox
    Left = 8
    Top = 129
    Width = 121
    Height = 21
    Mode = nbmCurrency
    MinValue = 1.000000000000000000
    TabOrder = 7
  end
  object dsBomba: TDataSource
    DataSet = cdsBomba
    Left = 448
    Top = 24
  end
  object cdsBomba: TClientDataSet
    Aggregates = <>
    FieldDefs = <
      item
        Name = 'project_cod'
        DataType = ftInteger
      end
      item
        Name = 'name'
        Attributes = [faRequired]
        DataType = ftWideString
        Size = 100
      end
      item
        Name = 'description'
        Attributes = [faRequired]
        DataType = ftWideString
        Size = 255
      end
      item
        Name = 'start_date'
        Attributes = [faRequired]
        DataType = ftDate
      end
      item
        Name = 'end_date'
        Attributes = [faRequired]
        DataType = ftDate
      end
      item
        Name = 'status'
        Attributes = [faRequired, faFixed]
        DataType = ftString
        Size = 1
      end>
    IndexDefs = <>
    Params = <>
    StoreDefs = True
    Left = 448
    Top = 80
    object cdsBombaid_bomba: TIntegerField
      FieldName = 'id_bomba'
    end
    object cdsBombadescricao: TStringField
      FieldName = 'descricao'
    end
  end
end
