# .\venv\Scripts\activate
# python main.py
# deactivate
import tkinter as tk
from tkinter import ttk, messagebox

from connection import get_database_connection

from view.view_login import Viewlogin
from view.view_principal import Viewprincipal
from view.view_emprestimo import Viewemprestimo
from view.view_devolucao import Viewdevolucao
from view.view_acervo import Viewacervo
from view.view_gerenciar import Viewgerenciar
from view.view_relatorios import Viewrelatorios
from view.view_renovar import Viewrenovar
from view.view_reserva import Viewreserva
from view.view_autores import ViewAutores
from view.view_editoras import ViewEditoras
from view.view_colecoes import ViewColecoes
from view.view_listar_livros import ViewListarLivros
from view.view_editar_livros import ViewEditarLivros

class App(tk.Tk):

    def __init__(self):
        super().__init__()

        self.title("Sistema de Biblioteca")

        self.style = ttk.Style(self)
        self.style.configure('White.TFrame', background='white')
        self.style.configure('White.TLabel', background='white', font=('Times', 11))
        self.style.configure('Bold.TLabel', background='white', foreground='#435998', font=('Times', 11, 'bold'))
        self.style.configure('Bold2.TLabel', background='white', foreground='#435998', font=('Times', 13, 'bold'))

        self.style.configure('Botao.TButton', 
                             font=('Times', 13, 'bold'),
                             padding=(10, 10),
                             width=20,
                             foreground='#435998',
                             background='white')
        
        self.style.map('Botao.TButton',
            foreground=[('active', '#FDFDFD'), ('hover', '#435998')],
            background=[('active', '#435998'), ('hover', '#435998')]
        )

        self.style.configure('Titulo.TLabel', 
                             background='#435998',       
                             foreground='#FDFDFD',        
                             font=('Times', 30, 'bold'))
        
        self.style.configure('Barra.TButton', 
                             font=('Times', 12, 'bold'),
                             background='white',  
                             foreground='#435998'     
                            )
        
        self.style.map('Barra.TButton',
            foreground=[('active', '#FDFDFD'), ('hover', '#435998')],
            background=[('active', '#435998'), ('hover', '#435998')]
        )
        
        window_width = 600
        window_height = 700

        screen_width = self.winfo_screenwidth() 
        screen_height = self.winfo_screenheight()

        center_x = (screen_width // 2) - (window_width // 2)
        center_y = (screen_height // 2) - (window_height // 2)

        self.geometry(f'{window_width}x{window_height}+{center_x}+{center_y - 50}')

        try:
            self.db_conn = get_database_connection()
            print("Conexão com o banco de dados estabelecida com sucesso.")
        except Exception as e:
            messagebox.showerror("Erro de Conexão", f"Não foi possível conectar ao banco de dados: {e}")
            self.destroy()
            return

        self.id_bibliotecario_logado = None

        self.container = ttk.Frame(self, style='White.TFrame')
        self.container.pack(fill='both', expand=True)

        self._frame_atual = None

        self.mostrar_tela_login()
    
    def _trocar_tela(self, nova_tela_frame):
        if self._frame_atual:
            self._frame_atual.destroy()
        
        self._frame_atual = nova_tela_frame
        self._frame_atual.pack(fill="both", expand=True)

    def mostrar_tela_login(self):
        self.id_bibliotecario_logado = None 
        self.title("Login - Sistema de biblioteca")

        tela_login_frame = Viewlogin(self.container, self, self.db_conn)
        self._trocar_tela(tela_login_frame)

    def mostrar_tela_principal(self, id_bibliotecario):
        self.id_bibliotecario_logado = id_bibliotecario
        self.title("Menu Principal - Sistema de Biblioteca")
         
        tela_principal = Viewprincipal(self.container, self, self.db_conn)
        self._trocar_tela(tela_principal)

    def mostrar_tela_emprestimo(self):
        self.title("Realizar Empréstimo - Sistema de Biblioteca")
        
        tela_emprestimo = Viewemprestimo(self.container, self, self.db_conn)
        self._trocar_tela(tela_emprestimo)

    def mostrar_tela_devolucao(self):
        self.title("Realizar Devolção - Sistema de Biblioteca")
        
        tela_devolucao = Viewdevolucao(self.container, self, self.db_conn)
        self._trocar_tela(tela_devolucao)
        
    def mostrar_tela_acervo(self):
        self.title("Acervo - Sistema de Biblioteca")
        
        tela_acervo = Viewacervo(self.container, self, self.db_conn)
        self._trocar_tela(tela_acervo)

    def mostrar_tela_gerenciar(self):
        self.title("Gerenciar - Sistema de Biblioteca")
        
        tela_gerenciar = Viewgerenciar(self.container, self, self.db_conn)
        self._trocar_tela(tela_gerenciar)     

    def mostrar_tela_relatorios(self):
        self.title("Relatórios - Sistema de Biblioteca")
        
        tela_relatorios = Viewrelatorios(self.container, self, self.db_conn)
        self._trocar_tela(tela_relatorios)       

    def mostrar_tela_renovar(self):
        self.title("Renovar - Sistema de Biblioteca")
        
        tela_renovar = Viewrenovar(self.container, self, self.db_conn)
        self._trocar_tela(tela_renovar)

    def mostrar_tela_reserva(self):
        self.title("Reservar - Sistema de Biblioteca")
        
        tela_reservar = Viewreserva(self.container, self, self.db_conn)
        self._trocar_tela(tela_reservar)  

    def mostrar_tela_autores(self):
        self.title("Autores - Sistema de Biblioteca")
        
        tela_autores = ViewAutores(self.container, self, self.db_conn)
        self._trocar_tela(tela_autores)

    def mostrar_tela_editoras(self):
        self.title("Editoras - Sistema de Biblioteca")
        
        tela_editoras = ViewEditoras(self.container, self, self.db_conn)
        self._trocar_tela(tela_editoras)

    def mostrar_tela_colecoes(self):
        self.title("Coleções - Sistema de Biblioteca")
        
        tela_colecoes = ViewColecoes(self.container, self, self.db_conn)
        self._trocar_tela(tela_colecoes)

    def mostrar_tela_listar_livros(self):
        self.title("Listar/Buscar Livros - Sistema de Biblioteca")
        
        tela_listar_livros = ViewListarLivros(self.container, self, self.db_conn)
        self._trocar_tela(tela_listar_livros)

    def mostrar_tela_editar_livros(self):
        self.title("Adicionar/Editar Livros - Sistema de Biblioteca")
        
        tela_editar_livros = ViewEditarLivros(self.container, self, self.db_conn)
        self._trocar_tela(tela_editar_livros)
        
    def mostrar_tela_exemplares(self):
        self.title("Gerenciar Exemplares - Sistema de Biblioteca")
        
        from view.view_exemplares import ViewExemplares
        tela_exemplares = ViewExemplares(self.container, self, self.db_conn)
        self._trocar_tela(tela_exemplares)
 
if __name__ == "__main__":
    app = App()
    app.mainloop()

    




    

