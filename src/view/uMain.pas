unit uMain;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.Menus, Datasnap.DBClient;

type
  TfrmMain = class(TForm)
    mmMenu: TMainMenu;
    mmiCadastro: TMenuItem;
    mmiAbastecimento: TMenuItem;
    mmiRelatrio: TMenuItem;
    mmiAbastecimentos: TMenuItem;
    mmiSair: TMenuItem;
    procedure mmiSairClick(Sender: TObject);
    procedure mmiAbastecimentoClick(Sender: TObject);
    procedure mmiAbastecimentosClick(Sender: TObject);
  private
    procedure PrepareReport(DataSet: TClientDataSet);
    { Private declarations }
  public
    { Public declarations }
  end;

var
  frmMain: TfrmMain;

implementation

uses
  uView.FormConsultaAbastecimento, uView.Rel.Abastecimentos,
  uModel.Abstraction, uModel.Entities.Abastecimento, uController.Abastecimento,
  System.Generics.Collections, uController.DataConverter.Abastecimento;

{$R *.dfm}

procedure TfrmMain.mmiAbastecimentoClick(Sender: TObject);
var
  LfrmConsultaAbastecimento: TfrmConsultaAbastecimento;
begin
  LfrmConsultaAbastecimento:= TfrmConsultaAbastecimento.Create(Self);
  try
    LfrmConsultaAbastecimento.ShowModal();
  finally
    FreeAndNil(LfrmConsultaAbastecimento)
  end;
end;

procedure TfrmMain.PrepareReport(DataSet: TClientDataSet);
var
  LControllerAbastecimento: IController<TAbastecimento>;
  LDataConverter: IDataConverter<TAbastecimento>;
  LAbastecimentos: TObjectList<TAbastecimento>;
begin
  LControllerAbastecimento:= TControllerAbastecimento.Create();
  DataSet.Close();

  DataSet.CreateDataSet();

  LAbastecimentos := LControllerAbastecimento.Report();
  try
    LDataConverter:= TDataConverterAbastecimento.Create();
    LDataConverter.PopulateReport(LAbastecimentos, DataSet);

    DataSet.Open();

  finally
    FreeAndNil(LAbastecimentos);
  end;
end;

procedure TfrmMain.mmiAbastecimentosClick(Sender: TObject);
var
  LfrmRelAbastecimentos: TfrmRelAbastecimentos;
begin
  LfrmRelAbastecimentos:= TfrmRelAbastecimentos.Create(Self);
  try
    PrepareReport(LfrmRelAbastecimentos.cdsAbastecimentos);
    LfrmRelAbastecimentos.qryAbastecimentos.Open();
    LfrmRelAbastecimentos.TotalDia := 0;
    LfrmRelAbastecimentos.TotalGeral := 0;
    LfrmRelAbastecimentos.Report.Preview();

  finally
    FreeAndNil(LfrmRelAbastecimentos);
  end;
end;

procedure TfrmMain.mmiSairClick(Sender: TObject);
begin
  Close();
end;

end.
