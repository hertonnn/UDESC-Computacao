import tkinter as tk
from tkinter import ttk, messagebox

from service.colecao_service import ColecaoService


class ViewColecoes(ttk.Frame):
    def __init__(self, container, app_controller, db_conn):
        super().__init__(container, style='White.TFrame')

        self.app_controller = app_controller
        self.colecao_service = ColecaoService(db_conn)

        # Barra superior
        cor_barra = '#435998'
        barra_superior = tk.Frame(self, bg=cor_barra, height=60)
        barra_superior.pack(side=tk.TOP, fill='x')

        # Barra inferior
        barra_inferior = tk.Frame(self, bg=cor_barra, height=60)
        barra_inferior.pack(side=tk.BOTTOM, fill='x')

        # Título
        self.label_principal = ttk.Label(barra_superior, text="Coleções", style='Titulo.TLabel')
        self.label_principal.pack(pady=(20, 20))

        # Botão Voltar
        self.voltar = ttk.Button(
            barra_inferior,
            text="Voltar",
            style='Barra.TButton',
            command=self._acao_voltar
        )
        self.voltar.pack(side=tk.RIGHT, padx=30, pady=15)

        # Área de conteúdo
        content = ttk.Frame(self, style='White.TFrame')
        content.pack(fill='both', expand=True, padx=30, pady=20)

        # Frame para adicionar nova coleção
        frame_adicionar = ttk.LabelFrame(content, text="Adicionar Nova Coleção", style='White.TLabelframe')
        frame_adicionar.pack(fill='x', padx=5, pady=5)

        # Entrada para o nome da coleção
        self.nome_colecao = ttk.Entry(frame_adicionar, width=40)
        self.nome_colecao.pack(side=tk.LEFT, padx=5, pady=5)

        # Botão adicionar
        btn_adicionar = ttk.Button(
            frame_adicionar,
            text="Adicionar",
            style='Botao.TButton',
            command=self._adicionar_colecao
        )
        btn_adicionar.pack(side=tk.LEFT, padx=5, pady=5)

        # Frame para listar coleções
        frame_lista = ttk.LabelFrame(content, text="Coleções Cadastradas", style='White.TLabelframe')
        frame_lista.pack(fill='both', expand=True, padx=5, pady=5)

        # Treeview para listar coleções
        self.tree = ttk.Treeview(
            frame_lista,
            columns=('ID', 'Nome'),
            show='headings',
            selectmode='browse'
        )
        
        # Configurar colunas
        self.tree.heading('ID', text='ID')
        self.tree.heading('Nome', text='Nome')
        self.tree.column('ID', width=100)
        self.tree.column('Nome', width=300)

        # Scrollbar
        scrollbar = ttk.Scrollbar(frame_lista, orient=tk.VERTICAL, command=self.tree.yview)
        self.tree.configure(yscrollcommand=scrollbar.set)

        # Posicionar treeview e scrollbar
        self.tree.pack(side=tk.LEFT, fill='both', expand=True, padx=5, pady=5)
        scrollbar.pack(side=tk.RIGHT, fill='y')

        # Botão para remover coleção selecionada
        btn_remover = ttk.Button(
            frame_lista,
            text="Remover Selecionada",
            style='Botao.TButton',
            command=self._remover_colecao
        )
        btn_remover.pack(side=tk.BOTTOM, pady=5)

        # Carregar coleções existentes
        self._carregar_colecoes()

    def _acao_voltar(self):
        self.app_controller.mostrar_tela_acervo()

    def _carregar_colecoes(self):
        # Limpar treeview
        for item in self.tree.get_children():
            self.tree.delete(item)

        # Carregar coleções do banco
        colecoes = self.colecao_service.listar_colecoes()
        
        # Inserir na treeview
        for colecao in sorted(colecoes, key=lambda x: x.id_colecao):
            self.tree.insert('', 'end', values=(colecao.id_colecao, colecao.nome))

    def _adicionar_colecao(self):
        nome = self.nome_colecao.get().strip()
        
        if not nome:
            messagebox.showerror("Erro", "O nome da coleção não pode estar vazio.")
            return

        try:
            self.colecao_service.adicionar_colecao(nome)
            self.nome_colecao.delete(0, tk.END)  # Limpar campo
            self._carregar_colecoes()  # Recarregar lista
            messagebox.showinfo("Sucesso", "Coleção adicionada com sucesso!")
        except Exception as e:
            messagebox.showerror("Erro", f"Erro ao adicionar coleção: {str(e)}")

    def _remover_colecao(self):
        selection = self.tree.selection()
        if not selection:
            messagebox.showerror("Erro", "Selecione uma coleção para remover.")
            return

        if messagebox.askyesno("Confirmar", "Tem certeza que deseja remover esta coleção?"):
            try:
                item = self.tree.item(selection[0])
                id_colecao = item['values'][0]
                self.colecao_service.remover_colecao(id_colecao)
                self._carregar_colecoes()  # Recarregar lista
                messagebox.showinfo("Sucesso", "Coleção removida com sucesso!")
            except Exception as e:
                messagebox.showerror("Erro", f"Erro ao remover coleção: {str(e)}")