import tkinter as tk
from tkinter import ttk, messagebox

import exceptions

class Viewacervo(ttk.Frame):

    def __init__(self, container, app_controller, db_conn):

        super().__init__(container, style='White.TFrame')

        self.app_controller = app_controller

        cor_barra = '#435998'
        barra_superior = tk.Frame(self, bg=cor_barra, height=60)
        barra_superior.pack(side=tk.TOP, fill='x')

        barra_inferior = tk.Frame(self, bg=cor_barra, height=60)
        barra_inferior.pack(side=tk.BOTTOM, fill='x')

        self.label_principal = ttk.Label(barra_superior, text = "Acervo", style='Titulo.TLabel')
        self.label_principal.pack(pady=(20, 20))

        self.voltar = ttk.Button(
            barra_inferior, 
            text = "Voltar",
            style='Barra.TButton',
            command=self._acao_voltar
        )
        self.voltar.pack(side=tk.RIGHT, padx=30, pady=15)
        
        # Content area with buttons for acervo flows
        content = ttk.Frame(self, style='White.TFrame')
        content.pack(fill='both', expand=True, padx=30, pady=20)

        # Use a simple grid: 2 columns x 3 rows
        btn_style = 'Botao.TButton'

        self.btn_autores = ttk.Button(content, text="Autores", style=btn_style,
                                      command=self.app_controller.mostrar_tela_autores)
        self.btn_editoras = ttk.Button(content, text="Editoras", style=btn_style,
                                       command=self.app_controller.mostrar_tela_editoras)
        self.btn_colecoes = ttk.Button(content, text="Coleções", style=btn_style,
                                       command=self.app_controller.mostrar_tela_colecoes)
        self.btn_listar_livros = ttk.Button(content, text="Listar / Buscar Livros", style=btn_style,
                                            command=self.app_controller.mostrar_tela_listar_livros)
        self.btn_adicionar_editar_livros = ttk.Button(content, text="Adicionar / Editar Livros", style=btn_style,
                                                      command=self.app_controller.mostrar_tela_editar_livros)
        self.btn_adicionar_exemplares = ttk.Button(content, text="Adicionar Exemplares", style=btn_style,
                                                   command=self.app_controller.mostrar_tela_exemplares)

        # grid placement
        self.btn_autores.grid(row=0, column=0, padx=10, pady=12, sticky='nsew')
        self.btn_editoras.grid(row=0, column=1, padx=10, pady=12, sticky='nsew')
        self.btn_colecoes.grid(row=1, column=0, padx=10, pady=12, sticky='nsew')
        self.btn_listar_livros.grid(row=1, column=1, padx=10, pady=12, sticky='nsew')
        self.btn_adicionar_editar_livros.grid(row=2, column=0, padx=10, pady=12, sticky='nsew')
        self.btn_adicionar_exemplares.grid(row=2, column=1, padx=10, pady=12, sticky='nsew')

        # Make grid cells expand evenly
        for i in range(3):
            content.rowconfigure(i, weight=1)
        for j in range(2):
            content.columnconfigure(j, weight=1)

    def _call_controller_candidates(self, candidates):
        """
        Try a list of controller method names in order. If a callable is found, call it.
        If the callable expects a parameter, pass the currently logged bibliotecario id.
        Otherwise show an "Em desenvolvimento" info box.
        """
        import inspect

        for name in candidates:
            func = getattr(self.app_controller, name, None)
            if callable(func):
                try:
                    sig = inspect.signature(func)
                    # if no params, call directly
                    if len(sig.parameters) == 0:
                        return func()
                    # otherwise try passing logged id if available
                    return func(self.app_controller.id_bibliotecario_logado)
                except Exception as e:
                    messagebox.showerror("Erro", f"Erro ao chamar {name}: {e}")
                    return

        messagebox.showinfo("Em desenvolvimento", "Funcionalidade não implementada ainda.")
    
    def _acao_voltar(self):
        self.app_controller.mostrar_tela_principal(self.app_controller.id_bibliotecario_logado)



    