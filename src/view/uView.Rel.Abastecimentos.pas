unit uView.Rel.Abastecimentos;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Data.DB, FireDAC.Stan.Intf, FireDAC.Stan.Option, FireDAC.Stan.Param,
  FireDAC.Stan.Error, FireDAC.DatS, FireDAC.Phys.Intf, FireDAC.DApt.Intf, FireDAC.Stan.Async, FireDAC.DApt,
  FireDAC.Comp.DataSet, FireDAC.Comp.Client, FireDAC.UI.Intf, FireDAC.Stan.Def, FireDAC.Stan.Pool, FireDAC.Phys,
  FireDAC.Phys.FB, FireDAC.Phys.FBDef, FireDAC.VCLUI.Wait, RLReport, FireDAC.Phys.IBBase, Datasnap.DBClient;

type
  TfrmRelAbastecimentos = class(TForm)
    dsAbastecimentos: TDataSource;
    qryAbastecimentos: TFDQuery;
    xConnection: TFDConnection;
    xDriverLink: TFDPhysFBDriverLink;
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
    RLLabel3: TRLLabel;
    RLDBText1: TRLDBText;
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
    procedure RLBand2BeforePrint(Sender: TObject; var PrintIt: Boolean);
    procedure RLBand3BeforePrint(Sender: TObject; var PrintIt: Boolean);
    procedure RLBand4BeforePrint(Sender: TObject; var PrintIt: Boolean);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
  private
    { Private declarations }
    FTotalDia: Double;
    FTotalGeral: Double;
    procedure SetTotalDia(const Value: Double);
    procedure SetTotalGeral(const Value: Double);
  public
    { Public declarations }
    property TotalDia: Double read FTotalDia write SetTotalDia;
    property TotalGeral: Double read FTotalGeral write SetTotalGeral;
  end;

var
  frmRelAbastecimentos: TfrmRelAbastecimentos;

implementation

{$R *.dfm}

procedure TfrmRelAbastecimentos.FormClose(Sender: TObject; var Action: TCloseAction);
begin
  qryAbastecimentos.Close();
  xConnection.Close();
end;

procedure TfrmRelAbastecimentos.RLBand2BeforePrint(Sender: TObject; var PrintIt: Boolean);
var
  Valor: Double;
begin
  Valor := qryAbastecimentos.FieldByName('VALOR').AsFloat;

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

end.
