program FortesAbastecimento;

uses
  Vcl.Forms,
  uMain in 'view\uMain.pas' {frmMain},
  uModel.Entities.Tanque in 'model\entities\uModel.Entities.Tanque.pas',
  uModel.Entities.Bomba in 'model\entities\uModel.Entities.Bomba.pas',
  uModel.uModel.Entities.Abastecimento in 'model\entities\uModel.uModel.Entities.Abastecimento.pas',
  uModel.Abstraction in 'model\uModel.Abstraction.pas',
  uModel.FireDACEngineException in 'model\uModel.FireDACEngineException.pas',
  uModel.FireDAC.Transaction in 'model\uModel.FireDAC.Transaction.pas',
  uInfra.Libary in 'Infra\uInfra.Libary.pas',
  uModel.FireDAC in 'model\uModel.FireDAC.pas',
  uModel.Repository.DataManager in 'model\repository\uModel.Repository.DataManager.pas',
  uModel.Design.Factory.DataManagerFactory in 'model\design\factory\uModel.Design.Factory.DataManagerFactory.pas',
  uView.FormConsult in 'view\consult\uView.FormConsult.pas' {frmConsult},
  uView.FormBaseRegistration in 'view\form_registration\uView.FormBaseRegistration.pas' {frmBaseRegistration},
  uView.FormFilters in 'view\consult\uView.FormFilters.pas' {frmFiltros};

{$R *.res}

begin
  Application.Initialize;
  Application.MainFormOnTaskbar := True;
  ReportMemoryLeaksOnShutdown := True;
  Application.CreateForm(TfrmMain, frmMain);
  Application.CreateForm(TfrmConsult, frmConsult);
  Application.CreateForm(TfrmBaseRegistration, frmBaseRegistration);
  Application.CreateForm(TfrmFiltros, frmFiltros);
  Application.Run;
end.
