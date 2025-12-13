unit uModel.Abstraction;

interface

uses
  System.Classes, System.SysUtils, System.Generics.Collections, Data.DB, FireDAC.Stan.Intf, FireDAC.Stan.Option, FireDAC.Stan.Param,
  FireDAC.Stan.Error, FireDAC.DatS, FireDAC.Phys.Intf, FireDAC.DApt.Intf, FireDAC.Comp.DataSet, FireDAC.Comp.Client,
  FireDAC.Stan.Async, FireDAC.DApt;

type
  TState = (dsBrowse, dsInsert, dsEdit, dsOpening);

  IDataManager<T: class> = interface
  ['{2D3401A0-6832-44CB-8FAB-22E9C37EC9D4}']
    function GetConnection(): T;
    function GetStartTransaction(): IDataManager<T>;
    function GetCommit(): IDataManager<T>;
    function GetRollback(): IDataManager<T>;
    function GetEntity(EntitName: String): IDataManager<T>;
    function GetFieldNames(): TStrings;

    property Connection: T read GetConnection;

    property StartTransaction: IDataManager<T> read GetStartTransaction;
    property Commit: IDataManager<T> read GetCommit;
    property Rollback: IDataManager<T> read GetRollback;
  end;

  TInsulationOptions = (ioUnspecified, ioDirtyRead, ioReadCommitted, ioRepeatableRead, ioSnapshot, ioSerializable);

  ITransaction<T: class> = interface
  ['{0BC2E806-DB0F-492E-8A2B-E7605C94BD63}']
    procedure StartTransaction();
    procedure Commit();
    procedure Rollback();
    procedure SetOptions(Isolation: TInsulationOptions);
  end;

  IMemory = interface
  ['{B7F3A945-ACDE-4EC2-9C47-BAD69B86D9E4}']
    function GetData(): TFDMemTable;

    procedure SetRecNo(const Value: Integer);
    function GetRecNo: Integer;

    procedure SetState(const Value: TState);
    function GetState: TState;

    procedure Open();

    property Data: TFDMemTable read GetData;
    property RecNo: Integer read GetRecNo write SetRecNo;
    property State: TState read GetState write SetState;
  end;

  IStatement = interface
  ['{21619B6D-AEB6-4B4F-8343-625CE14F6F57}']
    function GetQuery(): TFDQuery;
    function SQL(const Value: String): IStatement;
    function Open(): IStatement;

    property Query: TFDQuery read GetQuery;
  end;

  IEntitie<T: class> = interface
  ['{3D979BF0-2FE8-4865-BC1D-8A5806A3309A}']
    function IsValid(Entity: T; out MessageContext: String): Boolean;
  end;

  IRootPersistence<T: class> = interface
  ['{D9047AE9-B05C-4B37-8AEE-9A6B9A5772EB}']
    function Fields(): TStrings;
    function CommandSQL(): String;
    function FindAll(): TObjectList<T>;
  end;

  IPersistence<T: class> = interface(IRootPersistence<T>)
  ['{98D74E55-3050-4E35-95E0-74A8B349D6FB}']
    function Save(Entity: T): Boolean;
    function Update(Entity: T): Boolean;
    function DeleteById(Entity: T): Boolean;
    function Find(): Integer;
    function FindById(Id: Integer): T;
    function FindAll(CommandSQL: String): TObjectList<T>; overload;
  end;

  IRootController<T: class> = interface(IRootPersistence<T>)
  ['{DC75061F-D9C5-4BAA-A226-2A3FE1D36DE1}']
  end;

  IController<T: class> = interface(IPersistence<T>)
  ['{0C7B72B1-76BA-4463-BA7F-FAC7A90470EC}']
    function IsValid(Entity: T; out MessageContext: String): Boolean;
  end;

  IService<T: class> = interface(IPersistence<T>)
  ['{5E47E4E7-D251-4AD9-BA5E-00B5DBAAD58C}']
    function IsValid(Entity: T; out MessageContext: String): Boolean;
  end;

  IDomain<T: class> = interface(IService<T>)
  ['{1986F161-6CD0-482D-ACF9-43EF9F6DB6AC}']
    function IsValid(Entity: T; const Memory: IMemory): Boolean; overload;
  end;

  IRepository<T: class> = interface(IPersistence<T>)
  ['{C192836A-9BF1-43CC-B8FE-1496A6A71705}']
    procedure SetStatement(Statement: IStatement; Entity: T);
    procedure SetProperty(Statement: IStatement; Entity: T);
    procedure PopulateListEntitie(var List: TObjectList<T>; const Statement: IStatement);
    function FindAll(Id: Integer): TObjectList<T>; overload;
  end;

  IDataConverter<T: class> = interface
  ['{D27C0689-A569-4DC3-B1B1-3FA4233B0E5C}']
    procedure Populate(Source: TObjectList<T>; Target: TDataSet);
  end;

var
  State: TState;

  StateItems: TState;

implementation

end.



