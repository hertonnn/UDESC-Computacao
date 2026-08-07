import tkinter as tk
from tkinter import ttk, messagebox

from service.editora_service import EditoraService
import exceptions

class ViewEditoras(ttk.Frame):
    def __init__(self, container, app_controller, db_conn):
        super().__init__(container, style='White.TFrame')

        self.app_controller = app_controller
        self.editora_service = EditoraService(db_conn)

        # Barra superior
        cor_barra = '#435998'
        barra_superior = tk.Frame(self, bg=cor_barra, height=60)
        barra_superior.pack(side=tk.TOP, fill='x')

        # Barra inferior
        barra_inferior = tk.Frame(self, bg=cor_barra, height=60)
        barra_inferior.pack(side=tk.BOTTOM, fill='x')

        # Título
        self.label_principal = ttk.Label(barra_superior, text="Editoras", style='Titulo.TLabel')
        self.label_principal.pack(pady=(20, 20))

        # Botão voltar
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

        # Frame para adicionar editora
        add_frame = ttk.Frame(content, style='White.TFrame')
        add_frame.pack(fill='x', pady=(0, 20))

        # Label e entrada para nova editora
        ttk.Label(add_frame, text="Nome da Editora:", style='Text.TLabel').pack(side=tk.LEFT, padx=(0, 10))
        self.nova_editora_entry = ttk.Entry(add_frame, width=40)
        self.nova_editora_entry.pack(side=tk.LEFT, padx=(0, 10))

        # Botão adicionar
        ttk.Button(add_frame, text="Adicionar", 
                  command=self._adicionar_editora,
                  style='Botao.TButton').pack(side=tk.LEFT)

        # Frame para lista de editoras
        list_frame = ttk.Frame(content, style='White.TFrame')
        list_frame.pack(fill='both', expand=True)

        # Criar Treeview para listar editoras
        self.tree = ttk.Treeview(list_frame, columns=('ID', 'Nome'), show='headings')
        self.tree.heading('ID', text='ID')
        self.tree.heading('Nome', text='Nome')
        self.tree.column('ID', width=100)
        self.tree.column('Nome', width=400)
        
        # Adicionar scrollbar
        scrollbar = ttk.Scrollbar(list_frame, orient=tk.VERTICAL, command=self.tree.yview)
        self.tree.configure(yscrollcommand=scrollbar.set)
        
        # Posicionar Treeview e scrollbar
        self.tree.pack(side=tk.LEFT, fill='both', expand=True)
        scrollbar.pack(side=tk.RIGHT, fill='y')

        # Botão para remover editora selecionada
        ttk.Button(content, text="Remover Selecionada", 
                  command=self._remover_editora,
                  style='Botao.TButton').pack(pady=(10, 0))

        # Carregar lista de editoras
        self._carregar_editoras()

    def _carregar_editoras(self):
        # Limpar lista atual
        for item in self.tree.get_children():
            self.tree.delete(item)

        try:
            # Buscar e mostrar editoras
            editoras = self.editora_service.listar_editoras()
            for editora in sorted(editoras, key=lambda x: x.id_editora or 0):
                self.tree.insert('', tk.END, values=(editora.id_editora, editora.nome))
        except Exception as e:
            messagebox.showerror("Erro", str(e))

    def _adicionar_editora(self):
        nome = self.nova_editora_entry.get().strip()
        if not nome:
            messagebox.showwarning("Aviso", "Por favor, insira um nome para a editora.")
            return

        try:
            self.editora_service.adicionar_editora(nome)
            self.nova_editora_entry.delete(0, tk.END)
            self._carregar_editoras()
            messagebox.showinfo("Sucesso", "Editora adicionada com sucesso!")
        except Exception as e:
            messagebox.showerror("Erro", str(e))

    def _remover_editora(self):
        selected_item = self.tree.selection()
        if not selected_item:
            messagebox.showwarning("Aviso", "Por favor, selecione uma editora para remover.")
            return

        if messagebox.askyesno("Confirmar", "Tem certeza que deseja remover esta editora?"):
            try:
                id_editora = int(self.tree.item(selected_item[0])['values'][0])
                self.editora_service.remover_editora(id_editora)
                self._carregar_editoras()
                messagebox.showinfo("Sucesso", "Editora removida com sucesso!")
            except Exception as e:
                messagebox.showerror("Erro", str(e))

    def _acao_voltar(self):
        self.app_controller.mostrar_tela_acervo()