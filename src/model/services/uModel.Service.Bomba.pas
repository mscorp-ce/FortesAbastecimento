unit uModel.Service.Bomba;

interface

uses
  System.Classes, System.Generics.Collections, uModel.Abstraction, uModel.Entities.Bomba, Data.DB;

type
  TBombaService = class(TInterfacedObject, IService<TBomba>)
  private
    BombaRepository: IRepository<TBomba>;
  public
    function Fields(): TStrings;
    function CommandSQL(): string;
    function FindAll(): TObjectList<TBomba>; overload;

    function IsValid(Entity: TBomba; out MessageContext: String): Boolean;
    function FindAll(Id: Integer): TObjectList<TBomba>; overload;

    function Save(Entity: TBomba): Boolean;
    function Update(Entity: TBomba): Boolean; overload;
    function DeleteById(Entity: TBomba): Boolean;

    function Find(): Integer;
    function FindById(Id: Integer): TBomba;

    function FindAll(CommandSQL: String): TObjectList<TBomba>; overload;

    constructor Create(); reintroduce;
    destructor Destroy(); override;
  end;

implementation

{ TBombaService }

uses
  System.SysUtils, uModel.Repository.Bomba;

function TBombaService.CommandSQL(): string;
begin
  Result := BombaRepository.CommandSQL();
end;

constructor TBombaService.Create();
begin
  inherited Create();

  BombaRepository:= TBombaRepository.Create();
end;

function TBombaService.DeleteById(Entity: TBomba): Boolean;
begin
  Result := BombaRepository.DeleteById(Entity);
end;

destructor TBombaService.Destroy();
begin
  inherited Destroy();
end;

function TBombaService.Fields(): TStrings;
var
  Items: TStrings;
begin
  Items := BombaRepository.Fields;

  Result := Items;
end;

function TBombaService.FindAll(): TObjectList<TBomba>;
begin
  Result:= BombaRepository.FindAll();
end;

function TBombaService.FindAll(CommandSQL: String): TObjectList<TBomba>;
begin
  Result := BombaRepository.FindAll(CommandSQL);
end;

function TBombaService.Find(): Integer;
begin
  Result := BombaRepository.Find();
end;

function TBombaService.FindAll(Id: Integer): TObjectList<TBomba>;
begin
  Result := nil;
end;

function TBombaService.FindById(Id: Integer): TBomba;
begin
  Result := BombaRepository.FindById(Id);
end;

function TBombaService.IsValid(Entity: TBomba; out MessageContext: String): Boolean;
begin
  Result := True;
end;

function TBombaService.Save(Entity: TBomba): Boolean;
begin
  Result := True;
end;

function TBombaService.Update(Entity: TBomba): Boolean;
begin
  Result := True;
end;

end.
