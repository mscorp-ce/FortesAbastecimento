program FortesAbastecimento;

uses
  Vcl.Forms,
  uMain in 'view\uMain.pas' {frmMain},
  uModel.Entities.Tanque in 'model\entities\uModel.Entities.Tanque.pas',
  uModel.Entities.Bomba in 'model\entities\uModel.Entities.Bomba.pas',
  uModel.uModel.Entities.Abastecimento in 'model\entities\uModel.uModel.Entities.Abastecimento.pas';

{$R *.res}

begin
  Application.Initialize;
  Application.MainFormOnTaskbar := True;
  ReportMemoryLeaksOnShutdown := True;
  Application.CreateForm(TfrmMain, frmMain);
  Application.Run;
end.
