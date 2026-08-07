import tkinter as tk
from tkinter import ttk, messagebox

import exceptions
from service.usuario_service import UsuarioService
from model.usuario_model import UsuarioModel

class Viewgerenciar(ttk.Frame):

    def __init__(self, container, app_controller, db_conn):

        super().__init__(container, style='White.TFrame')

        self.app_controller = app_controller
        self.usuario_service = UsuarioService(db_conn) 

        self.nome_var = tk.StringVar()
        self.telefone_var = tk.StringVar()
        self.endereco_var = tk.StringVar()
        self.categoria_var = tk.StringVar()
        self.tipo_contrato_var = tk.StringVar()

        cor_barra = '#435998'
        barra_superior = tk.Frame(self, bg=cor_barra, height=60)
        barra_superior.pack(side=tk.TOP, fill='x')

        barra_inferior = tk.Frame(self, bg=cor_barra, height=60)
        barra_inferior.pack(side=tk.BOTTOM, fill='x')

        self.label_principal = ttk.Label(barra_superior, text = "Gerenciar Usuários", style='Titulo.TLabel')
        self.label_principal.pack(pady=(20, 20))

        self.frame_cadastro = ttk.Frame(self, style='White.TFrame')
        self.frame_cadastro.pack(fill='x', padx=20, pady=(20, 10))

        self.frame_confirmar = ttk.Frame(self, style='White.TFrame')
        self.frame_confirmar.pack(fill='x', padx=20, pady=20)
        
        self.frame_usuario = ttk.Frame(self, style='White.TFrame')
        self.frame_usuario.pack(fill='x', padx=20, pady=10)

        self._criar_widgets_cadastro()
        self._criar_widgets_confirmar()
        self._criar_widgets_usuario()

        self.voltar = ttk.Button(
            barra_inferior, 
            text = "Voltar",
            style='Barra.TButton',
            command=self._acao_voltar
        )
        self.voltar.pack(side=tk.RIGHT, padx=30, pady=15)
    
    def _acao_voltar(self):
        self.app_controller.mostrar_tela_principal(self.app_controller.id_bibliotecario_logado)

    def _criar_widgets_cadastro(self):
        
        label_titulo_cad = ttk.Label(self.frame_cadastro, text="Cadastrar Novo Usuário", style='Bold2.TLabel')
        label_titulo_cad.pack(anchor='w', padx=10, pady=(0, 10))

        frame_form = ttk.Frame(self.frame_cadastro, style='White.TFrame')
        frame_form.pack(fill='x', padx=10)

        frame_form.columnconfigure(1, weight=1) 

        label_nome = ttk.Label(frame_form, text="Nome:", style='White.TLabel')
        label_nome.grid(row=0, column=0, padx=(0, 5), pady=5, sticky='w')
        entry_nome = ttk.Entry(frame_form, textvariable=self.nome_var, width=50)
        entry_nome.grid(row=0, column=1, padx=5, pady=5, sticky='ew')

        label_endereco = ttk.Label(frame_form, text="Cidade:", style='White.TLabel')
        label_endereco.grid(row=1, column=0, padx=(0, 5), pady=5, sticky='w')
        entry_endereco = ttk.Entry(frame_form, textvariable=self.endereco_var)
        entry_endereco.grid(row=1, column=1, padx=5, pady=5, sticky='ew')

        label_telefone = ttk.Label(frame_form, text="Telefone:", style='White.TLabel')
        label_telefone.grid(row=2, column=0, padx=(0, 5), pady=5, sticky='w')
        entry_telefone = ttk.Entry(frame_form, textvariable=self.telefone_var)
        entry_telefone.grid(row=2, column=1, padx=5, pady=5, sticky='ew')

        label_categoria = ttk.Label(frame_form, text="Categoria:", style='White.TLabel')
        label_categoria.grid(row=3, column=0, padx=(0, 5), pady=5, sticky='w')
        
        categorias = ['aluno_grad', 'aluno_pos', 'professor', 'professor_pos']
        self.combo_categoria = ttk.Combobox(frame_form, textvariable=self.categoria_var, values=categorias, state='readonly')
        self.combo_categoria.grid(row=3, column=1, padx=5, pady=5, sticky='ew')
        self.combo_categoria.bind('<<ComboboxSelected>>', self._on_categoria_select)

        self.label_tipo_contrato = ttk.Label(frame_form, text="Tipo de Contrato:", style='White.TLabel')
        self.label_tipo_contrato.grid(row=4, column=0, padx=(0, 5), pady=5, sticky='w')
        
        contratos = ['integral', 'meio período']
        self.combo_tipo_contrato = ttk.Combobox(frame_form, textvariable=self.tipo_contrato_var, values=contratos, state='readonly')
        self.combo_tipo_contrato.grid(row=4, column=1, padx=5, pady=5, sticky='ew')

        self.label_tipo_contrato.grid_remove()
        self.combo_tipo_contrato.grid_remove()

    def _on_categoria_select(self, event=None):
        categoria = self.categoria_var.get()
        if categoria in ['professor', 'professor_pos']:
            self.label_tipo_contrato.grid()
            self.combo_tipo_contrato.grid()
        else:
            self.label_tipo_contrato.grid_remove()
            self.combo_tipo_contrato.grid_remove()
            self.tipo_contrato_var.set('') 

    def _criar_widgets_usuario(self):

        frame_busca = ttk.Frame(self.frame_usuario, style='White.TFrame')
        frame_busca.pack(fill='x', padx=10, pady=5)
        
        label_titulo = ttk.Label(frame_busca, text="Buscar Usuários", style='Bold2.TLabel')
        label_titulo.pack(side=tk.LEFT, padx=(0, 10))
        
        label_busca = ttk.Label(frame_busca, text="Buscar por Nome:", style='White.TLabel')
        label_busca.pack(side=tk.LEFT, padx=(0, 10))

        self.entry_busca_usuario = ttk.Entry(frame_busca, width=20)
        self.entry_busca_usuario.pack(side=tk.LEFT, padx=5)

        btn_buscar = ttk.Button(frame_busca, text="Buscar", command=self._acao_buscar_usuario)
        btn_buscar.pack(side=tk.LEFT, padx=5)
        
        btn_listar_todos = ttk.Button(frame_busca, text="Listar", command=self._acao_listar_todos)
        btn_listar_todos.pack(side=tk.LEFT, padx=5)

        frame_tabela_usr = ttk.Frame(self.frame_usuario)
        frame_tabela_usr.pack(fill='both', expand=True, padx=10, pady=10)

        colunas = ('id', 'nome', 'categoria', 'telefone')
        self.tree_usuarios = ttk.Treeview(frame_tabela_usr, columns=colunas, show='headings', height=5)
        
        self.tree_usuarios.heading('id', text='ID')
        self.tree_usuarios.column('id', width=50, stretch=False)
        self.tree_usuarios.heading('nome', text='Nome')
        self.tree_usuarios.column('nome', width=250)
        self.tree_usuarios.heading('categoria', text='Categoria')
        self.tree_usuarios.column('categoria', width=100)
        self.tree_usuarios.heading('telefone', text='Telefone')
        self.tree_usuarios.column('telefone', width=100)
        
        scrollbar_usr = ttk.Scrollbar(frame_tabela_usr, orient=tk.VERTICAL, command=self.tree_usuarios.yview)
        self.tree_usuarios.configure(yscroll=scrollbar_usr.set)
        
        scrollbar_usr.pack(side=tk.RIGHT, fill=tk.Y)
        self.tree_usuarios.pack(side=tk.LEFT, fill=tk.BOTH, expand=True)

    def _popular_treeview(self, usuarios):
        for i in self.tree_usuarios.get_children():
            self.tree_usuarios.delete(i)
            
        if not usuarios:
            messagebox.showinfo("Busca", "Nenhum usuário encontrado.")
            return

        for usuario in usuarios:
            self.tree_usuarios.insert('', 'end', values=(
                usuario.id_usuario, 
                usuario.nome, 
                usuario.categoria,
                usuario.telefone
            ))

    def _acao_buscar_usuario(self): 
        termo_busca = self.entry_busca_usuario.get()
            
        if not termo_busca or len(termo_busca) < 3:
            messagebox.showinfo("Busca", "Digite ao menos 3 caracteres para buscar.")
            return

        try:
            usuarios = self.usuario_service.buscar_usuarios_por_nome_parcial(termo_busca) 
            self._popular_treeview(usuarios)

        except exceptions.RecursoNaoEncontradoException as e:
             messagebox.showinfo("Busca", str(e))
        except Exception as e:
            messagebox.showerror("Erro de Busca", f"Ocorreu um erro ao buscar usuários: {e}")

    def _acao_listar_todos(self):
        try:
            usuarios = self.usuario_service.listar_todos_usuarios()
            self._popular_treeview(usuarios)
        except Exception as e:
            messagebox.showerror("Erro de Busca", f"Ocorreu um erro ao listar usuários: {e}")


    def _criar_widgets_confirmar(self):
        self.btn_confirmar = ttk.Button(
            self.frame_confirmar, 
            text="Confirmar Cadastro", 
            command=self._acao_confirmar_cadastro,
            style='Botao.TButton' 
        )
        self.btn_confirmar.pack(side=tk.TOP, fill='x', ipady=10)

    def _acao_confirmar_cadastro(self):
        
        nome = self.nome_var.get().strip()
        telefone = self.telefone_var.get().strip()
        endereco = self.endereco_var.get().strip()
        categoria = self.categoria_var.get()
        tipo_contrato = self.tipo_contrato_var.get()

        if not nome:
            messagebox.showwarning("Campo Obrigatório", "O nome não pode ser vázio.")
            return 
        
        if not telefone:
            messagebox.showwarning("Campo Obrigatório", "O telefone não pode ser vázio.")
            return 
        
        if not endereco:
            messagebox.showwarning("Campo Obrigatório", "O endereço não pode ser vázio.")
            return 
        
        if not categoria:
            messagebox.showwarning("Campo Obrigatório", "A categoria não pode ser vázia.")
            return 
        
        usuario_dict = {
            "nome": nome, 
            "telefone": telefone,
            "endereco": endereco,
            "categoria": categoria
        } 

        if categoria in ['professor', 'professor_pos']:
            if not tipo_contrato:
                messagebox.showwarning("Campo Obrigatório", "O tipo de contrato é obrigatório para professores.")
                return
            usuario_dict["tipo_contrato"] = tipo_contrato
        
        try:
            id_usuario = self.usuario_service.criar_usuario(**usuario_dict) 
            
            messagebox.showinfo("Sucesso!", f"Usuário(ID: {id_usuario}) cadastrado com sucesso!")
            
            self._limpar_tela()
            self._acao_listar_todos() 
        
        except (exceptions.NegocioException, exceptions.RecursoNaoEncontradoException) as e:
            messagebox.showerror("Erro de Negócio", f"Não foi possível completar a operação:\n{e}")
        except Exception as e: 
            messagebox.showerror("Erro Inesperado", f"Ocorreu um erro inesperado:\n{e}")

    def _limpar_tela(self):
        
        self.nome_var.set('')
        self.telefone_var.set('')
        self.endereco_var.set('')
        self.categoria_var.set('')
        self.tipo_contrato_var.set('')
        self._on_categoria_select() 

        self.entry_busca_usuario.delete(0, 'end')
        for i in self.tree_usuarios.get_children():
            self.tree_usuarios.delete(i)