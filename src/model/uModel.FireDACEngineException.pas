unit uModel.FireDACEngineException;

interface

uses
  FireDAC.Stan.Error;

type
  TFireDACEngineException = class
  public
    class function GetMessage(const Eroor: EFDDBEngineException): String;
  end;

implementation

{ TFireDACEngineException }

class function TFireDACEngineException.GetMessage(
  const Eroor: EFDDBEngineException): String;
begin
  case Eroor.Kind of
    ekOther: Result:= 'O erro não se enquadra em nenhuma das categorias previstas.';
    ekNoDataFound:
      Result:= 'Dados não encontrado. Uma solicitação para uma quantidade específica de dados foi solicitado, mas não foi encontrado.';
    ekTooManyRows:
      Result:= 'Há multiplas linhas para a operação, sendo o esperado uma única linha, rever o comando.';
    ekRecordLocked:
      Result:= 'Registro em uso bloqueado por outra conexão, tente novamente.';
    ekUKViolated:
      Result:= 'Já existe uma registro com a mesma chave única na tabela, tente outra combinação.';
    ekFKViolated:
      Result:= 'Tentativa de inserir um dado que não esta presente na tabela externa de relacionamento, tente um registro válido.';
    ekObjNotExists:
      Result:= 'Tentativa de operação com um objeto do banco de dados que não existe.';
    ekUserPwdInvalid, ekUserPwdExpired, ekUserPwdWillExpire:
      Result:= 'Login com usuário não autorizado.';
    ekCmdAborted:
      Result:= 'Comando encerrado inesperadamente, tente novamente ou chame o administrador.';
    ekServerGone:
      Result:= 'Servidor desconectado, não é possível executar a operação.';
    ekServerOutput:
      Result:= Eroor.Message;
    ekArrExecMalfunc:
      Result:= Eroor.Message;
    ekInvalidParams:
      Result:= 'Parametros inválidos, tente nova combinação de parametros.';
  end;
end;

end.



