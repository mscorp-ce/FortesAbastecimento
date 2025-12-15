unit uController.Abastecimento;

interface

uses
  System.Classes, System.Generics.Collections, uModel.Abstraction, uModel.Entities.Abastecimento;

type
  TControllerAbastecimento = class(TInterfacedObject, IController<TAbastecimento>)
  private
    AbastecimentoService: IService<TAbastecimento>;
  public
    function Fields(): TStrings;
    function CommandSQL(): String;
    function FindAll(): TObjectList<TAbastecimento>; overload;
    function Report(): TObjectList<TAbastecimento>;

    function IsValid(Entity: TAbastecimento; out MessageContext: String): Boolean;
    function Save(Entity: TAbastecimento): Boolean;
    function Update(Entity: TAbastecimento): Boolean;
    function DeleteById(Entity: TAbastecimento): Boolean;
    function Find(): Integer;
    function FindById(Id: Integer): TAbastecimento;
    function FindAll(CommandSQL: String): TObjectList<TAbastecimento>; overload;

    constructor Create(); reintroduce;
    destructor Destroy(); override;
  end;

implementation

{ TControllerAbastecimento }

uses
  uModel.Service.Abastecimento;

function TControllerAbastecimento.CommandSQL(): string;
begin
  Result := AbastecimentoService.CommandSQL();
end;

constructor TControllerAbastecimento.Create();
begin
  inherited Create();

  AbastecimentoService := TAbastecimentoService.Create();
end;

function TControllerAbastecimento.DeleteById(Entity: TAbastecimento): Boolean;
begin
  Result := AbastecimentoService.DeleteById(Entity);
end;

destructor TControllerAbastecimento.Destroy();
begin
  inherited Destroy();
end;

function TControllerAbastecimento.Fields: TStrings;
var
  Items: TStrings;
begin
  Items:= AbastecimentoService.Fields;

  Result:= Items;
end;

function TControllerAbastecimento.Find(): Integer;
begin
  Result:= AbastecimentoService.Find();
end;

function TControllerAbastecimento.Report(): TObjectList<TAbastecimento>;
begin
  Result:= AbastecimentoService.Report();
end;

function TControllerAbastecimento.FindAll: TObjectList<TAbastecimento>;
begin
  Result:= AbastecimentoService.FindAll();
end;

function TControllerAbastecimento.FindAll(CommandSQL: String): TObjectList<TAbastecimento>;
begin
  Result:= AbastecimentoService.FindAll(CommandSQL);
end;

function TControllerAbastecimento.FindById(Id: Integer): TAbastecimento;
begin
  Result:= AbastecimentoService.FindById(Id);
end;

function TControllerAbastecimento.IsValid(Entity: TAbastecimento; out MessageContext: String): Boolean;
begin
  try
    Result := AbastecimentoService.IsValid(Entity, MessageContext);
  except
    raise;
  end;
end;

function TControllerAbastecimento.Save(Entity: TAbastecimento): Boolean;
begin
  Result := AbastecimentoService.Save(Entity);
end;

function TControllerAbastecimento.Update(Entity: TAbastecimento): Boolean;
begin
  Result:= AbastecimentoService.Update(Entity);
end;

end.
