unit uController.RootBomba;

interface

uses
  System.Classes, System.Generics.Collections, uModel.Abstraction,
  uModel.Entities.Bomba;

type
  TControllerRootBomba = class(TInterfacedObject, IRootController<TBomba>)
  private
    BombaService: IService<TBomba>;
  public
    function Fields: TStrings;
    function CommandSQL(): String;
    function FindAll(): TObjectList<TBomba>; overload;
    function FindAll(CommadSQL: String): TObjectList<TBomba>; overload;
    function FindAll(CommadSQL: String; Entity: TBomba): TObjectList<TBomba>; overload;

    constructor Create; reintroduce;
    destructor Destroy; override;
  end;

implementation

{ TControllerRootProject }

uses uModel.Service.Bomba;

function TControllerRootBomba.CommandSQL: String;
begin
  Result := BombaService.CommandSQL();
end;

constructor TControllerRootBomba.Create();
begin
  inherited Create;

  BombaService:= TBombaService.Create();
end;

destructor TControllerRootBomba.Destroy();
begin
  inherited;
end;

function TControllerRootBomba.Fields(): TStrings;
var
  Items: TStrings;
begin
  Items:= BombaService.Fields;

  Result:= Items;
end;

function TControllerRootBomba.FindAll(): TObjectList<TBomba>;
begin
  Result:= BombaService.FindAll();
end;

function TControllerRootBomba.FindAll(CommadSQL: String;
  Entity: TBomba): TObjectList<TBomba>;
begin
  Result:= nil;
end;

function TControllerRootBomba.FindAll(CommadSQL: String): TObjectList<TBomba>;
begin
  Result:= BombaService.FindAll(CommadSQL);
end;

end.
