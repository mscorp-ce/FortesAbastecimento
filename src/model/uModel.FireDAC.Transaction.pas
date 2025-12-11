unit uModel.FireDAC.Transaction;

interface

uses
  FireDAC.Comp.Client, FireDAC.Stan.Option, uModel.Abstraction;

type
  TModelFireDACTransaction<T: TFDCustomConnection> = class(TInterfacedObject, ITransaction<TFDCustomConnection>)
  private
    FTransaction: TFDTransaction;
    FConnection: T;
  public
    constructor Create(Connection: T); reintroduce;
    destructor Destroy(); override;

    procedure StartTransaction();
    procedure Commit();
    procedure Rollback();
    procedure SetOptions(Isolation: TInsulationOptions);
  end;

implementation

{ TModelFireDACTransaction }

uses
  System.SysUtils;

constructor TModelFireDACTransaction<T>.Create(Connection: T);
begin
  inherited Create();

  FConnection := Connection;
  FTransaction := TFDTransaction.Create(nil);
  FTransaction.Connection := FConnection;
  FTransaction.Options.Isolation := xiReadCommitted;
end;

destructor TModelFireDACTransaction<T>.Destroy();
begin
  FreeAndNil(FTransaction);

  inherited Destroy();
end;

procedure TModelFireDACTransaction<T>.StartTransaction();
begin
  FTransaction.StartTransaction;
end;

procedure TModelFireDACTransaction<T>.Commit();
begin
  FTransaction.Commit();
end;

procedure TModelFireDACTransaction<T>.Rollback();
begin
   FTransaction.Rollback();
end;

procedure TModelFireDACTransaction<T>.SetOptions(Isolation: TInsulationOptions);
begin
  case Isolation of
    ioDirtyRead: FTransaction.Options.Isolation := xiDirtyRead;
    ioReadCommitted: FTransaction.Options.Isolation := xiReadCommitted;
    ioRepeatableRead: FTransaction.Options.Isolation := xiRepeatableRead;
    ioSerializable: FTransaction.Options.Isolation := xiSerializible
  else
    FTransaction.Options.Isolation := xiReadCommitted;
  end;
end;

end.

