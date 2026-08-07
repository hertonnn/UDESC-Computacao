import tkinter as tk
from tkinter import ttk, messagebox
from typing import Optional

from service.acervo_service import AcervoService
from model.livro_model import Livro

class ViewListarLivros(ttk.Frame):
    def __init__(self, container, app_controller, db_conn):
        super().__init__(container, style='White.TFrame')

        self.app_controller = app_controller
        self.acervo_service = AcervoService(db_conn)
        
        # Create header
        cor_barra = '#435998'
        barra_superior = tk.Frame(self, bg=cor_barra, height=60)
        barra_superior.pack(side=tk.TOP, fill='x')

        barra_inferior = tk.Frame(self, bg=cor_barra, height=60)
        barra_inferior.pack(side=tk.BOTTOM, fill='x')

        self.label_principal = ttk.Label(barra_superior, text="Listar / Buscar Livros", style='Titulo.TLabel')
        self.label_principal.pack(pady=(20, 20))

        # Create main content area
        content = ttk.Frame(self, style='White.TFrame')
        content.pack(fill='both', expand=True, padx=30, pady=20)

        # Search frame
        search_frame = ttk.Frame(content, style='White.TFrame')
        search_frame.pack(fill='x', pady=(0, 10))

        # Search components
        ttk.Label(search_frame, text="Buscar por título:", style='White.TLabel').pack(side=tk.LEFT, padx=(0, 10))
        self.search_entry = ttk.Entry(search_frame, width=40)
        self.search_entry.pack(side=tk.LEFT, padx=(0, 10))
        
        ttk.Button(search_frame, text="Buscar", 
                  command=self._buscar_livros).pack(side=tk.LEFT)
        
        ttk.Button(search_frame, text="Mostrar Todos", 
                  command=self._mostrar_todos_livros).pack(side=tk.LEFT, padx=(10, 0))

        # Create Treeview for books
        self.tree_frame = ttk.Frame(content, style='White.TFrame')
        self.tree_frame.pack(fill='both', expand=True)

        self.tree = ttk.Treeview(self.tree_frame, columns=('ID', 'Título', 'ISBN', 'Coleção'),
                                show='headings', selectmode='browse')
        
        # Configure columns
        self.tree.heading('ID', text='ID')
        self.tree.heading('Título', text='Título')
        self.tree.heading('ISBN', text='ISBN')
        self.tree.heading('Coleção', text='Coleção')
        
        self.tree.column('ID', width=50)
        self.tree.column('Título', width=300)
        self.tree.column('ISBN', width=120)
        self.tree.column('Coleção', width=150)

        # Add scrollbar
        scrollbar = ttk.Scrollbar(self.tree_frame, orient='vertical', command=self.tree.yview)
        self.tree.configure(yscrollcommand=scrollbar.set)
        
        # Pack tree and scrollbar
        self.tree.pack(side=tk.LEFT, fill='both', expand=True)
        scrollbar.pack(side=tk.RIGHT, fill='y')

        # Add return button
        self.voltar = ttk.Button(
            barra_inferior, 
            text="Voltar",
            style='Barra.TButton',
            command=self._acao_voltar
        )
        self.voltar.pack(side=tk.RIGHT, padx=30, pady=15)

        # Load initial data
        self._mostrar_todos_livros()

    def _mostrar_todos_livros(self):
        """Load and display all books"""
        try:
            self._limpar_tree()
            livros = self.acervo_service.listar_livros()
            self._preencher_tree(livros)
        except Exception as e:
            messagebox.showerror("Erro", f"Erro ao listar livros: {str(e)}")

    def _buscar_livros(self):
        """Search books by title"""
        termo = self.search_entry.get().strip()
        if not termo:
            messagebox.showinfo("Aviso", "Digite um termo para busca")
            return
        
        if len(termo) < 3:
            messagebox.showinfo("Aviso", "Digite pelo menos 3 caracteres para buscar")
            return

        try:
            self._limpar_tree()
            livros = self.acervo_service.buscar_livro_por_titulo(termo)
            if not livros:
                messagebox.showinfo("Resultado", "Nenhum livro encontrado")
                return
            self._preencher_tree(livros)
        except Exception as e:
            messagebox.showerror("Erro", f"Erro ao buscar livros: {str(e)}")

    def _limpar_tree(self):
        """Clear all items from the treeview"""
        for item in self.tree.get_children():
            self.tree.delete(item)

    def _preencher_tree(self, livros):
        """Fill treeview with book data"""
        for livro in livros:
            self.tree.insert('', 'end', values=(
                livro.id_livro,
                livro.titulo,
                livro.isbn or 'N/A',
                livro.id_colecao or 'N/A'
            ))

    def _acao_voltar(self):
        """Return to the previous screen"""
        self.app_controller.mostrar_tela_acervo()