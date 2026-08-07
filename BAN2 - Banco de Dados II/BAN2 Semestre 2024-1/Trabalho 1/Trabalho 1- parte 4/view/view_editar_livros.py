import tkinter as tk
from tkinter import ttk, messagebox
from typing import Optional, Set, Dict, List

from service.acervo_service import AcervoService
from model.autor_model import Autor
from model.editora_model import Editora
from model.colecao_model import Colecao
from model.livro_model import Livro

class ViewEditarLivros(ttk.Frame):
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

        self.label_principal = ttk.Label(barra_superior, text="Adicionar / Editar Livros", style='Titulo.TLabel')
        self.label_principal.pack(pady=(20, 20))

        # Create main content area
        content = ttk.Frame(self, style='White.TFrame')
        content.pack(fill='both', expand=True, padx=30, pady=20)

        # Mode selection
        mode_frame = ttk.Frame(content, style='White.TFrame')
        mode_frame.pack(fill='x', pady=(0, 20))
        
        ttk.Label(mode_frame, text="Selecione a operação:", style='Bold2.TLabel').pack(side=tk.LEFT, padx=(0, 10))
        
        self.mode = tk.StringVar(value="add")
        ttk.Radiobutton(mode_frame, text="Adicionar Novo", variable=self.mode, 
                       value="add", command=self._switch_mode).pack(side=tk.LEFT, padx=10)
        ttk.Radiobutton(mode_frame, text="Editar Existente", variable=self.mode,
                       value="edit", command=self._switch_mode).pack(side=tk.LEFT, padx=10)

        # Book selection (for edit mode)
        self.search_frame = ttk.Frame(content, style='White.TFrame')
        ttk.Label(self.search_frame, text="Buscar livro:", style='White.TLabel').pack(side=tk.LEFT, padx=(0, 10))
        self.search_entry = ttk.Entry(self.search_frame, width=40)
        self.search_entry.pack(side=tk.LEFT, padx=(0, 10))
        ttk.Button(self.search_frame, text="Buscar", command=self._buscar_livro).pack(side=tk.LEFT)

        # Book form
        form_frame = ttk.Frame(content, style='White.TFrame')
        form_frame.pack(fill='both', expand=True, pady=20)

        # Title
        ttk.Label(form_frame, text="Título*:", style='White.TLabel').grid(row=0, column=0, sticky='e', padx=5, pady=5)
        self.entry_titulo = ttk.Entry(form_frame, width=50)
        self.entry_titulo.grid(row=0, column=1, columnspan=2, sticky='w', padx=5, pady=5)

        # ISBN
        ttk.Label(form_frame, text="ISBN:", style='White.TLabel').grid(row=1, column=0, sticky='e', padx=5, pady=5)
        self.entry_isbn = ttk.Entry(form_frame, width=20)
        self.entry_isbn.grid(row=1, column=1, sticky='w', padx=5, pady=5)

        # Collection
        ttk.Label(form_frame, text="Coleção:", style='White.TLabel').grid(row=2, column=0, sticky='e', padx=5, pady=5)
        self.colecao_var = tk.StringVar()
        self.combo_colecao = ttk.Combobox(form_frame, textvariable=self.colecao_var, state='readonly', width=40)
        self.combo_colecao.grid(row=2, column=1, columnspan=2, sticky='w', padx=5, pady=5)

        # Authors
        authors_frame = ttk.LabelFrame(form_frame, text="Autores*", style='White.TFrame')
        authors_frame.grid(row=3, column=0, columnspan=3, sticky='ew', padx=5, pady=10)
        
        self.autor_vars: Dict[int, tk.BooleanVar] = {}
        self.autor_checks_frame = ttk.Frame(authors_frame, style='White.TFrame')
        self.autor_checks_frame.pack(fill='x', padx=10, pady=5)

        # Publishers
        publishers_frame = ttk.LabelFrame(form_frame, text="Editoras*", style='White.TFrame')
        publishers_frame.grid(row=4, column=0, columnspan=3, sticky='ew', padx=5, pady=10)
        
        self.editora_vars: Dict[int, tk.BooleanVar] = {}
        self.editora_checks_frame = ttk.Frame(publishers_frame, style='White.TFrame')
        self.editora_checks_frame.pack(fill='x', padx=10, pady=5)

        # Action buttons
        button_frame = ttk.Frame(form_frame, style='White.TFrame')
        button_frame.grid(row=5, column=0, columnspan=3, pady=20)
        
        self.btn_salvar = ttk.Button(button_frame, text="Salvar", command=self._salvar_livro)
        self.btn_salvar.pack(side=tk.LEFT, padx=5)
        
        self.btn_limpar = ttk.Button(button_frame, text="Limpar", command=self._limpar_form)
        self.btn_limpar.pack(side=tk.LEFT, padx=5)

        self.btn_remover = ttk.Button(button_frame, text="Remover", command=self._remover_livro)
        self.btn_remover.pack(side=tk.LEFT, padx=5)

        # Return button
        self.voltar = ttk.Button(
            barra_inferior, 
            text="Voltar",
            style='Barra.TButton',
            command=self._acao_voltar
        )
        self.voltar.pack(side=tk.RIGHT, padx=30, pady=15)

        # Initialize form
        self._carregar_colecoes()
        self._carregar_autores()
        self._carregar_editoras()
        self._switch_mode()

    def _switch_mode(self):
        """Switch between add and edit modes"""
        if self.mode.get() == "add":
            self.search_frame.pack_forget()
            self.btn_remover.pack_forget()
            self._limpar_form()
        else:
            self.search_frame.pack(fill='x', pady=(0, 20), before=self.search_frame.master.winfo_children()[2])
            self.btn_remover.pack(side=tk.LEFT, padx=5)
            self._limpar_form()

    def _carregar_colecoes(self):
        """Load collections into combobox"""
        try:
            colecoes = self.acervo_service.listar_colecoes()
            self.colecoes_dict = {c.nome: c.id_colecao for c in colecoes}
            self.combo_colecao['values'] = [''] + list(self.colecoes_dict.keys())
        except Exception as e:
            messagebox.showerror("Erro", f"Erro ao carregar coleções: {str(e)}")

    def _carregar_autores(self):
        """Load authors as checkboxes"""
        try:
            autores = self.acervo_service.listar_autores()
            
            # Clear previous checkboxes
            for widget in self.autor_checks_frame.winfo_children():
                widget.destroy()
            self.autor_vars.clear()

            # Create new checkboxes
            for i, autor in enumerate(sorted(autores, key=lambda x: x.nome)):
                var = tk.BooleanVar()
                self.autor_vars[autor.id_autor] = var
                ttk.Checkbutton(self.autor_checks_frame, text=autor.nome,
                               variable=var).grid(row=i//3, column=i%3, sticky='w', padx=5, pady=2)
                
        except Exception as e:
            messagebox.showerror("Erro", f"Erro ao carregar autores: {str(e)}")

    def _carregar_editoras(self):
        """Load publishers as checkboxes"""
        try:
            editoras = self.acervo_service.listar_editoras()
            
            # Clear previous checkboxes
            for widget in self.editora_checks_frame.winfo_children():
                widget.destroy()
            self.editora_vars.clear()

            # Create new checkboxes
            for i, editora in enumerate(sorted(editoras, key=lambda x: x.nome)):
                var = tk.BooleanVar()
                self.editora_vars[editora.id_editora] = var
                ttk.Checkbutton(self.editora_checks_frame, text=editora.nome,
                               variable=var).grid(row=i//3, column=i%3, sticky='w', padx=5, pady=2)
                
        except Exception as e:
            messagebox.showerror("Erro", f"Erro ao carregar editoras: {str(e)}")

    def _limpar_form(self):
        """Clear all form fields"""
        self.entry_titulo.delete(0, tk.END)
        self.entry_isbn.delete(0, tk.END)
        self.combo_colecao.set('')
        
        # Uncheck all checkboxes
        for var in self.autor_vars.values():
            var.set(False)
        for var in self.editora_vars.values():
            var.set(False)
            
        # Clear current book
        if hasattr(self, 'current_book_id'):
            del self.current_book_id

    def _buscar_livro(self):
        """Search for a book to edit"""
        termo = self.search_entry.get().strip()
        if not termo:
            messagebox.showinfo("Aviso", "Digite um termo para busca")
            return
        
        try:
            livros = self.acervo_service.buscar_livro_por_titulo(termo)
            if not livros:
                messagebox.showinfo("Busca", "Nenhum livro encontrado")
                return
                
            # Create selection window
            select_window = tk.Toplevel(self)
            select_window.title("Selecionar Livro")
            select_window.geometry("400x300")
            
            # Create listbox
            listbox = tk.Listbox(select_window, width=50)
            listbox.pack(padx=10, pady=10, fill='both', expand=True)
            
            # Add books to listbox
            self.search_results = {}  # Map index to book
            for i, livro in enumerate(livros):
                listbox.insert(tk.END, livro.titulo)
                self.search_results[i] = livro
                
            def on_select():
                try:
                    index = listbox.curselection()[0]
                    livro = self.search_results[index]
                    self._carregar_livro(livro)
                    select_window.destroy()
                except IndexError:
                    messagebox.showinfo("Seleção", "Selecione um livro da lista")
                    
            ttk.Button(select_window, text="Selecionar", 
                      command=on_select).pack(pady=10)
                
        except Exception as e:
            messagebox.showerror("Erro", f"Erro ao buscar livros: {str(e)}")

    def _carregar_livro(self, livro: Livro):
        """Load a book's data into the form"""
        try:
            self.current_book_id = livro.id_livro
            
            # Basic info
            self.entry_titulo.delete(0, tk.END)
            self.entry_titulo.insert(0, livro.titulo)
            
            self.entry_isbn.delete(0, tk.END)
            if livro.isbn:
                self.entry_isbn.insert(0, livro.isbn)
                
            # Collection
            self.combo_colecao.set('')
            if livro.id_colecao:
                for nome, id_col in self.colecoes_dict.items():
                    if id_col == livro.id_colecao:
                        self.combo_colecao.set(nome)
                        break
                        
            # Clear all checkboxes first
            for var in self.autor_vars.values():
                var.set(False)
            for var in self.editora_vars.values():
                var.set(False)
                
            # Authors
            autores = self.acervo_service.livro_model.get_autores_of_livro(livro.id_livro, self.acervo_service.conn)
            for autor in autores:
                if autor.id_autor in self.autor_vars:
                    self.autor_vars[autor.id_autor].set(True)
                    
            # Publishers
            editoras = self.acervo_service.livro_model.get_editoras_of_livro(livro.id_livro, self.acervo_service.conn)
            for editora in editoras:
                if editora.id_editora in self.editora_vars:
                    self.editora_vars[editora.id_editora].set(True)
                    
        except Exception as e:
            messagebox.showerror("Erro", f"Erro ao carregar dados do livro: {str(e)}")

    def _validar_form(self) -> bool:
        """Validate form data"""
        if not self.entry_titulo.get().strip():
            messagebox.showwarning("Validação", "O título do livro é obrigatório")
            return False
            
        autores_selecionados = [id_autor for id_autor, var in self.autor_vars.items() if var.get()]
        if not autores_selecionados:
            messagebox.showwarning("Validação", "Selecione pelo menos um autor")
            return False
            
        editoras_selecionadas = [id_editora for id_editora, var in self.editora_vars.items() if var.get()]
        if not editoras_selecionadas:
            messagebox.showwarning("Validação", "Selecione pelo menos uma editora")
            return False
            
        return True

    def _salvar_livro(self):
        """Save or update book data"""
        if not self._validar_form():
            return
            
        # Collect form data
        titulo = self.entry_titulo.get().strip()
        isbn = self.entry_isbn.get().strip() or None
        
        colecao_nome = self.combo_colecao.get()
        id_colecao = self.colecoes_dict.get(colecao_nome) if colecao_nome else None
        
        autores_selecionados = [id_autor for id_autor, var in self.autor_vars.items() if var.get()]
        editoras_selecionadas = [id_editora for id_editora, var in self.editora_vars.items() if var.get()]
        
        try:
            if self.mode.get() == "add":
                id_livro = self.acervo_service.criar_livro(
                    titulo=titulo,
                    isbn=isbn,
                    id_colecao=id_colecao,
                    lista_ids_autores=autores_selecionados,
                    lista_ids_editoras=editoras_selecionadas
                )
                messagebox.showinfo("Sucesso", "Livro criado com sucesso!")
                self._limpar_form()
            else:
                if not hasattr(self, 'current_book_id'):
                    messagebox.showwarning("Aviso", "Selecione um livro para editar")
                    return
                    
                self.acervo_service.editar_livro(
                    id_livro=self.current_book_id,
                    titulo=titulo,
                    isbn=isbn,
                    id_colecao=id_colecao,
                    lista_ids_autores=autores_selecionados,
                    lista_ids_editoras=editoras_selecionadas
                )
                messagebox.showinfo("Sucesso", "Livro atualizado com sucesso!")
                self._limpar_form()
                
        except Exception as e:
            messagebox.showerror("Erro", str(e))

    def _remover_livro(self):
        """Remove the currently selected book"""
        if not hasattr(self, 'current_book_id'):
            messagebox.showwarning("Aviso", "Selecione um livro para remover")
            return
            
        if not messagebox.askyesno("Confirmar", "Tem certeza que deseja remover este livro?"):
            return
            
        try:
            self.acervo_service.remover_livro(self.current_book_id)
            messagebox.showinfo("Sucesso", "Livro removido com sucesso!")
            self._limpar_form()
        except Exception as e:
            messagebox.showerror("Erro", str(e))

    def _acao_voltar(self):
        """Return to the previous screen"""
        self.app_controller.mostrar_tela_acervo()