unit uView.Rel.Abastecimentos;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics, Vcl.Controls,
  Vcl.Forms, Vcl.Dialogs, Data.DB, RLReport, Datasnap.DBClient, Vcl.StdCtrls, Vcl.ComCtrls;

type
  TfrmRelAbastecimentos = class(TForm)
    dsAbastecimentos: TDataSource;
    cdsAbastecimentos: TClientDataSet;
    cdsAbastecimentosDIA: TDateField;
    cdsAbastecimentosTANQUE: TStringField;
    cdsAbastecimentosNUMERO_BOMBA: TIntegerField;
    cdsAbastecimentosVALOR: TCurrencyField;
    Report: TRLReport;
    bdCabecalho: TRLBand;
    RLSystemInfo1: TRLSystemInfo;
    RLLabel1: TRLLabel;
    RLSystemInfo2: TRLSystemInfo;
    RLLabel2: TRLLabel;
    RLSystemInfo3: TRLSystemInfo;
    RLGroup1: TRLGroup;
    RLBand1: TRLBand;
    RLLabel7: TRLLabel;
    RLDBText5: TRLDBText;
    RLBand2: TRLBand;
    RLLabel4: TRLLabel;
    RLDBText2: TRLDBText;
    RLLabel5: TRLLabel;
    RLDBText3: TRLDBText;
    RLLabel6: TRLLabel;
    RLDBText4: TRLDBText;
    RLBand3: TRLBand;
    rlTotal: TRLLabel;
    RLBand4: TRLBand;
    rlTotalGeral: TRLLabel;
    lblDataIni: TLabel;
    lblEntre: TLabel;
    lblDataFinal: TLabel;
    dtpDataIni: TDateTimePicker;
    dtpDataFinal: TDateTimePicker;
    btnExecutar: TButton;
    btnFechar: TButton;
    procedure RLBand2BeforePrint(Sender: TObject; var PrintIt: Boolean);
    procedure RLBand3BeforePrint(Sender: TObject; var PrintIt: Boolean);
    procedure RLBand4BeforePrint(Sender: TObject; var PrintIt: Boolean);
    procedure btnExecutarClick(Sender: TObject);
    procedure btnFecharClick(Sender: TObject);
  private
    { Private declarations }
    FTotalDia: Double;
    FTotalGeral: Double;
    procedure SetTotalDia(const Value: Double);
    procedure SetTotalGeral(const Value: Double);
    procedure PrepareReport(DataSet: TClientDataSet);
    procedure Executar();
  public
    { Public declarations }
    property TotalDia: Double read FTotalDia write SetTotalDia;
    property TotalGeral: Double read FTotalGeral write SetTotalGeral;
  end;

var
  frmRelAbastecimentos: TfrmRelAbastecimentos;

implementation

uses
  uModel.Abstraction, uModel.Entities.Abastecimento, uController.Abastecimento,
  uController.DataConverter.Abastecimento, System.Generics.Collections;

{$R *.dfm}

procedure TfrmRelAbastecimentos.RLBand2BeforePrint(Sender: TObject; var PrintIt: Boolean);
var
  Valor: Double;
begin
  Valor := cdsAbastecimentos.FieldByName('VALOR').AsFloat;

  FTotalDia := FTotalDia + Valor;
  FTotalGeral := FTotalGeral + Valor;
end;

procedure TfrmRelAbastecimentos.RLBand3BeforePrint(Sender: TObject; var PrintIt: Boolean);
begin
  rlTotal.Caption := Format('Total do dia: R$ %n', [FTotalDia]);
  FTotalDia := 0;
end;

procedure TfrmRelAbastecimentos.RLBand4BeforePrint(Sender: TObject; var PrintIt: Boolean);
begin
  rlTotalGeral.Caption := Format('TOTAL GERAL: R$ %n', [FTotalGeral]);

  FTotalGeral := 0;
end;

procedure TfrmRelAbastecimentos.SetTotalDia(const Value: Double);
begin
  FTotalDia := Value;
end;

procedure TfrmRelAbastecimentos.SetTotalGeral(const Value: Double);
begin
  FTotalGeral := Value;
end;

procedure TfrmRelAbastecimentos.btnExecutarClick(Sender: TObject);
begin
  if (dtpDataIni.Date > dtpDataFinal.Date) then
    begin
      ShowMessage('Informe um período válido, a data inicial não pode ser maior que a data final');
      Exit();
    end;

  Executar();
end;

procedure TfrmRelAbastecimentos.btnFecharClick(Sender: TObject);
begin
  Close();
end;

procedure TfrmRelAbastecimentos.PrepareReport(DataSet: TClientDataSet);
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

procedure TfrmRelAbastecimentos.Executar();
begin
  FTotalDia := 0;
  FTotalGeral := 0;

  PrepareReport(cdsAbastecimentos);

  Report.Preview();
end;

end.
