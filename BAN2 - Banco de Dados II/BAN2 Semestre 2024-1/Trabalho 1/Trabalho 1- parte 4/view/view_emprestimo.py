import tkinter as tk
from tkinter import ttk, messagebox

import exceptions

from service.emprestimo_service import EmprestimoService
from service.usuario_service import UsuarioService
from model.exemplar_model import ExemplarModel

class Viewemprestimo(ttk.Frame):

    def __init__(self, container, app_controller, db_conn):

        super().__init__(container, style='White.TFrame')

        self.app_controller = app_controller
        self.db_conn = db_conn

        self.emprestimo_service = EmprestimoService(db_conn)
        self.usuario_service = UsuarioService(db_conn)
        self.exemplar_model = ExemplarModel()

        self.id_usuario_selecionado = None
        self.label_usuario_var = tk.StringVar(value="Nenhum usuário selecionado")
        self.mapa_exemplares_para_emprestar = {} 

        cor_barra = '#435998'
        barra_superior = tk.Frame(self, bg=cor_barra, height=60)
        barra_superior.pack(side=tk.TOP, fill='x')

        barra_inferior = tk.Frame(self, bg=cor_barra, height=60)
        barra_inferior.pack(side=tk.BOTTOM, fill='x')

        self.label_principal = ttk.Label(barra_superior, text = "Realizar Empréstimo", style='Titulo.TLabel')
        self.label_principal.pack(pady=(20, 20))

        self.frame_usuario = ttk.Frame(self, style='White.TFrame')
        self.frame_usuario.pack(fill='x', padx=20, pady=10)

        self.frame_exemplar = ttk.Frame(self, style='White.TFrame')
        self.frame_exemplar.pack(fill='x', padx=20, pady=10)

        self.frame_confirmar = ttk.Frame(self, style='White.TFrame')
        self.frame_confirmar.pack(fill='x', padx=20, pady=20)

        self._criar_widgets_usuario()
        self._criar_widgets_exemplar()
        self._criar_widgets_confirmar()

        self.voltar = ttk.Button(
            barra_inferior, 
            text = "Voltar",
            style='Barra.TButton',
            command=self._acao_voltar
        )
        self.voltar.pack(side=tk.RIGHT, padx=30, pady=15)
    
    def _acao_voltar(self):
        self.app_controller.mostrar_tela_principal(self.app_controller.id_bibliotecario_logado)

    def _criar_widgets_usuario(self):

        frame_busca = ttk.Frame(self.frame_usuario, style='White.TFrame')
        frame_busca.pack(fill='x', padx=10, pady=5)
        
        label_titulo = ttk.Label(frame_busca, text="Identificar Usuário", style='Bold2.TLabel')
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
        if not item_selecionado:
            return
            
        item_data = self.tree_usuarios.item(item_selecionado)
        valores = item_data['values']
        
        self.id_usuario_selecionado = valores[0] 
        nome_usuario = valores[1]                
        
        self.label_usuario_var.set(f"Usuário Selecionado: {nome_usuario} (ID: {self.id_usuario_selecionado})")

    def _criar_widgets_exemplar(self):
 
        frame_busca_ex = ttk.Frame(self.frame_exemplar, style='White.TFrame')
        frame_busca_ex.pack(fill='x', padx=10, pady=5)

        label_titulo = ttk.Label(frame_busca_ex, text="Adicionar Exemplar", style='Bold2.TLabel')
        label_titulo.pack(side=tk.LEFT, padx=(0, 10))

        label_busca_ex = ttk.Label(frame_busca_ex, text="Código do Exemplar:", style='White.TLabel')
        label_busca_ex.pack(side=tk.LEFT, padx=(0, 10))

        self.entry_busca_exemplar = ttk.Entry(frame_busca_ex, width=20)
        self.entry_busca_exemplar.pack(side=tk.LEFT, padx=5)

        btn_add = ttk.Button(frame_busca_ex, text="Adicionar", command=self._acao_adicionar_exemplar)
        btn_add.pack(side=tk.LEFT, padx=5)

        frame_tabela_ex = ttk.Frame(self.frame_exemplar)
        frame_tabela_ex.pack(fill='both', expand=True, padx=10, pady=10)

        colunas_ex = ('id', 'titulo')
        self.tree_exemplares = ttk.Treeview(frame_tabela_ex, columns=colunas_ex, show='headings', height=4)
        
        self.tree_exemplares.heading('id', text='ID Exemplar')
        self.tree_exemplares.column('id', width=100, stretch=False)
        self.tree_exemplares.heading('titulo', text='Título')
        self.tree_exemplares.column('titulo', width=350)

        scrollbar_ex = ttk.Scrollbar(frame_tabela_ex, orient=tk.VERTICAL, command=self.tree_exemplares.yview)
        self.tree_exemplares.configure(yscroll=scrollbar_ex.set)
        
        scrollbar_ex.pack(side=tk.RIGHT, fill=tk.Y)
        self.tree_exemplares.pack(side=tk.LEFT, fill=tk.BOTH, expand=True)
    
    def _acao_adicionar_exemplar(self, event = None):
        try:
            id_exemplar = int(self.entry_busca_exemplar.get())
        except ValueError:
            messagebox.showwarning("Entrada Inválida", "O ID do exemplar deve ser um número.")
            return

        if id_exemplar in self.mapa_exemplares_para_emprestar:
            messagebox.showinfo("Item Duplicado", "Este exemplar já foi adicionado.")
            self.entry_busca_exemplar.delete(0, 'end') 
            return

        try:
            exemplar = self.exemplar_model.get_exemplar_by_id(id_exemplar, self.db_conn)
            
            if not exemplar:
                raise exceptions.RecursoNaoEncontradoException("Exemplar não encontrado.")
            
            titulo = exemplar.titulo_livro
            
            self.mapa_exemplares_para_emprestar[id_exemplar] = titulo
            
            self.tree_exemplares.insert('', 'end', values=(id_exemplar, titulo))

            self.entry_busca_exemplar.delete(0, 'end')    
        except exceptions.RecursoNaoEncontradoException:
            messagebox.showwarning("Não Encontrado", f"Exemplar com ID {id_exemplar} não encontrado.")
        except Exception as e:
            messagebox.showerror("Erro", f"Erro ao adicionar exemplar: {e}")

    def _criar_widgets_confirmar(self):
        self.btn_confirmar = ttk.Button(
            self.frame_confirmar, 
            text="Confirmar Empréstimo", 
            command=self._acao_confirmar_emprestimo,
            style='Botao.TButton' 
        )
        self.btn_confirmar.pack(side=tk.TOP, fill='x', ipady=10)


    def _acao_confirmar_emprestimo(self):
        
        if self.id_usuario_selecionado is None:
            messagebox.showwarning("Nenhum usuário foi selecionado.")
            return 
            
        ids_exemplares = list(self.mapa_exemplares_para_emprestar.keys())
        if not ids_exemplares:
            messagebox.showwarning("Nenhum exemplar foi adicionado.")
            return 
            
        id_bibliotecario = self.app_controller.id_bibliotecario_logado

        try:
            id_emprestimo = self.emprestimo_service.realizar_emprestimo(
                self.id_usuario_selecionado, 
                ids_exemplares, 
                id_bibliotecario
            )
            
            messagebox.showinfo("Sucesso!", f"Empréstimo (ID: {id_emprestimo}) realizado com sucesso!")
            
            self._limpar_tela()
        
        except exceptions.PendenciaException as e:
            messagebox.showwarning("Pendência", f"Usuário com pendências. Empréstimo bloqueado.\nDetalhe: {e}")
        except exceptions.LimiteExcedidoException as e:
            messagebox.showwarning("Limite Atingido", f"Empréstimo bloqueado.\nDetalhe: {e}")
        except exceptions.ColecaoReservadaException as e:
            messagebox.showwarning("Coleção Reservada", f"Empréstimo bloqueado.\nDetalhe: {e}")
        except exceptions.ReservaException as e:
            messagebox.showwarning("Item Reservado", f"Empréstimo bloqueado.\nDetalhe: {e}")
        except (exceptions.NegocioException, exceptions.RecursoNaoEncontradoException) as e:
            messagebox.showerror("Erro de Negócio", f"Não foi possível completar a operação:\n{e}")
        except Exception as e: 
            messagebox.showerror("Erro Inesperado", f"Ocorreu um erro inesperado:\n{e}")

    def _limpar_tela(self):

        self._limpar_selecao_usuario()
        self.entry_busca_usuario.delete(0, 'end')
        for i in self.tree_usuarios.get_children():
            self.tree_usuarios.delete(i)
            
        self.mapa_exemplares_para_emprestar = {} 
        self.entry_busca_exemplar.delete(0, 'end')
        for i in self.tree_exemplares.get_children():
            self.tree_exemplares.delete(i)