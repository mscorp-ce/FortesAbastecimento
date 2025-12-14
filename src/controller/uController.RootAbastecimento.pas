unit uController.RootAbastecimento;

interface

uses
  System.Classes, System.Generics.Collections, uModel.Abstraction,
  uModel.Entities.Abastecimento;

type
  TControllerRootAbastecimento = class(TInterfacedObject, IRootController<TAbastecimento>)
  private
    AbastecimentoService: IService<TAbastecimento>;
  public
    function Fields: TStrings;
    function CommandSQL(): String;
    function FindAll(): TObjectList<TAbastecimento>; overload;
    function FindAll(CommadSQL: String): TObjectList<TAbastecimento>; overload;
    function FindAll(CommadSQL: String; Entity: TAbastecimento): TObjectList<TAbastecimento>; overload;

    constructor Create; reintroduce;
    destructor Destroy; override;
  end;

implementation

{ TControllerRootProject }

uses uModel.Service.Abastecimento;

function TControllerRootAbastecimento.CommandSQL: String;
begin
  Result := AbastecimentoService.CommandSQL();
end;

constructor TControllerRootAbastecimento.Create();
begin
  inherited Create;

  AbastecimentoService:= TAbastecimentoService.Create();
end;

destructor TControllerRootAbastecimento.Destroy();
begin
  inherited;
end;

function TControllerRootAbastecimento.Fields(): TStrings;
var
  Items: TStrings;
begin
  Items:= AbastecimentoService.Fields;

  Result:= Items;
end;

function TControllerRootAbastecimento.FindAll(): TObjectList<TAbastecimento>;
begin
  Result:= AbastecimentoService.FindAll();
end;

function TControllerRootAbastecimento.FindAll(CommadSQL: String;
  Entity: TAbastecimento): TObjectList<TAbastecimento>;
begin
  Result:= nil;
end;

function TControllerRootAbastecimento.FindAll(CommadSQL: String): TObjectList<TAbastecimento>;
begin
  Result:= AbastecimentoService.FindAll(CommadSQL);
end;

end.
