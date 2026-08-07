import tkinter as tk
from tkinter import ttk, messagebox
from service.autor_service import AutorService

class ViewAutores(ttk.Frame):
    def __init__(self, container, app_controller, db_conn):
        super().__init__(container)

        self.app_controller = app_controller
        self.autor_service = AutorService(db_conn)

        # Configure grid
        self.columnconfigure(0, weight=1)
        self.rowconfigure(1, weight=1)

        # Header
        cor_barra = '#435998'
        header = tk.Frame(self, bg=cor_barra, height=60)
        header.grid(row=0, column=0, sticky='ew')

        title = ttk.Label(header, text="Gerenciar Autores", style='Titulo.TLabel')
        title.pack(pady=20)

        # Content
        content = ttk.Frame(self, style='White.TFrame')
        content.grid(row=1, column=0, sticky='nsew', padx=20, pady=10)

        # Add author section
        add_frame = ttk.LabelFrame(content, text="Adicionar Autor", style='White.TLabelframe')
        add_frame.pack(fill='x', padx=5, pady=5)

        self.nome_var = tk.StringVar()
        nome_entry = ttk.Entry(add_frame, textvariable=self.nome_var, width=40)
        nome_entry.pack(side=tk.LEFT, padx=5, pady=5)

        add_button = ttk.Button(add_frame, text="Adicionar", command=self._adicionar_autor, style='Botao.TButton')
        add_button.pack(side=tk.LEFT, padx=5, pady=5)

        # Authors list section
        list_frame = ttk.LabelFrame(content, text="Lista de Autores", style='White.TLabelframe')
        list_frame.pack(fill='both', expand=True, padx=5, pady=5)

        # Create treeview
        self.tree = ttk.Treeview(list_frame, columns=('ID', 'Nome'), show='headings', style='Treeview')
        self.tree.heading('ID', text='ID')
        self.tree.heading('Nome', text='Nome')
        self.tree.column('ID', width=50)
        self.tree.column('Nome', width=300)
        self.tree.pack(side=tk.LEFT, fill='both', expand=True, padx=5, pady=5)

        # Add scrollbar
        scrollbar = ttk.Scrollbar(list_frame, orient=tk.VERTICAL, command=self.tree.yview)
        scrollbar.pack(side=tk.RIGHT, fill='y')
        self.tree.configure(yscrollcommand=scrollbar.set)

        # Delete button
        delete_button = ttk.Button(content, text="Remover Selecionado", command=self._remover_autor, style='Botao.TButton')
        delete_button.pack(pady=10)

        # Footer
        footer = tk.Frame(self, bg=cor_barra, height=60)
        footer.grid(row=2, column=0, sticky='ew')

        voltar_btn = ttk.Button(
            footer, 
            text="Voltar",
            style='Barra.TButton',
            command=self._acao_voltar
        )
        voltar_btn.pack(side=tk.RIGHT, padx=30, pady=15)

        # Load initial data
        self._carregar_autores()

    def _adicionar_autor(self):
        nome = self.nome_var.get().strip()
        if not nome:
            messagebox.showwarning("Aviso", "Por favor, insira um nome para o autor.")
            return

        try:
            id_autor = self.autor_service.criar_autor(nome)
            messagebox.showinfo("Sucesso", f"Autor '{nome}' adicionado com sucesso!")
            self.nome_var.set("")  # Clear the entry
            self._carregar_autores()  # Refresh the list
        except Exception as e:
            messagebox.showerror("Erro", f"Erro ao adicionar autor: {str(e)}")

    def _remover_autor(self):
        selection = self.tree.selection()
        if not selection:
            messagebox.showwarning("Aviso", "Por favor, selecione um autor para remover.")
            return

        if messagebox.askyesno("Confirmar", "Tem certeza que deseja remover este autor?"):
            try:
                for item in selection:
                    id_autor = self.tree.item(item)['values'][0]
                    self.autor_service.remover_autor(id_autor)
                messagebox.showinfo("Sucesso", "Autor(es) removido(s) com sucesso!")
                self._carregar_autores()  # Refresh the list
            except Exception as e:
                messagebox.showerror("Erro", f"Erro ao remover autor: {str(e)}")

    def _carregar_autores(self):
        # Clear existing items
        for item in self.tree.get_children():
            self.tree.delete(item)

        # Load authors
        try:
            autores = self.autor_service.listar_autores()
            for autor in autores:
                self.tree.insert('', 'end', values=(autor.id_autor, autor.nome))
        except Exception as e:
            messagebox.showerror("Erro", f"Erro ao carregar autores: {str(e)}")

    def _acao_voltar(self):
        self.app_controller.mostrar_tela_acervo()