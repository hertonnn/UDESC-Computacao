import tkinter as tk
from tkinter import ttk, messagebox
from service.exemplar_service import ExemplarService
from service.acervo_service import AcervoService

class ViewExemplares(ttk.Frame):
    def __init__(self, container, app_controller, db_conn):
        super().__init__(container, style='White.TFrame')
        
        self.app_controller = app_controller
        self.exemplar_service = ExemplarService(db_conn)
        self.acervo_service = AcervoService(db_conn)
        
        # Barra superior
        cor_barra = '#435998'
        barra_superior = tk.Frame(self, bg=cor_barra, height=60)
        barra_superior.pack(side=tk.TOP, fill='x')
        
        # Título
        self.label_principal = ttk.Label(barra_superior, text="Gerenciar Exemplares", style='Titulo.TLabel')
        self.label_principal.pack(pady=20)
        
        # Área de conteúdo
        content = ttk.Frame(self, style='White.TFrame')
        content.pack(fill='both', expand=True, padx=30, pady=20)
        
        # Frame para pesquisa
        search_frame = ttk.Frame(content, style='White.TFrame')
        search_frame.pack(fill='x', pady=(0, 20))
        
        # Combobox para selecionar livro
        ttk.Label(search_frame, text="Filtrar por Livro:", style='Label.TLabel').pack(side=tk.LEFT, padx=(0, 10))
        self.livro_var = tk.StringVar()
        self.combo_livros = ttk.Combobox(search_frame, textvariable=self.livro_var, width=50)
        self.combo_livros.pack(side=tk.LEFT, padx=(0, 10))
        self.combo_livros.bind('<<ComboboxSelected>>', self._filtrar_exemplares)
        
        # Botão para limpar filtro
        ttk.Button(search_frame, text="Limpar Filtro", 
                  command=self._limpar_filtro, style='Botao.TButton').pack(side=tk.LEFT)
        
        # Treeview para listar exemplares
        self.tree = ttk.Treeview(content, columns=('numero', 'livro', 'situacao', 'reservada'), 
                                show='headings', height=10)
        self.tree.heading('numero', text='Nº Exemplar')
        self.tree.heading('livro', text='Livro')
        self.tree.heading('situacao', text='Situação')
        self.tree.heading('reservada', text='Coleção Reservada')
        
        self.tree.column('numero', width=100)
        self.tree.column('livro', width=300)
        self.tree.column('situacao', width=100)
        self.tree.column('reservada', width=150)
        
        # Scrollbar para o treeview
        scrollbar = ttk.Scrollbar(content, orient=tk.VERTICAL, command=self.tree.yview)
        self.tree.configure(yscrollcommand=scrollbar.set)
        
        self.tree.pack(side=tk.LEFT, fill='both', expand=True)
        scrollbar.pack(side=tk.RIGHT, fill='y')
        
        # Frame para adicionar exemplar
        add_frame = ttk.Frame(self, style='White.TFrame')
        add_frame.pack(fill='x', padx=30, pady=20)
        
        ttk.Label(add_frame, text="Adicionar Novo Exemplar", style='Label.TLabel').pack(pady=(0, 10))
        
        # Frame para campos de entrada
        input_frame = ttk.Frame(add_frame, style='White.TFrame')
        input_frame.pack(fill='x')
        
        # Campo para ID do livro
        ttk.Label(input_frame, text="ID do Livro:", style='Label.TLabel').pack(side=tk.LEFT, padx=(0, 5))
        self.id_livro_var = tk.StringVar()
        self.entry_id_livro = ttk.Entry(input_frame, textvariable=self.id_livro_var, width=10)
        self.entry_id_livro.pack(side=tk.LEFT, padx=(0, 20))
        
        # Checkbox para coleção reservada
        self.is_reservada_var = tk.BooleanVar()
        self.check_reservada = ttk.Checkbutton(input_frame, text="Coleção Reservada",
                                              variable=self.is_reservada_var)
        self.check_reservada.pack(side=tk.LEFT)
        
        # Botão para adicionar
        ttk.Button(input_frame, text="Adicionar Exemplar", 
                  command=self._adicionar_exemplar, style='Botao.TButton').pack(side=tk.LEFT, padx=20)
        
        # Barra inferior
        barra_inferior = tk.Frame(self, bg=cor_barra, height=60)
        barra_inferior.pack(side=tk.BOTTOM, fill='x')
        
        # Botão voltar
        self.voltar = ttk.Button(barra_inferior, text="Voltar", style='Barra.TButton',
                                command=self._acao_voltar)
        self.voltar.pack(side=tk.RIGHT, padx=30, pady=15)
        
        # Inicializar dados
        self._carregar_livros()
        self._atualizar_lista()
    
    def _carregar_livros(self):
        """Carrega a lista de livros no combobox."""
        livros = self.acervo_service.listar_livros()
        self.livros_dict = {f"{livro.id_livro} - {livro.titulo}": livro.id_livro for livro in livros}
        self.combo_livros['values'] = list(self.livros_dict.keys())
    
    def _atualizar_lista(self, id_livro: int = None):
        """Atualiza a lista de exemplares no treeview."""
        for item in self.tree.get_children():
            self.tree.delete(item)
            
        exemplares = self.exemplar_service.listar_exemplares(id_livro)
        for exemplar in exemplares:
            self.tree.insert('', 'end', values=(
                exemplar.numero_exemplar,
                exemplar.titulo_livro,
                exemplar.situacao,
                "Sim" if exemplar.is_colecao_reservada else "Não"
            ))
    
    def _filtrar_exemplares(self, event=None):
        """Filtra os exemplares pelo livro selecionado."""
        if self.livro_var.get():
            id_livro = self.livros_dict[self.livro_var.get()]
            self._atualizar_lista(id_livro)
    
    def _limpar_filtro(self):
        """Limpa o filtro de livros."""
        self.livro_var.set('')
        self._atualizar_lista()
    
    def _adicionar_exemplar(self):
        """Adiciona um novo exemplar."""
        try:
            id_livro = int(self.id_livro_var.get())
            if not self.exemplar_service.verificar_livro_existe(id_livro):
                messagebox.showerror("Erro", "Livro não encontrado!")
                return
                
            is_reservada = self.is_reservada_var.get()
            numero_exemplar = self.exemplar_service.buscar_proximo_numero_exemplar(id_livro)
            
            self.exemplar_service.adicionar_exemplar(
                id_livro=id_livro,
                numero_exemplar=numero_exemplar,
                is_colecao_reservada=is_reservada
            )
            
            messagebox.showinfo("Sucesso", f"Exemplar {numero_exemplar} adicionado com sucesso!")
            self._atualizar_lista()
            self.id_livro_var.set('')
            self.is_reservada_var.set(False)
            
        except ValueError:
            messagebox.showerror("Erro", "ID do livro deve ser um número!")
        except Exception as e:
            messagebox.showerror("Erro", str(e))
    
    def _acao_voltar(self):
        """Volta para a tela anterior."""
        self.app_controller.mostrar_tela_acervo()