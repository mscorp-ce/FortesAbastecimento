unit uMain;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.Menus;

type
  TfrmMain = class(TForm)
    mmMenu: TMainMenu;
    mmiCadastro: TMenuItem;
    mmiAbastecimento: TMenuItem;
    mmiRelatrio: TMenuItem;
    mmiAbastecimentos: TMenuItem;
    mmiSair: TMenuItem;
    procedure mmiSairClick(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  frmMain: TfrmMain;

implementation

{$R *.dfm}

procedure TfrmMain.mmiSairClick(Sender: TObject);
begin
  Close();
end;

end.
