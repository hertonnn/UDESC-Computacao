import tkinter as tk
from tkinter import ttk, messagebox
import exceptions

from service.usuario_service import UsuarioService
from service.emprestimo_service import EmprestimoService
from service.reserva_service import ReservaService 

class Viewrelatorios(ttk.Frame):

    def __init__(self, container, app_controller, db_conn):

        super().__init__(container, style='White.TFrame')

        self.app_controller = app_controller
        self.db_conn = db_conn

        self.usuario_service = UsuarioService(self.db_conn)
        self.emprestimo_service = EmprestimoService(self.db_conn)
        self.reserva_service = ReservaService(self.db_conn)

        cor_barra = '#435998'
        barra_superior = tk.Frame(self, bg=cor_barra, height=60)
        barra_superior.pack(side=tk.TOP, fill='x')

        barra_inferior = tk.Frame(self, bg=cor_barra, height=60)
        barra_inferior.pack(side=tk.BOTTOM, fill='x')

        self.label_principal = ttk.Label(barra_superior, text="Relatórios", style='Titulo.TLabel')
        self.label_principal.pack(pady=(20, 20))

        notebook = ttk.Notebook(self)
        notebook.pack(fill='both', expand=True, padx=20, pady=20)

        self.frame_atrasados = ttk.Frame(notebook, style='White.TFrame')
        self.frame_multas = ttk.Frame(notebook, style='White.TFrame')
        self.frame_reservas = ttk.Frame(notebook, style='White.TFrame')
        self.frame_emprestados_ativos = ttk.Frame(notebook, style='White.TFrame')

        notebook.add(self.frame_atrasados, text='Empréstimos Atrasados')
        notebook.add(self.frame_multas, text='Multas Pendentes')
        notebook.add(self.frame_reservas, text='Fila de Reservas Ativas')
        notebook.add(self.frame_emprestados_ativos, text='Exemplares Emprestados')

        self._criar_aba_atrasados(self.frame_atrasados)
        self._criar_aba_multas(self.frame_multas)
        self._criar_aba_reservas(self.frame_reservas)
        self._criar_aba_emprestados_ativos(self.frame_emprestados_ativos)

        self.voltar = ttk.Button(
            barra_inferior, 
            text="Voltar",
            style='Barra.TButton',
            command=self._acao_voltar
        )
        self.voltar.pack(side=tk.RIGHT, padx=30, pady=15)

        notebook.bind("<<NotebookTabChanged>>", self._on_tab_changed)

        self._carregar_dados_atrasados()

    def _acao_voltar(self):
        self.app_controller.mostrar_tela_principal(self.app_controller.id_bibliotecario_logado)

    def _on_tab_changed(self, event):
        tab_selecionada = event.widget.select()
        nome_tab = event.widget.tab(tab_selecionada, "text")

        if nome_tab == "Empréstimos Atrasados":
            self._carregar_dados_atrasados()
        elif nome_tab == "Multas Pendentes":
            self._carregar_dados_multas()
        elif nome_tab == "Fila de Reservas Ativas":
            self._carregar_dados_reservas()
        elif nome_tab == "Exemplares Emprestados":
            self._carregar_dados_emprestados_ativos()
    
    def _criar_aba_atrasados(self, container):
        frame_tabela = ttk.Frame(container)
        frame_tabela.pack(fill='both', expand=True, padx=10, pady=10)

        colunas = ('id_emprestimo', 'usuario', 'data_prevista', 'dias_atraso')
        self.tree_atrasados = ttk.Treeview(frame_tabela, columns=colunas, show='headings', height=15)
        
        self.tree_atrasados.heading('id_emprestimo', text='ID Empr.')
        self.tree_atrasados.column('id_emprestimo', width=60, stretch=False)
        self.tree_atrasados.heading('usuario', text='Nome do Usuário')
        self.tree_atrasados.column('usuario', width=250)
        self.tree_atrasados.heading('data_prevista', text='Dev. Prevista')
        self.tree_atrasados.column('data_prevista', width=100)
        self.tree_atrasados.heading('dias_atraso', text='Dias em Atraso')
        self.tree_atrasados.column('dias_atraso', width=100)
        
        scrollbar = ttk.Scrollbar(frame_tabela, orient=tk.VERTICAL, command=self.tree_atrasados.yview)
        self.tree_atrasados.configure(yscroll=scrollbar.set)
        
        scrollbar.pack(side=tk.RIGHT, fill=tk.Y)
        self.tree_atrasados.pack(side=tk.LEFT, fill=tk.BOTH, expand=True)

    def _carregar_dados_atrasados(self):
        for i in self.tree_atrasados.get_children():
            self.tree_atrasados.delete(i)
        
        try:
            emprestimos = self.emprestimo_service.listar_emprestimos_atrasados_com_nomes() 
            
            if not emprestimos:
                return 

            for emprestimo_tupla in emprestimos:
                self.tree_atrasados.insert('', 'end', values=emprestimo_tupla)

        except exceptions.RecursoNaoEncontradoException:
            pass
        except exceptions.NegocioException as e:
            messagebox.showwarning("Aviso", f"Não foi possível carregar o relatório: {e}", parent=self)
        except Exception as e:
            messagebox.showerror("Erro Inesperado", f"Ocorreu um erro: {e}", parent=self)

    def _criar_aba_emprestados_ativos(self, container):
        frame_tabela = ttk.Frame(container)
        frame_tabela.pack(fill='both', expand=True, padx=10, pady=10)

        colunas = ('id_exemplar', 'titulo_livro', 'nome_usuario')
        self.tree_emprestados_ativos = ttk.Treeview(frame_tabela, columns=colunas, show='headings', height=15)
        
        self.tree_emprestados_ativos.heading('id_exemplar', text='ID Exemplar')
        self.tree_emprestados_ativos.column('id_exemplar', width=80, stretch=False)
        self.tree_emprestados_ativos.heading('titulo_livro', text='Título do Livro')
        self.tree_emprestados_ativos.column('titulo_livro', width=250)
        self.tree_emprestados_ativos.heading('nome_usuario', text='Nome do Usuário')
        self.tree_emprestados_ativos.column('nome_usuario', width=250)
        
        scrollbar = ttk.Scrollbar(frame_tabela, orient=tk.VERTICAL, command=self.tree_emprestados_ativos.yview)
        self.tree_emprestados_ativos.configure(yscroll=scrollbar.set)
        
        scrollbar.pack(side=tk.RIGHT, fill=tk.Y)
        self.tree_emprestados_ativos.pack(side=tk.LEFT, fill=tk.BOTH, expand=True)

    def _carregar_dados_emprestados_ativos(self):
        for i in self.tree_emprestados_ativos.get_children():
            self.tree_emprestados_ativos.delete(i)
        
        try:
            exemplares = self.emprestimo_service.listar_exemplares_emprestados_ativos() 
            
            if not exemplares:
                return 

            for exemplar_tupla in exemplares:
                self.tree_emprestados_ativos.insert('', 'end', values=exemplar_tupla)

        except exceptions.RecursoNaoEncontradoException:
            pass
        except exceptions.NegocioException as e:
            messagebox.showwarning("Aviso", f"Não foi possível carregar o relatório: {e}", parent=self)
        except Exception as e:
            messagebox.showerror("Erro Inesperado", f"Ocorreu um erro: {e}", parent=self)

    def _criar_aba_multas(self, container):
        frame_tabela = ttk.Frame(container)
        frame_tabela.pack(fill='both', expand=True, padx=10, pady=10)

        colunas = ('id_usuario', 'nome', 'telefone', 'categoria')
        self.tree_multas = ttk.Treeview(frame_tabela, columns=colunas, show='headings', height=15)
        
        self.tree_multas.heading('id_usuario', text='ID Usuário')
        self.tree_multas.column('id_usuario', width=70, stretch=False)
        self.tree_multas.heading('nome', text='Nome')
        self.tree_multas.column('nome', width=250)
        self.tree_multas.heading('telefone', text='Telefone')
        self.tree_multas.column('telefone', width=100)
        self.tree_multas.heading('categoria', text='Categoria')
        self.tree_multas.column('categoria', width=100)
        
        scrollbar = ttk.Scrollbar(frame_tabela, orient=tk.VERTICAL, command=self.tree_multas.yview)
        self.tree_multas.configure(yscroll=scrollbar.set)
        
        scrollbar.pack(side=tk.RIGHT, fill=tk.Y)
        self.tree_multas.pack(side=tk.LEFT, fill=tk.BOTH, expand=True)

    def _carregar_dados_multas(self):
        for i in self.tree_multas.get_children():
            self.tree_multas.delete(i)
        
        try:

            usuarios = self.usuario_service.listar_usuarios_com_multas() 
            
            if not usuarios:
                return

            for usuario in usuarios:
                self.tree_multas.insert('', 'end', values=(
                    usuario.id_usuario,
                    usuario.nome,
                    usuario.telefone,
                    usuario.categoria
                ))

        except exceptions.RecursoNaoEncontradoException:
            pass
        except exceptions.NegocioException as e:
            messagebox.showwarning("Aviso", f"Não foi possível carregar o relatório: {e}", parent=self)
        except Exception as e:
            messagebox.showerror("Erro Inesperado", f"Ocorreu um erro: {e}", parent=self)

    def _criar_aba_reservas(self, container):
        frame_tabela = ttk.Frame(container)
        frame_tabela.pack(fill='both', expand=True, padx=10, pady=10)

        colunas = ('id_reserva', 'data_reserva', 'usuario', 'titulo_livro')
        self.tree_reservas = ttk.Treeview(frame_tabela, columns=colunas, show='headings', height=15)
        
        self.tree_reservas.heading('id_reserva', text='ID Res.')
        self.tree_reservas.column('id_reserva', width=60, stretch=False)
        self.tree_reservas.heading('data_reserva', text='Data da Reserva')
        self.tree_reservas.column('data_reserva', width=100)
        self.tree_reservas.heading('usuario', text='Nome do Usuário')
        self.tree_reservas.column('usuario', width=200)
        self.tree_reservas.heading('titulo_livro', text='Título')
        self.tree_reservas.column('titulo_livro', width=250)
        
        scrollbar = ttk.Scrollbar(frame_tabela, orient=tk.VERTICAL, command=self.tree_reservas.yview)
        self.tree_reservas.configure(yscroll=scrollbar.set)
        
        scrollbar.pack(side=tk.RIGHT, fill=tk.Y)
        self.tree_reservas.pack(side=tk.LEFT, fill=tk.BOTH, expand=True)

    def _carregar_dados_reservas(self):
        for i in self.tree_reservas.get_children():
            self.tree_reservas.delete(i)
        
        try:

            reservas = self.reserva_service.listar_reservas_ativas_com_nomes()
            
            if not reservas:
                return

            for reserva_tupla in reservas:
                self.tree_reservas.insert('', 'end', values=reserva_tupla)

        except exceptions.RecursoNaoEncontradoException:
            pass
        except exceptions.NegocioException as e:
            messagebox.showwarning("Aviso", f"Não foi possível carregar o relatório: {e}", parent=self)
        except Exception as e:
            messagebox.showerror("Erro Inesperado", f"Ocorreu um erro: {e}", parent=self)