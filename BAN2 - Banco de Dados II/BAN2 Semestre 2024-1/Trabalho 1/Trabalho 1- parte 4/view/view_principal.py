import tkinter as tk
from tkinter import ttk, messagebox

import exceptions

class Viewprincipal(ttk.Frame):

    def __init__(self, container, app_controller, db_conn):

        super().__init__(container, style='White.TFrame')

        self.app_controller = app_controller

        cor_barra = '#435998'
        barra_superior = tk.Frame(self, bg=cor_barra, height=60)
        barra_superior.pack(side=tk.TOP, fill='x')

        barra_inferior = tk.Frame(self, bg=cor_barra, height=60)
        barra_inferior.pack(side=tk.BOTTOM, fill='x')

        frame_central = ttk.Frame(self, style='White.TFrame')
        frame_central.pack(fill='both', expand=True)

        self.label_principal = ttk.Label(barra_superior, text = "Menu", style='Titulo.TLabel')
        self.label_principal.pack(pady=(20, 20))

        self.emprestimo = ttk.Button(
            frame_central, 
            text = "Realizar Empréstimo",
            style='Botao.TButton',
            command=self._acao_realizar_emprestimo
        )
        self.emprestimo.pack(pady=(20, 15))

        self.devolucao = ttk.Button(
            frame_central, 
            text = "Realizar Devolução",
            style='Botao.TButton',
            command=self._acao_realizar_devolucao
        )
        self.devolucao.pack(pady=15)

        self.reserva = ttk.Button(
            frame_central, 
            text = "Realizar Reserva",
            style='Botao.TButton',
            command=self._acao_realizar_reserva
        )
        self.reserva.pack(pady=15)

        self.renovar = ttk.Button(
            frame_central, 
            text = "Renovar Empréstimo",
            style='Botao.TButton',
            command=self._acao_renovar
        )
        self.renovar.pack(pady=15)

        self.gerenciar = ttk.Button(
            frame_central, 
            text = "Gerenciar Usuários",
            style='Botao.TButton',
            command=self._acao_gerenciar
        )
        self.gerenciar.pack(pady=15)

        self.acervo = ttk.Button(
            frame_central, 
            text = "Acervo",
            style='Botao.TButton',
            command=self._acao_acervo
        )
        self.acervo.pack(pady=15)

        self.relatorio = ttk.Button(
            frame_central, 
            text = "Relatórios",
            style='Botao.TButton',
            command=self._acao_ver_relatorios
        )
        self.relatorio.pack(pady=5)

    def _acao_realizar_emprestimo(self):
        self.app_controller.mostrar_tela_emprestimo()

    def _acao_realizar_devolucao(self):
        self.app_controller.mostrar_tela_devolucao()

    def _acao_realizar_reserva(self):
        self.app_controller.mostrar_tela_reserva()

    def _acao_renovar(self):
        self.app_controller.mostrar_tela_renovar()

    def _acao_gerenciar(self):
        self.app_controller.mostrar_tela_gerenciar()

    def _acao_acervo(self):
        self.app_controller.mostrar_tela_acervo()

    def _acao_ver_relatorios(self):
        self.app_controller.mostrar_tela_relatorios()