unit uView.ContextoAbastecimento;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.ComCtrls, Vcl.StdCtrls,
  Datasnap.DBClient;

type
  TfrmContextoAbastecimento = class(TForm)
    lblDataIni: TLabel;
    dtpDataIni: TDateTimePicker;
    lblEntre: TLabel;
    lblDataFinal: TLabel;
    dtpDataFinal: TDateTimePicker;
    btnExecutar: TButton;
    btnFechar: TButton;
    procedure btnExecutarClick(Sender: TObject);
    procedure btnFecharClick(Sender: TObject);
  private
    { Private declarations }
    procedure PrepareReport(DataSet: TClientDataSet);
    procedure Executar();
    procedure Fechar();
  public
    { Public declarations }
  end;

var
  frmContextoAbastecimento: TfrmContextoAbastecimento;

implementation

uses
  uModel.Abstraction, uModel.Entities.Abastecimento, uController.Abastecimento,
  uController.DataConverter.Abastecimento, uView.Rel.Abastecimentos,
  System.Generics.Collections, uModel.Repository.ConstsStatement.Abastecimento;

{$R *.dfm}

{ TfrmContextoAbastecimento }

procedure TfrmContextoAbastecimento.btnFecharClick(Sender: TObject);
begin
  Fechar();
end;

procedure TfrmContextoAbastecimento.Executar();
var
  LfrmRelAbastecimentos: TfrmRelAbastecimentos;
  LSQL: String;
  LNewReplace: String;
begin
  LfrmRelAbastecimentos:= TfrmRelAbastecimentos.Create(Self);
  try
    //PrepareReport(LfrmRelAbastecimentos.cdsAbastecimentos);
    //LfrmRelAbastecimentos.qryAbastecimentos.Open();
    LfrmRelAbastecimentos.TotalDia := 0;
    LfrmRelAbastecimentos.TotalGeral := 0;
    //LfrmRelAbastecimentos.DataInicial:= dtpDataIni.Date;
    //LfrmRelAbastecimentos.DataFinal:= dtpDataFinal.Date;

    LSQL:= QUERY_ABASTECIMENTO;

    if (dtpDataIni.Date > 0) and (dtpDataFinal.Date > 0) then
      LNewReplace:= ' WHERE ABA.DATA_HORA >= :DATA_INICIAL AND ABA.DATA_HORA <= :DATA_FINAL '
    else
      LNewReplace:= ' ';

    LSQL:= StringReplace(LSQL ,'@CLAUSE_WHERE@', LNewReplace, [rfReplaceAll]);

    LfrmRelAbastecimentos.qryAbastecimentos.SQL.Clear();
    LfrmRelAbastecimentos.qryAbastecimentos.SQL.Add(LSQL);

    if LNewReplace <> EmptyStr then
      begin
        LfrmRelAbastecimentos.qryAbastecimentos.Params.ParamByName('DATA_INICIAL').AsDate := dtpDataIni.Date;
        LfrmRelAbastecimentos.qryAbastecimentos.Params.ParamByName('DATA_FINAL').AsDate := dtpDataFinal.Date;
      end;

    LfrmRelAbastecimentos.qryAbastecimentos.Open();

    LfrmRelAbastecimentos.Report.Preview();

  finally
    FreeAndNil(LfrmRelAbastecimentos);
  end;
end;

procedure TfrmContextoAbastecimento.Fechar();
begin
  Close();
end;

procedure TfrmContextoAbastecimento.btnExecutarClick(Sender: TObject);
begin
  Executar();
end;

procedure TfrmContextoAbastecimento.PrepareReport(DataSet: TClientDataSet);
var
  LControllerAbastecimento: IController<TAbastecimento>;
  LDataConverter: IDataConverter<TAbastecimento>;
  LAbastecimentos: TObjectList<TAbastecimento>;
begin
  LControllerAbastecimento:= TControllerAbastecimento.Create();
  DataSet.Close();

  DataSet.CreateDataSet();

  LAbastecimentos := LControllerAbastecimento.Report(dtpDataIni.Date, dtpDataFinal.Date);
  try
    LDataConverter:= TDataConverterAbastecimento.Create();
    LDataConverter.PopulateReport(LAbastecimentos, DataSet);

    DataSet.Open();

  finally
    FreeAndNil(LAbastecimentos);
  end;
end;

end.
