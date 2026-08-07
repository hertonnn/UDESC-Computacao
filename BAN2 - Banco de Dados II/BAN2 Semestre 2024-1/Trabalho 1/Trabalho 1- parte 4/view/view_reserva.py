import tkinter as tk
from tkinter import ttk, messagebox

import exceptions
from service.reserva_service import ReservaService
from service.usuario_service import UsuarioService 
from model.livro_model import LivroModel

class Viewreserva(ttk.Frame):

    def __init__(self, container, app_controller, db_conn):

        super().__init__(container, style='White.TFrame')

        self.app_controller = app_controller
        self.db_conn = db_conn

        self.reserva_service = ReservaService(db_conn)
        self.usuario_service = UsuarioService(db_conn)
        self.livro_model = LivroModel()

        self.id_usuario_selecionado = None
        self.label_usuario_var = tk.StringVar(value="Nenhum usuário selecionado")
        
        self.id_livro_selecionado = None
        self.label_livro_var = tk.StringVar(value="Nenhum livro selecionado")

        cor_barra = '#435998'
        barra_superior = tk.Frame(self, bg=cor_barra, height=60)
        barra_superior.pack(side=tk.TOP, fill='x')

        barra_inferior = tk.Frame(self, bg=cor_barra, height=60)
        barra_inferior.pack(side=tk.BOTTOM, fill='x')

        self.label_principal = ttk.Label(barra_superior, text = "Realizar Reserva", style='Titulo.TLabel')
        self.label_principal.pack(pady=(20, 20))

        self.frame_usuario = ttk.Frame(self, style='White.TFrame')
        self.frame_usuario.pack(fill='x', padx=10, pady=5)

        self.frame_livro = ttk.Frame(self, style='White.TFrame')
        self.frame_livro.pack(fill='x', padx=10, pady=5)

        self.frame_confirmar = ttk.Frame(self, style='White.TFrame')
        self.frame_confirmar.pack(fill='x', padx=20, pady=5)

        self._criar_widgets_usuario()
        self._criar_widgets_livro()
        self._criar_widgets_confirmar()

        self.voltar = ttk.Button(
            barra_inferior, 
            text = "Voltar",
            style='Barra.TButton',
            command=self._acao_voltar
        )
        self.voltar.pack(side=tk.RIGHT, padx=30, pady=15)
    
    def _acao_voltar(self):
        self._limpar_tela()
        self.app_controller.mostrar_tela_principal(self.app_controller.id_bibliotecario_logado)


    def _criar_widgets_usuario(self):
        frame_busca = ttk.Frame(self.frame_usuario, style='White.TFrame')
        frame_busca.pack(fill='x', padx=10, pady=5)
        
        label_titulo = ttk.Label(frame_busca, text="1. Identificar Usuário", style='Bold2.TLabel')
        label_titulo.pack(side=tk.LEFT, padx=(0, 10))
        
        label_busca = ttk.Label(frame_busca, text="Buscar por Nome:", style='White.TLabel')
        label_busca.pack(side=tk.LEFT, padx=(0, 10))

        self.entry_busca_usuario = ttk.Entry(frame_busca, width=20)
        self.entry_busca_usuario.pack(side=tk.LEFT, padx=5)

        btn_buscar = ttk.Button(frame_busca, text="Buscar", command=self._acao_buscar_usuario)
        btn_buscar.pack(side=tk.LEFT, padx=5)

        frame_tabela_usr = ttk.Frame(self.frame_usuario)
        frame_tabela_usr.pack(fill='both', expand=True, padx=10, pady=10)

        colunas = ('id', 'nome', 'categoria')
        self.tree_usuarios = ttk.Treeview(frame_tabela_usr, columns=colunas, show='headings', height=5)
        
        self.tree_usuarios.heading('id', text='ID')
        self.tree_usuarios.column('id', width=50, stretch=False)
        self.tree_usuarios.heading('nome', text='Nome')
        self.tree_usuarios.column('nome', width=300)
        self.tree_usuarios.heading('categoria', text='Categoria')
        self.tree_usuarios.column('categoria', width=100)
        
        scrollbar_usr = ttk.Scrollbar(frame_tabela_usr, orient=tk.VERTICAL, command=self.tree_usuarios.yview)
        self.tree_usuarios.configure(yscroll=scrollbar_usr.set)
        
        scrollbar_usr.pack(side=tk.RIGHT, fill=tk.Y)
        self.tree_usuarios.pack(side=tk.LEFT, fill=tk.BOTH, expand=True)

        self.tree_usuarios.bind('<<TreeviewSelect>>', self._acao_selecionar_usuario)
        
        label_confirmacao = ttk.Label(self.frame_usuario, textvariable=self.label_usuario_var, style='White.TLabel', relief="groove", padding=5)
        label_confirmacao.pack(fill='x', padx=10, pady=(5, 10))

    def _acao_buscar_usuario(self): 
        termo_busca = self.entry_busca_usuario.get()
        
        self._limpar_selecao_usuario()
        for i in self.tree_usuarios.get_children():
            self.tree_usuarios.delete(i)
            
        if not termo_busca or len(termo_busca) < 3:
            messagebox.showinfo("Busca", "Digite ao menos 3 caracteres para buscar.")
            return

        try:
            usuarios = self.usuario_service.buscar_usuarios_por_nome_parcial(termo_busca) 
            if not usuarios:
                messagebox.showinfo("Busca", "Nenhum usuário encontrado com esse nome.")
                return
            for usuario in usuarios:
                self.tree_usuarios.insert('', 'end', values=(usuario.id_usuario, usuario.nome, usuario.categoria))
        except exceptions.RecursoNaoEncontradoException:
             messagebox.showinfo("Busca", "Nenhum usuário encontrado.")
        except Exception as e:
            messagebox.showerror("Erro de Busca", f"Ocorreu um erro ao buscar usuários: {e}")

    def _limpar_selecao_usuario(self):
        self.id_usuario_selecionado = None
        self.label_usuario_var.set("Nenhum usuário selecionado")

    def _acao_selecionar_usuario(self, event = None):
        item_selecionado = self.tree_usuarios.focus() 
        if not item_selecionado: return
            
        valores = self.tree_usuarios.item(item_selecionado)['values']
        self.id_usuario_selecionado = valores[0] 
        nome_usuario = valores[1]                
        self.label_usuario_var.set(f"Usuário Selecionado: {nome_usuario} (ID: {self.id_usuario_selecionado})")

    def _criar_widgets_livro(self):
        frame_busca = ttk.Frame(self.frame_livro, style='White.TFrame')
        frame_busca.pack(fill='x', padx=10, pady=5)
        
        label_titulo = ttk.Label(frame_busca, text="2. Identificar Livro", style='Bold2.TLabel')
        label_titulo.pack(side=tk.LEFT, padx=(0, 10))
        
        label_busca = ttk.Label(frame_busca, text="Buscar por Título:", style='White.TLabel')
        label_busca.pack(side=tk.LEFT, padx=(0, 10))

        self.entry_busca_livro = ttk.Entry(frame_busca, width=20)
        self.entry_busca_livro.pack(side=tk.LEFT, padx=5)

        btn_buscar = ttk.Button(frame_busca, text="Buscar", command=self._acao_buscar_livro)
        btn_buscar.pack(side=tk.LEFT, padx=5)

        frame_tabela_livro = ttk.Frame(self.frame_livro)
        frame_tabela_livro.pack(fill='both', expand=True, padx=10, pady=10)

        colunas = ('id', 'titulo')
        self.tree_livros = ttk.Treeview(frame_tabela_livro, columns=colunas, show='headings', height=5)
        
        self.tree_livros.heading('id', text='ID Livro')
        self.tree_livros.column('id', width=80, stretch=False)
        self.tree_livros.heading('titulo', text='Título do Livro')
        self.tree_livros.column('titulo', width=400)
        
        scrollbar_livro = ttk.Scrollbar(frame_tabela_livro, orient=tk.VERTICAL, command=self.tree_livros.yview)
        self.tree_livros.configure(yscroll=scrollbar_livro.set)
        
        scrollbar_livro.pack(side=tk.RIGHT, fill=tk.Y)
        self.tree_livros.pack(side=tk.LEFT, fill=tk.BOTH, expand=True)

        self.tree_livros.bind('<<TreeviewSelect>>', self._acao_selecionar_livro)
        
        label_confirmacao = ttk.Label(self.frame_livro, textvariable=self.label_livro_var, style='White.TLabel', relief="groove", padding=5)
        label_confirmacao.pack(fill='x', padx=10, pady=(5, 10))

    def _acao_buscar_livro(self): 
        termo_busca = self.entry_busca_livro.get()
        
        self._limpar_selecao_livro()
        for i in self.tree_livros.get_children():
            self.tree_livros.delete(i)
            
        if not termo_busca or len(termo_busca) < 3:
            messagebox.showinfo("Busca", "Digite ao menos 3 caracteres para buscar.")
            return

        try:
            livros = self.livro_model.search_livro_by_titulo(termo_busca, self.db_conn) 
            if not livros:
                messagebox.showinfo("Busca", "Nenhum livro encontrado com esse título.")
                return
            for livro in livros:
                self.tree_livros.insert('', 'end', values=(livro.id_livro, livro.titulo))
        except Exception as e:
            messagebox.showerror("Erro de Busca", f"Ocorreu um erro ao buscar livros: {e}")

    def _limpar_selecao_livro(self):
        self.id_livro_selecionado = None
        self.label_livro_var.set("Nenhum livro selecionado")

    def _acao_selecionar_livro(self, event = None):
        item_selecionado = self.tree_livros.focus() 
        if not item_selecionado: return
            
        valores = self.tree_livros.item(item_selecionado)['values']
        self.id_livro_selecionado = valores[0] 
        nome_livro = valores[1]                
        self.label_livro_var.set(f"Livro Selecionado: {nome_livro} (ID: {self.id_livro_selecionado})")
    
    def _criar_widgets_confirmar(self):
        self.btn_confirmar = ttk.Button(
            self.frame_confirmar, 
            text="Confirmar Reserva", 
            command=self._acao_confirmar_reserva,
            style='Botao.TButton' 
        )
        self.btn_confirmar.pack(side=tk.TOP, fill='x', ipady=10, pady=(5,5))

    def _acao_confirmar_reserva(self):
        
        if self.id_usuario_selecionado is None:
            messagebox.showwarning("Seleção Incompleta", "Nenhum usuário foi selecionado.")
            return 
            
        if self.id_livro_selecionado is None:
            messagebox.showwarning("Seleção Incompleta", "Nenhum livro foi selecionado.")
            return 
            
        try:
            id_reserva = self.reserva_service.realizar_reserva(
                self.id_usuario_selecionado, 
                self.id_livro_selecionado
            )
            
            messagebox.showinfo("Sucesso!", f"Reserva (ID: {id_reserva}) realizada com sucesso!")
            self._limpar_tela()
        
        except exceptions.PendenciaException as e:
            messagebox.showwarning("Pendência", f"Reserva bloqueada.\nDetalhe: {e}")
        except exceptions.NegocioException as e:
            messagebox.showwarning("Regra de Negócio", f"Reserva bloqueada.\nDetalhe: {e}")
        except exceptions.RecursoNaoEncontradoException as e:
            messagebox.showerror("Não Encontrado", f"Não foi possível completar a operação:\n{e}")
        except Exception as e: 
            messagebox.showerror("Erro Inesperado", f"Ocorreu um erro inesperado:\n{e}")

    def _limpar_tela(self):
        self._limpar_selecao_usuario()
        self.entry_busca_usuario.delete(0, 'end')
        for i in self.tree_usuarios.get_children():
            self.tree_usuarios.delete(i)
            
        self._limpar_selecao_livro()
        self.entry_busca_livro.delete(0, 'end')
        for i in self.tree_livros.get_children():
            self.tree_livros.delete(i)