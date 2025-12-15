unit uModel.Service.Abastecimento;

interface

uses
  System.Classes, System.Generics.Collections, uModel.Abstraction, uModel.Entities.Abastecimento, Data.DB;

type
  TAbastecimentoService = class(TInterfacedObject, IService<TAbastecimento>)
  private
    AbastecimentoRepository: IRepository<TAbastecimento>;
  public
    function Fields(): TStrings;
    function CommandSQL(): string;
    function Report(const ADataInicial, ADataFinal: TDateTime): TObjectList<TAbastecimento>;
    function FindAll(): TObjectList<TAbastecimento>; overload;

    function IsValid(Entity: TAbastecimento; out MessageContext: String): Boolean;
    function FindAll(Id: Integer): TObjectList<TAbastecimento>; overload;

    function Save(Entity: TAbastecimento): Boolean;
    function Update(Entity: TAbastecimento): Boolean; overload;
    function DeleteById(Entity: TAbastecimento): Boolean;

    function Find(): Integer;
    function FindById(Id: Integer): TAbastecimento;

    function FindAll(CommandSQL: String): TObjectList<TAbastecimento>; overload;

    constructor Create(); reintroduce;
    destructor Destroy(); override;
  end;

implementation

{ TAbastecimentoService }

uses
  System.SysUtils, uModel.Repository.Abastecimento, uModel.Services.Exception.EServiceAbastecimentoBusinessException,
  uModel.Repository.Bomba, uModel.Entities.Bomba;

function TAbastecimentoService.CommandSQL(): string;
begin
  Result := AbastecimentoRepository.CommandSQL();
end;

constructor TAbastecimentoService.Create();
begin
  inherited Create();

  AbastecimentoRepository:= TAbastecimentoRepository.Create();
end;

function TAbastecimentoService.DeleteById(Entity: TAbastecimento): Boolean;
begin
  Result := AbastecimentoRepository.DeleteById(Entity);
end;

destructor TAbastecimentoService.Destroy();
begin
  inherited Destroy();
end;

function TAbastecimentoService.Fields(): TStrings;
var
  Items: TStrings;
begin
  Items := AbastecimentoRepository.Fields;

  Result := Items;
end;

function TAbastecimentoService.Report(const ADataInicial, ADataFinal: TDateTime): TObjectList<TAbastecimento>;
begin
  Result:= AbastecimentoRepository.Report(ADataInicial, ADataFinal);
end;

function TAbastecimentoService.FindAll(): TObjectList<TAbastecimento>;
begin
  Result:= AbastecimentoRepository.FindAll();
end;

function TAbastecimentoService.FindAll(CommandSQL: String): TObjectList<TAbastecimento>;
begin
  Result := AbastecimentoRepository.FindAll(CommandSQL);
end;

function TAbastecimentoService.Find(): Integer;
begin
  Result := AbastecimentoRepository.Find();
end;

function TAbastecimentoService.FindAll(Id: Integer): TObjectList<TAbastecimento>;
begin
  Result := nil;
end;

function TAbastecimentoService.FindById(Id: Integer): TAbastecimento;
begin
  Result := AbastecimentoRepository.FindById(Id);
end;

function TAbastecimentoService.IsValid(Entity: TAbastecimento; out MessageContext: String): Boolean;
var
  LBomba: TBomba;
  LBombaRepository: IRepository<TBomba>;
  LImpostoCalculado: Currency;
begin
  Result:= False;

  if Entity.Bomba.Id <= 0 then
    begin
      MessageContext:= 'Bomba invalida.';
      Exit();
    end;

  LBombaRepository := TBombaRepository.Create();

  LBomba:= LBombaRepository.FindById(Entity.Bomba.Id);
  try
    if LBomba.Id <= 0 then
      begin
        MessageContext:= 'A bomba não esta cadastrada.';
        Exit();
      end;

  finally
    LBomba.Free();
  end;

  if DateToStr(Entity.DataHora) = '00/00/0000' then
    begin
      MessageContext:= 'Informe uma data valida para o abastecimento.';
      Exit();
    end;

  if Entity.QuantidadeLitros <= 0 then
    begin
      MessageContext := 'Informe uma quantidade de litros maior que zero.';
      Exit();
    end;

  if Entity.ValorTotal <= 0 then
    begin
      MessageContext := 'Informe um valor total que zero.';
      Exit();
    end;

  LImpostoCalculado := Entity.GetImposto();

  if Abs(Entity.Imposto - LImpostoCalculado) > 0.009 then
  begin
    MessageContext := Format('O imposto deve ser 13%% do valor total. Valor esperado: %.2f', [LImpostoCalculado]);
    Exit();
  end;

  Result := True;
end;

function TAbastecimentoService.Save(Entity: TAbastecimento): Boolean;
var
  MessageContext: String;
begin
  if not IsValid(Entity, MessageContext) then
    raise EServiceAbastecimentoBusinessException.Create(MessageContext);

  Result := AbastecimentoRepository.Save(Entity);

  if not Result then
    raise EServiceAbastecimentoBusinessException.Create('Erro ao tentar salvar o Abastecimento.');
end;

function TAbastecimentoService.Update(Entity: TAbastecimento): Boolean;
var
  MessageContext: String;
begin
  if not IsValid(Entity, MessageContext) then
    raise EServiceAbastecimentoBusinessException.Create(MessageContext);

  Result := AbastecimentoRepository.Update(Entity);

  if not Result then
    raise EServiceAbastecimentoBusinessException.Create('Erro ao tentar alterar um Abastecimento.');
end;

end.
