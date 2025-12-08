from abc import ABC, abstractmethod
from datetime import datetime
from typing import List, Optional

# --- Padrão Observer: Interfaces ---
class Observer(ABC):
    @abstractmethod
    def atualizar(self, mensagem: str):
        pass

class Subject(ABC):
    def __init__(self):
        self._observadores: List[Observer] = []

    def anexar(self, observer: Observer):
        if observer not in self._observadores:
            self._observadores.append(observer)

    def notificar(self, mensagem: str):
        for observer in self._observadores:
            observer.atualizar(mensagem)

# --- Classes de Domínio ---

class Documento:
    def __init__(self, tipo: str, conteudo: str):
        self.id = None
        self.tipo = tipo
        self.data_criacao = datetime.now()
        self.conteudo = conteudo
    
    def validar_formato(self) -> bool:
        return len(self.conteudo) > 0

class Tramite:
    def __init__(self, tipo: str, descricao: str):
        self.id = None
        self.data_hora = datetime.now()
        self.tipo = tipo
        self.descricao = descricao
        self.documento_anexo: Optional[Documento] = None

    # Padrão Factory Method
    def gerar_documento(self, tipo_doc: str, conteudo: str) -> Documento:
        novo_doc = Documento(tipo_doc, conteudo)
        self.documento_anexo = novo_doc
        return novo_doc

class Decisao:
    def __init__(self, resultado: str, texto_integral: str):
        self.id = None
        self.resultado = resultado
        self.texto_integral = texto_integral
        self.data_publicacao = datetime.now()

class Pessoa(ABC):
    def __init__(self, nome: str, cpf_cnpj: str, email: str):
        self.id = None
        self.nome = nome
        self.cpf_cnpj = cpf_cnpj
        self.email = email

class Advogado(Pessoa, Observer):
    def __init__(self, nome: str, cpf_cnpj: str, email: str, oab: str):
        super().__init__(nome, cpf_cnpj, email)
        self.oab = oab
        self.notificacoes: List[str] = []

    def consultar_processos(self):
        pass

    # Implementação do Observer
    def atualizar(self, mensagem: str):
        print(f"Advogado {self.nome} (OAB {self.oab}) recebeu notificação: {mensagem}")
        self.notificacoes.append(mensagem)

class ServidorPublico(Pessoa):
    def __init__(self, nome: str, cpf_cnpj: str, email: str, matricula: str):
        super().__init__(nome, cpf_cnpj, email)
        self.matricula = matricula

class Juiz(ServidorPublico):
    def __init__(self, nome: str, cpf_cnpj: str, email: str, matricula: str, nivel_entrancia: str):
        super().__init__(nome, cpf_cnpj, email, matricula)
        self.nivel_entrancia = nivel_entrancia

    def julgar(self, processo: 'Processo', decisao: Decisao):
        # O juiz adiciona um trâmite de julgamento e anexa a decisão
        tramite_julgamento = Tramite("Julgamento", f"Processo julgado: {decisao.resultado}")
        processo.adicionar_tramite(tramite_julgamento)
        processo.encerrar_processo()
        
class Audiencia:
    def __init__(self, data_hora: datetime, local: str, tipo: str):
        self.id = None
        self.data_hora = data_hora
        self.local = local
        self.tipo = tipo
        self.status = "Agendada"
        self.participantes: List[Pessoa] = []

    def confirmar_presenca(self, pessoa: Pessoa):
        self.participantes.append(pessoa)

    def remarcar(self, nova_data: datetime):
        self.data_hora = nova_data
        self.status = "Remarcada"

class Processo(Subject):
    def __init__(self, numero: str, assunto: str):
        super().__init__()
        self.id = None
        self.numero = numero
        self.assunto = assunto
        self.status = "Ativo"
        self.data_inicio = datetime.now()
        self.data_encerramento: Optional[datetime] = None
        self.tramites: List[Tramite] = []
        self.audiencias: List[Audiencia] = []
        self.juiz_responsavel: Optional[Juiz] = None

    def adicionar_tramite(self, tramite: Tramite):
        self.tramites.append(tramite)
        # Notifica advogados/partes interessadas
        self.notificar(f"Novo trâmite no processo {self.numero}: {tramite.tipo}")
    
    def agendar_audiencia(self, data_hora: datetime, local: str, tipo: str) -> Audiencia:
        nova_audiencia = Audiencia(data_hora, local, tipo)
        self.audiencias.append(nova_audiencia)
        self.notificar(f"Audiência de {tipo} agendada para {data_hora}")
        return nova_audiencia

    def encerrar_processo(self):
        if self.status == "Encerrado":
            raise ValueError("O processo já está encerrado.")
        
        self.status = "Encerrado"
        self.data_encerramento = datetime.now()
        self.notificar(f"O processo {self.numero} foi encerrado.")

    def get_status(self) -> str:
        return self.status
