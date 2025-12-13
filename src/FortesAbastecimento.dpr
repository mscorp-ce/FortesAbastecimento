program FortesAbastecimento;

uses
  Vcl.Forms,
  uMain in 'view\uMain.pas' {frmMain},
  uModel.Entities.Tanque in 'model\entities\uModel.Entities.Tanque.pas',
  uModel.Entities.Bomba in 'model\entities\uModel.Entities.Bomba.pas',
  uModel.Entities.Abastecimento in 'model\entities\uModel.Entities.Abastecimento.pas',
  uModel.Abstraction in 'model\uModel.Abstraction.pas',
  uModel.FireDACEngineException in 'model\uModel.FireDACEngineException.pas',
  uModel.FireDAC.Transaction in 'model\uModel.FireDAC.Transaction.pas',
  uInfra.Libary in 'Infra\uInfra.Libary.pas',
  uModel.FireDAC in 'model\uModel.FireDAC.pas',
  uModel.Repository.DataManager in 'model\repository\uModel.Repository.DataManager.pas',
  uModel.Design.Factory.DataManagerFactory in 'model\design\factory\uModel.Design.Factory.DataManagerFactory.pas',
  uView.FormConsult in 'view\consult\uView.FormConsult.pas' {frmConsult},
  uView.FormBaseRegistration in 'view\form_registration\uView.FormBaseRegistration.pas' {frmBaseRegistration},
  uView.FormFilters in 'view\consult\uView.FormFilters.pas' {frmFiltros},
  uView.CustomFormFilterAbastecimento in 'view\consult\uView.CustomFormFilterAbastecimento.pas',
  uModel.Repository.Statement in 'model\repository\uModel.Repository.Statement.pas',
  uModel.Repository.StatementFactory in 'model\repository\design\uModel.Repository.StatementFactory.pas',
  uModel.Repository.DataManagerFactory in 'model\repository\design\uModel.Repository.DataManagerFactory.pas',
  uModel.Repository.ConstsStatement.Abastecimento in 'model\repository\uModel.Repository.ConstsStatement.Abastecimento.pas',
  uModel.Repository.Abastecimento in 'model\repository\uModel.Repository.Abastecimento.pas',
  uModel.Service.Abastecimento in 'model\services\uModel.Service.Abastecimento.pas',
  uController.RootAbastecimento in 'controller\uController.RootAbastecimento.pas',
  uModel.Services.Exception.EServiceAbastecimentoBusinessException in 'model\services\uModel.Services.Exception.EServiceAbastecimentoBusinessException.pas',
  uController.Abastecimento in 'controller\uController.Abastecimento.pas',
  uModel.Repository.Bomba in 'model\repository\uModel.Repository.Bomba.pas',
  uModel.Repository.ConstsStatement.Bomba in 'model\repository\uModel.Repository.ConstsStatement.Bomba.pas';

{$R *.res}

begin
  Application.Initialize;
  Application.MainFormOnTaskbar := True;
  ReportMemoryLeaksOnShutdown := True;
  Application.CreateForm(TfrmMain, frmMain);
  Application.Run;
end.
