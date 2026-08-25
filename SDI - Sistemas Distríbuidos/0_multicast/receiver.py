import socket
import struct

GRUPO_MULTICAST = '224.0.0.2'
PORTA = 8888

sock = socket.socket(socket.AF_INET, socket.SOCK_DGRAM, socket.IPPROTO_UDP)
sock.setsockopt(socket.SOL_SOCKET, socket.SO_REUSEADDR, 1)
sock.bind(('', PORTA))

grupo_binario = socket.inet_aton(GRUPO_MULTICAST)
mreq = struct.pack('4sL', grupo_binario, socket.INADDR_ANY)

sock.setsockopt(socket.IPPROTO_IP, socket.IP_ADD_MEMBERSHIP, mreq)

print(f"Ouvindo mensagens no grupo {GRUPO_MULTICAST}:{PORTA}...")
print("Pressione Ctrl+C para parar.\n")

while True:
    try:
        dados, endereco = sock.recvfrom(1024)
        mensagem = dados.decode('utf-8')
        ip_remetente = endereco[0]

        print(f"Recebido de {ip_remetente}: {mensagem.strip()}")

    except Exception as e:
        print(f"Erro ao receber dados: {e}")
        break