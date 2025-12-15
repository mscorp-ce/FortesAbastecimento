object frmMain: TfrmMain
  Left = 0
  Top = 0
  Caption = 'Fortes Abastecimento'
  ClientHeight = 441
  ClientWidth = 624
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -12
  Font.Name = 'Segoe UI'
  Font.Style = []
  Menu = mmMenu
  Position = poScreenCenter
  WindowState = wsMaximized
  TextHeight = 15
  object mmMenu: TMainMenu
    Left = 344
    Top = 48
    object mmiCadastro: TMenuItem
      Caption = 'Cadastro'
      object mmiAbastecimento: TMenuItem
        Caption = 'Abastecimento'
        OnClick = mmiAbastecimentoClick
      end
    end
    object mmiRelatrio: TMenuItem
      Caption = 'Relat'#243'rio'
      object mmiAbastecimentos: TMenuItem
        Caption = 'Abastecimentos'
        OnClick = mmiAbastecimentosClick
      end
    end
    object mmiSair: TMenuItem
      Caption = 'Sair'
      OnClick = mmiSairClick
    end
  end
end
