inherited frmConsultaAbastecimento: TfrmConsultaAbastecimento
  Caption = 'Consulta de Abastercimentos'
  StyleElements = [seFont, seBorder]
  TextHeight = 13
  inherited pnlControl: TPanel
    StyleElements = [seFont, seBorder]
    inherited spbAlter: TSpeedButton
      Left = 6
      Top = 132
      ExplicitLeft = 6
      ExplicitTop = 132
    end
  end
  inherited grdConsult: TDBGrid
    OnDblClick = grdConsultDblClick
    OnKeyDown = grdConsultaKeyDown
    Columns = <
      item
        Expanded = False
        FieldName = 'ID_ABASTECIMENTO'
        Visible = True
      end
      item
        Expanded = False
        FieldName = 'ID_BOMBA'
        Visible = True
      end
      item
        Expanded = False
        FieldName = 'NOME_BOMBA'
        Width = 200
        Visible = True
      end
      item
        Expanded = False
        FieldName = 'DATA_HORA'
        Visible = True
      end
      item
        Expanded = False
        FieldName = 'QUANTIDADE_LITROS'
        Visible = True
      end
      item
        Expanded = False
        FieldName = 'PRECO_LITRO'
        Visible = True
      end
      item
        Expanded = False
        FieldName = 'VALOR_TOTAL'
        Visible = True
      end
      item
        Expanded = False
        FieldName = 'IMPOSTO'
        Visible = True
      end>
  end
  inherited cdsConsult: TClientDataSet
    ProviderName = 'DataModule1.DataSetProvider1'
    object cdsConsultID_ABASTECIMENTO: TIntegerField
      DisplayLabel = 'IdAbastecimento'
      FieldName = 'ID_ABASTECIMENTO'
    end
    object cdsConsultID_BOMBA: TIntegerField
      DisplayLabel = 'IdBomba'
      FieldName = 'ID_BOMBA'
    end
    object cdsConsultNOME_BOMBA: TStringField
      DisplayLabel = 'NomeBomba'
      FieldName = 'NOME_BOMBA'
    end
    object cdsConsultDATA_HORA: TDateTimeField
      DisplayLabel = 'DataHora'
      FieldName = 'DATA_HORA'
    end
    object cdsConsultQUANTIDADE_LITROS: TCurrencyField
      DisplayLabel = 'QuantidadeListros'
      FieldName = 'QUANTIDADE_LITROS'
    end
    object cdsConsultPRECO_LITRO: TCurrencyField
      DisplayLabel = 'Pre'#231'oLitro'
      FieldName = 'PRECO_LITRO'
    end
    object cdsConsultVALOR_TOTAL: TCurrencyField
      DisplayLabel = 'ValorToal'
      FieldName = 'VALOR_TOTAL'
    end
    object cdsConsultIMPOSTO: TCurrencyField
      DisplayLabel = 'Imposto'
      FieldName = 'IMPOSTO'
    end
  end
end
