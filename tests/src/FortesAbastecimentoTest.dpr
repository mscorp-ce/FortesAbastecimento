program FortesAbastecimentoTest;

{$IFNDEF TESTINSIGHT}
{$APPTYPE CONSOLE}
{$ENDIF}
{$STRONGLINKTYPES ON}
uses
  System.SysUtils,
  {$IFDEF TESTINSIGHT}
  TestInsight.DUnitX,
  {$ELSE}
  DUnitX.Loggers.Console,
  DUnitX.Loggers.Xml.NUnit,
  {$ENDIF }
  DUnitX.TestFramework,
  uModel.Abstraction in '..\..\src\model\uModel.Abstraction.pas',
  uModel.Entities.Abastecimento in '..\..\src\model\entities\uModel.Entities.Abastecimento.pas',
  uModel.Entities.Bomba in '..\..\src\model\entities\uModel.Entities.Bomba.pas',
  uModel.Entities.Tanque in '..\..\src\model\entities\uModel.Entities.Tanque.pas',
  uTest.AbastecimentoService in 'uTest.AbastecimentoService.pas',
  uModel.Services.Exception.EServiceAbastecimentoBusinessException in '..\..\src\model\services\uModel.Services.Exception.EServiceAbastecimentoBusinessException.pas',
  uModel.Service.Abastecimento in '..\..\src\model\services\uModel.Service.Abastecimento.pas',
  uModel.Repository.Abastecimento in '..\..\src\model\repository\uModel.Repository.Abastecimento.pas',
  uModel.Repository.ConstsStatement.Abastecimento in '..\..\src\model\repository\uModel.Repository.ConstsStatement.Abastecimento.pas',
  uModel.Repository.StatementFactory in '..\..\src\model\repository\design\uModel.Repository.StatementFactory.pas',
  uModel.Repository.Statement in '..\..\src\model\repository\uModel.Repository.Statement.pas',
  uModel.Repository.DataManagerFactory in '..\..\src\model\repository\design\uModel.Repository.DataManagerFactory.pas',
  uModel.Design.Factory.DataManagerFactory in '..\..\src\model\design\factory\uModel.Design.Factory.DataManagerFactory.pas',
  uModel.Design.Factory.StatementFactory in '..\..\src\model\design\factory\uModel.Design.Factory.StatementFactory.pas',
  uModel.FireDAC in '..\..\src\model\uModel.FireDAC.pas',
  uModel.FireDAC.Transaction in '..\..\src\model\uModel.FireDAC.Transaction.pas',
  uInfra.Libary in '..\..\src\Infra\uInfra.Libary.pas',
  uModel.FireDACEngineException in '..\..\src\model\uModel.FireDACEngineException.pas',
  uModel.Repository.DataManager in '..\..\src\model\repository\uModel.Repository.DataManager.pas',
  uModel.Repository.Bomba in '..\..\src\model\repository\uModel.Repository.Bomba.pas',
  uModel.Repository.ConstsStatement.Bomba in '..\..\src\model\repository\uModel.Repository.ConstsStatement.Bomba.pas';

{ keep comment here to protect the following conditional from being removed by the IDE when adding a unit }
{$IFNDEF TESTINSIGHT}
var
  runner: ITestRunner;
  results: IRunResults;
{$ENDIF}
begin
{$IFDEF TESTINSIGHT}
  TestInsight.DUnitX.RunRegisteredTests;
{$ELSE}
  try
    //Check command line options, will exit if invalid
    TDUnitX.CheckCommandLine;

    TDUnitX.Options.ExitBehavior := TDUnitXExitBehavior.Pause;

    //Create the test runner
    runner := TDUnitX.CreateRunner;
    //Tell the runner to use RTTI to find Fixtures
    runner.UseRTTI := True;

    Runner.AddLogger(TDUnitXConsoleLogger.Create(True));

    //When true, Assertions must be made during tests;
    runner.FailsOnNoAsserts := False;

    //Run tests
    results := runner.Execute;
    if not results.AllPassed then
      System.ExitCode := EXIT_ERRORS;

    {$IFNDEF CI}
    //We don't want this happening when running under CI.
    if TDUnitX.Options.ExitBehavior = TDUnitXExitBehavior.Pause then
    begin
      System.Write('Done.. press <Enter> key to quit.');
      System.Readln;
    end;
    {$ENDIF}
  except
    on E: Exception do
      System.Writeln(E.ClassName, ': ', E.Message);
  end;
{$ENDIF}
end.
