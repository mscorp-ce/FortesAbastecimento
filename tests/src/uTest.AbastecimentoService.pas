unit uTest.AbastecimentoService;

interface

uses
  DUnitX.TestFramework,
  uModel.Service.Abastecimento,
  uModel.Entities.Abastecimento,
  uModel.Entities.Bomba,
  uModel.Services.Exception.EServiceAbastecimentoBusinessException,
  System.SysUtils;

type
  [TestFixture]
  TTestAbastecimentoService = class
  private
    FService: TAbastecimentoService;
    FEntity: TAbastecimento;
  public
    [Setup]
    procedure Setup;

    [TearDown]
    procedure TearDown;

    [Test]
    procedure IsValid_DeveFalhar_QuandoBombaInvalida;

    [Test]
    procedure IsValid_DeveFalhar_QuandoQuantidadeZero;

    [Test]
    procedure Save_DeveSalvar_QuandoEntidadeValida;

    [Test]
    procedure Save_DeveLancarExcecao_QuandoEntidadeInvalida;
  end;

implementation

procedure TTestAbastecimentoService.Setup;
begin
  FService := TAbastecimentoService.Create;

  FEntity := TAbastecimento.Create;
  FEntity.Bomba := TBomba.Create;
  FEntity.Bomba.Id := 1;
  FEntity.DataHora := Now;
  FEntity.QuantidadeLitros := 10;
  FEntity.ValorTotal := 100;
end;

procedure TTestAbastecimentoService.TearDown;
begin
  FEntity.Free;
  FService.Free;
end;

procedure TTestAbastecimentoService.IsValid_DeveFalhar_QuandoBombaInvalida;
var
  Msg: string;
begin
  FEntity.Bomba.Id := 0;

  Assert.IsFalse(FService.IsValid(FEntity, Msg));
  Assert.AreEqual('Bomba invalida.', Msg);
end;

procedure TTestAbastecimentoService.IsValid_DeveFalhar_QuandoQuantidadeZero;
var
  Msg: string;
begin
  FEntity.QuantidadeLitros := 0;

  Assert.IsFalse(FService.IsValid(FEntity, Msg));
end;

procedure TTestAbastecimentoService.Save_DeveSalvar_QuandoEntidadeValida;
begin
  Assert.IsTrue(FService.Save(FEntity));
end;

procedure TTestAbastecimentoService.Save_DeveLancarExcecao_QuandoEntidadeInvalida;
begin
  FEntity.QuantidadeLitros := 0;

  Assert.WillRaise(
  procedure
  begin
    FService.Save(FEntity);
  end,
  EServiceAbastecimentoBusinessException
  );
end;

initialization
  TDUnitX.RegisterTestFixture(TTestAbastecimentoService);

end.
