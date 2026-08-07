class NegocioException(Exception):

    def __init__(self, message):
        super().__init__(message)

class RecursoNaoEncontradoException(NegocioException):

    def __init__(self, message="Recurso não encontrado"):
        super().__init__(message)

class PendenciaException(NegocioException):

    def __init__(self, message="Usuário possui pendências"):
        super().__init__(message)

class LimiteExcedidoException(NegocioException):

    def __init__(self, message="Limite excedido"):
        super().__init__(message)

class ColecaoReservadaException(NegocioException):

    def __init__(self, message="Este exemplar pertence à coleção de reserva e não pode ser emprestado"):
        super().__init__(message)

class ReservaException(NegocioException):

    def __init__(self, message="Erro na operação de reserva"):
        super().__init__(message)

class AutorizacaoException(NegocioException):

    def __init__(self, message="Falha na autorização. CPF não encontrado ou inválido"):
        super().__init__(message)