import tkinter as tk
from tkinter import ttk, messagebox
from decimal import Decimal

import exceptions

from service.emprestimo_service import EmprestimoService

class Viewdevolucao(ttk.Frame):

    def __init__(self, container, app_controller, db_conn):

        super().__init__(container, style='White.TFrame')

        self.app_controller = app_controller
        self.db_conn = db_conn

        self.emprestimo_service = EmprestimoService(self.db_conn)

        self.label_mensagem_var = tk.StringVar(value="")

        cor_barra = '#435998'
        barra_superior = tk.Frame(self, bg=cor_barra, height=60)
        barra_superior.pack(side=tk.TOP, fill='x')

        barra_inferior = tk.Frame(self, bg=cor_barra, height=60)
        barra_inferior.pack(side=tk.BOTTOM, fill='x')

        self.label_principal = ttk.Label(barra_superior, text = "Realizar Devolução", style='Titulo.TLabel')
        self.label_principal.pack(pady=(20, 20))

        self.frame_principal = ttk.Frame(self, style='White.TFrame')
        self.frame_principal.pack(fill='x', padx=30, pady=30)
        
        self._criar_widgets_devolucao()

        self.voltar = ttk.Button(
            barra_inferior, 
            text = "Voltar",
            style='Barra.TButton',
            command=self._acao_voltar
        )
        self.voltar.pack(side=tk.RIGHT, padx=30, pady=15)
    
    def _acao_voltar(self):
        self.app_controller.mostrar_tela_principal(self.app_controller.id_bibliotecario_logado)

    def _criar_widgets_devolucao(self):
        
        frame_busca = ttk.Frame(self.frame_principal, style='White.TFrame')
        frame_busca.pack(fill='x', pady=10)

        label_busca_ex = ttk.Label(frame_busca, text="Código do Exemplar:", style='White.TLabel')
        label_busca_ex.pack(side=tk.LEFT, padx=(0, 10))

        self.entry_busca_exemplar = ttk.Entry(frame_busca, width=20)
        self.entry_busca_exemplar.pack(side=tk.LEFT, padx=5)

        self.btn_confirmar = ttk.Button(
            frame_busca, 
            text="Confirmar Devolução",
            style="Botao.TButton",
            command=self._acao_confirmar_devolucao
        )
        self.btn_confirmar.pack(side=tk.LEFT, padx=10, ipady=2)

        frame_mensagem = ttk.Frame(self.frame_principal, style='White.TFrame')
        frame_mensagem.pack(fill='x', pady=(20, 10))

        self.label_mensagem = ttk.Label(
            frame_mensagem, 
            textvariable=self.label_mensagem_var, 
            style='White.TLabel', 
            relief="groove", 
            padding=10,
            wraplength=500 
        )
        self.label_mensagem.pack(fill='x')

    def _acao_confirmar_devolucao(self):
        
        self.label_mensagem_var.set("")

        try:
            id_exemplar = int(self.entry_busca_exemplar.get())
        except ValueError:
            messagebox.showwarning("Entrada Inválida", "O ID do exemplar deve ser um número.")
            return

        try:
            emprestimo_concluido = self.emprestimo_service.realizar_devolucao(id_exemplar)
            
            multa = emprestimo_concluido.multas if emprestimo_concluido.multas is not None else Decimal('0.00')
            
            mensagem_sucesso = f"Devolução concluída. Multa gerada: R$ {multa:.2f}"
            self.label_mensagem_var.set(mensagem_sucesso)
            
            self.entry_busca_exemplar.delete(0, 'end')

        except exceptions.RecursoNaoEncontradoException as e:
            messagebox.showwarning("Não Encontrado", f"Não foi possível processar a devolução.\nDetalhe: {e}")
        except (exceptions.NegocioException, exceptions.DataBaseException) as e:
            messagebox.showerror("Erro de Negócio", f"Não foi possível completar a operação:\n{e}")
        except Exception as e: 
            messagebox.showerror("Erro Inesperado", f"Ocorreu um erro inesperado:\n{e}")

    def _limpar_tela(self):
        self.entry_busca_exemplar.delete(0, 'end')
        self.label_mensagem_var.set("")



    