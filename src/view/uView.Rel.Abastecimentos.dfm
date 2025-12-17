object frmRelAbastecimentos: TfrmRelAbastecimentos
  Left = 0
  Top = 0
  Caption = 'Relat'#243'rio de Abastecimentos'
  ClientHeight = 83
  ClientWidth = 329
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
  object Report: TRLReport
    Left = -16
    Top = 83
    Width = 794
    Height = 1123
    DataSource = dsAbastecimentos
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clBlack
    Font.Height = -13
    Font.Name = 'Arial'
    Font.Style = []
    object bdCabecalho: TRLBand
      Left = 38
      Top = 38
      Width = 718
      Height = 80
      BandType = btHeader
      object RLSystemInfo1: TRLSystemInfo
        Left = 560
        Top = 16
        Width = 132
        Height = 16
        Info = itFullDate
        Text = ''
      end
      object RLLabel1: TRLLabel
        Left = 173
        Top = 28
        Width = 372
        Height = 24
        Align = faCenter
        Caption = 'RELAT'#211'RIO DE ABASTECIMENTOS'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clBlack
        Font.Height = -21
        Font.Name = 'Arial'
        Font.Style = [fsBold]
        ParentFont = False
      end
      object RLSystemInfo2: TRLSystemInfo
        Left = 608
        Top = 56
        Width = 84
        Height = 16
        Info = itPageNumber
        Text = 'P'#225'gina: '
      end
      object RLLabel2: TRLLabel
        Left = 16
        Top = 16
        Width = 86
        Height = 16
        Caption = 'Posto ABC Ltda.'
      end
      object RLSystemInfo3: TRLSystemInfo
        Left = 16
        Top = 56
        Width = 96
        Height = 16
        Info = itHour
        Text = 'Hora: '
      end
    end
    object RLGroup1: TRLGroup
      Left = 38
      Top = 118
      Width = 718
      Height = 83
      DataFields = 'DIA'
      object RLBand1: TRLBand
        Left = 0
        Top = 0
        Width = 718
        Height = 24
        BandType = btHeader
        Color = clAppWorkSpace
        ParentColor = False
        Transparent = False
        object RLLabel7: TRLLabel
          Left = 3
          Top = 4
          Width = 58
          Height = 16
          Caption = 'Data Dia:'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -13
          Font.Name = 'Arial'
          Font.Style = [fsBold]
          ParentFont = False
        end
        object RLDBText5: TRLDBText
          Left = 76
          Top = 4
          Width = 39
          Height = 16
          DataField = 'DIA'
          DataSource = dsAbastecimentos
          Text = ''
        end
      end
      object RLBand2: TRLBand
        Left = 0
        Top = 24
        Width = 718
        Height = 24
        BeforePrint = RLBand2BeforePrint
        object RLLabel4: TRLLabel
          Left = 115
          Top = 5
          Width = 54
          Height = 16
          Caption = 'Tanque'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -13
          Font.Name = 'Arial'
          Font.Style = [fsBold]
          ParentFont = False
          Transparent = False
        end
        object RLDBText2: TRLDBText
          Left = 174
          Top = 5
          Width = 156
          Height = 16
          DataField = 'TANQUE'
          DataSource = dsAbastecimentos
          Text = ''
          Transparent = False
        end
        object RLLabel5: TRLLabel
          Left = 333
          Top = 5
          Width = 49
          Height = 16
          Caption = 'Bomba'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -13
          Font.Name = 'Arial'
          Font.Style = [fsBold]
          ParentFont = False
          Transparent = False
        end
        object RLDBText3: TRLDBText
          Left = 385
          Top = 5
          Width = 48
          Height = 16
          DataField = 'NUMERO_BOMBA'
          DataSource = dsAbastecimentos
          Text = ''
          Transparent = False
        end
        object RLLabel6: TRLLabel
          Left = 495
          Top = 5
          Width = 44
          Height = 16
          Caption = 'Valor'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -13
          Font.Name = 'Arial'
          Font.Style = [fsBold]
          ParentFont = False
          Transparent = False
        end
        object RLDBText4: TRLDBText
          Left = 552
          Top = 5
          Width = 48
          Height = 16
          Alignment = taRightJustify
          DataField = 'VALOR'
          DataSource = dsAbastecimentos
          Text = ''
          Transparent = False
        end
        object RLLabel3: TRLLabel
          Left = 604
          Top = 5
          Width = 60
          Height = 16
          Caption = 'Imposto'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -13
          Font.Name = 'Arial'
          Font.Style = [fsBold]
          ParentFont = False
          Transparent = False
        end
        object RLDBText1: TRLDBText
          Left = 655
          Top = 5
          Width = 63
          Height = 16
          Alignment = taRightJustify
          DataField = 'IMPOSTO'
          DataSource = dsAbastecimentos
          Text = ''
          Transparent = False
        end
      end
      object RLBand3: TRLBand
        Left = 0
        Top = 48
        Width = 718
        Height = 26
        BandType = btSummary
        BeforePrint = RLBand3BeforePrint
        object rlTotal: TRLLabel
          Left = 470
          Top = 3
          Width = 118
          Height = 16
          Alignment = taRightJustify
          Caption = 'Total por Dia (R$):'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -13
          Font.Name = 'Arial'
          Font.Style = [fsBold]
          ParentFont = False
        end
        object rlImposto: TRLLabel
          Left = 626
          Top = 3
          Width = 89
          Height = 16
          Alignment = taRightJustify
          Caption = 'Imp. Dia (R$):'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -13
          Font.Name = 'Arial'
          Font.Style = [fsBold]
          ParentFont = False
        end
      end
    end
    object RLBand4: TRLBand
      Left = 38
      Top = 201
      Width = 718
      Height = 27
      BandType = btSummary
      BeforePrint = RLBand4BeforePrint
      object rlTotalGeral: TRLLabel
        Left = 491
        Top = 6
        Width = 107
        Height = 16
        Alignment = taRightJustify
        Caption = 'Total Geral (R$):'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clBlack
        Font.Height = -13
        Font.Name = 'Arial'
        Font.Style = [fsBold]
        ParentFont = False
      end
      object rlImpostoGeral: TRLLabel
        Left = 612
        Top = 6
        Width = 103
        Height = 16
        Alignment = taRightJustify
        Caption = 'Imp. Geral (R$):'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clBlack
        Font.Height = -13
        Font.Name = 'Arial'
        Font.Style = [fsBold]
        ParentFont = False
      end
    end
  end
  object dtpDataIni: TDateTimePicker
    Left = 4
    Top = 25
    Width = 87
    Height = 21
    Date = 46006.000000000000000000
    Time = 0.897409675926610400
    TabOrder = 1
  end
  object dtpDataFinal: TDateTimePicker
    Left = 110
    Top = 25
    Width = 87
    Height = 21
    Date = 46006.000000000000000000
    Time = 0.897409675926610400
    TabOrder = 2
  end
  object btnExecutar: TButton
    Left = 168
    Top = 52
    Width = 75
    Height = 25
    Caption = 'Executar'
    TabOrder = 3
    OnClick = btnExecutarClick
  end
  object btnFechar: TButton
    Left = 249
    Top = 52
    Width = 75
    Height = 25
    Caption = 'Fechar'
    TabOrder = 4
    OnClick = btnFecharClick
  end
  object dsAbastecimentos: TDataSource
    DataSet = cdsAbastecimentos
    Left = 40
    Top = 336
  end
  object cdsAbastecimentos: TClientDataSet
    Aggregates = <>
    Params = <>
    Left = 152
    Top = 336
    object cdsAbastecimentosDIA: TDateField
      FieldName = 'DIA'
    end
    object cdsAbastecimentosTANQUE: TStringField
      FieldName = 'TANQUE'
    end
    object cdsAbastecimentosNUMERO_BOMBA: TIntegerField
      FieldName = 'NUMERO_BOMBA'
    end
    object cdsAbastecimentosVALOR: TCurrencyField
      FieldName = 'VALOR'
    end
    object cdsAbastecimentosIMPOSTO: TCurrencyField
      FieldName = 'IMPOSTO'
    end
  end
end
