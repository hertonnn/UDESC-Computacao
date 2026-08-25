import socket
import time
from datetime import datetime
import struct

GRUPO_MULTICAST = '224.0.0.2'
PORTA = 8888
delta = 2  # tempo em segundos

sock = socket.socket(socket.AF_INET, socket.SOCK_DGRAM) # socket UDP

ttl = 1
ttl_binario = struct.pack('b', ttl)
sock.setsockopt(socket.IPPROTO_IP, socket.IP_MULTICAST_TTL, ttl_binario)

nome_host = socket.gethostname()
meu_ip = socket.gethostbyname(nome_host)

print(f"Iniciando o Monitor Sender no IP {meu_ip}...")
print(f"Enviando para o grupo {GRUPO_MULTICAST}:{PORTA}\n")

while True:
    try:
        agora = datetime.now().strftime("%Y-%m-%d %H:%M:%S")
        mensagem_texto = f"{agora}, {meu_ip}\n"
        mensagem_bytes = mensagem_texto.encode('utf-8') # texto em bytes
        
        sock.sendto(mensagem_bytes, (GRUPO_MULTICAST, PORTA))
        print(f"Enviado: {mensagem_texto.strip()}")
        
        time.sleep(delta)

    except Exception as e:
        print(f"Ocorreu um erro no envio: {e}")
        time.sleep(delta)