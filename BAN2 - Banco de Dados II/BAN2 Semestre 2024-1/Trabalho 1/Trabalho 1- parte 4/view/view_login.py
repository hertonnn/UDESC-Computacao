import tkinter as tk
from tkinter import ttk, messagebox
from PIL import Image, ImageTk

import exceptions

from service.usuario_service import UsuarioService

class Viewlogin(ttk.Frame):

    def __init__(self, container, app_controller, db_conn):
        
        super().__init__(container, style='White.TFrame')

        cor_barra = '#435998'
        barra_superior = tk.Frame(self, bg=cor_barra, height=60)
        barra_superior.pack(side=tk.TOP, fill='x')

        barra_inferior = tk.Frame(self, bg=cor_barra, height=60)
        barra_inferior.pack(side=tk.BOTTOM, fill='x')

        frame_central = ttk.Frame(self, style='White.TFrame')
        frame_central.pack(fill='both', expand=True)
        
        self.app_controller = app_controller
        self.service = UsuarioService(db_conn)
            
        self.label_login = ttk.Label(barra_superior, text = "Login do Bibliotecário", style='Titulo.TLabel')
        self.label_login.pack(pady=(20, 20))

        self.label_cpf = ttk.Label(frame_central, text = "Digite seu CPF: ", style='Bold.TLabel')
        self.label_cpf.pack(pady=(20, 5))
        
        self.entry_cpf = ttk.Entry(frame_central, width=40)
        self.entry_cpf.pack(pady=5, padx=20)

        self.login_button = ttk.Button(
            frame_central, 
            text = "Entrar",
            style= 'Botao.TButton',
            command=self._acao_fazer_login
        )
        self.login_button.pack(pady=20)

        try:
            novo_tamanho = (400, 400)
            pil_image = Image.open("livros.png")
            pil_image_redimensionada = pil_image.resize(novo_tamanho, Image.Resampling.LANCZOS)

            self.livros_image = ImageTk.PhotoImage(pil_image_redimensionada)

            self.livros_label = ttk.Label(frame_central, image=self.livros_image, style='White.TLabel')
            self.livros_label.pack(pady=(5,10))
        except FileNotFoundError:
             print("Aviso: Imagem não encontrada.")
        except Exception as e:
            print(f"Erro ao carregar a imagem: {e}")

    def _acao_fazer_login(self):

        cpf = self.entry_cpf.get()

        try:
            id_bibliotecario_logado = self.service.autenticar_staff(cpf)

            if id_bibliotecario_logado:
                self.app_controller.mostrar_tela_principal(id_bibliotecario_logado)
            else:
                messagebox.showwarning("Erro de login", "CPF não reconhecido.")
        except exceptions.AutorizacaoException as e:
            messagebox.showwarning("Erro de login", f"{e}")
