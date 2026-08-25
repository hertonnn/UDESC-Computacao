#  Sistema de Gerenciamento de Acesso à Internet via SNMP

Repositório destinado ao projeto final da disciplina de **Gerência e Mobilidade em Redes**, ministrada pelo Prof. Adriano Fiorese na Universidade do Estado de Santa Catarina (UDESC).

## Sobre o Projeto
O objetivo deste projeto é implementar um sistema de controle de acesso à Internet utilizando técnicas de gerência de redes (Protocolo SNMP). O sistema permite que um professor gerencie, através de uma interface Web, o bloqueio ou a liberação da conexão de internet de máquinas específicas de uma sala de aula de forma imediata ou coletiva, desabilitando logicamente as portas do switch (alterando o `ifAdminStatus`).

## Arquitetura do Sistema
O sistema foi desenvolvido utilizando uma arquitetura baseada em microsserviços e integração de múltiplas linguagens para atender aos requisitos da disciplina:

1. **Frontend (Interface Web):** Desenvolvido em HTML5, CSS (Bootstrap) e JavaScript (AJAX). Responsável por exibir o status em tempo real e receber os comandos do usuário.
2. **Backend (Controlador):** Desenvolvido em Python (Flask). Atua como o cérebro da aplicação, efetuando a validação de segurança avançada na Camada 2 (Endereço MAC via tabela ARP), gerenciando a sessão multitenancy (1 professor por sala) e cruzando dados lógicos.
3. **Banco de Dados:** **PostgreSQL**. Mantém o mapeamento da infraestrutura física (Switch ↔ Sala ↔ Máquina ↔ Porta `ifIndex`).
4. **Motor SNMP (Agente de Rede):** Desenvolvido em **Java** usando a API **SNMP4J**. É compilado e executado em background pelo Python para disparar mensagens SNMP `SET`.
5. **Ambiente de Rede (Físico e Simulado):** O sistema é híbrido. Pode rodar utilizando o serviço `snmpd` local do Ubuntu (com interfaces `dummy`) para simulação, ou conectado a um **Switch Físico Real** (ex: D-Link) integrando-se nativamente à infraestrutura física via cabo.
6. **Agendador de Tarefas (Crontab):** Integração automatizada com o subsistema cron do Linux. O Python converte entradas absolutas de calendário (datetime-local) e injeta regras diretamente no crontab para agendar o bloqueio e o desbloqueio futuro de forma totalmente autônoma.

---

## Estrutura do Repositório

```text
ogmr_trabalho_final/
├── java_snmp/               # Diretório do Motor SNMP
│   ├── GerenteSNMP.java     # Código fonte Java responsável pelo envio do PDU
│   ├── GerenteSNMP.class    # Arquivo compilado 
│   └── snmp4j-2.8.18.jar    # Biblioteca oficial da API SNMP4J
├── static/                  # Arquivos de estilização e identidade visual (UDESC)
│   ├── logo_udesc.png
│   └── foto_prof.jpg
├── templates/               # Diretório de views do Flask
│   └── index.html           # Interface do painel do professor
├── app.py                   # Aplicação principal Backend (Flask)
├── enunciado_tf.pdf         # Especificação original do trabalho
└── README.md                # Documentação do projeto
```

---

## Configuração do Ambiente de Testes (Ubuntu Linux)

Para executar este projeto localmente, é necessário simular o switch, configurar o banco de dados e instalar as dependências de software. Siga os passos abaixo:

### 1. Dependências Básicas
```bash
sudo apt update && sudo apt upgrade -y
sudo apt install python3 python3-pip python3-venv default-jdk postgresql -y
```

### 2. Configurando o "Switch Simulado" (SNMP Daemon e Portas dummy)
Vamos criar interfaces de rede virtuais para simular as portas do switch:
```bash
sudo modprobe dummy
sudo ip link add porta_prof type dummy
sudo ip link add porta_sala_1 type dummy
sudo ip link add porta_sala_2 type dummy
```

Instale o agente e as ferramentas SNMP:
```bash
sudo apt install snmpd snmp snmp-mibs-downloader -y
```

Libere a leitura das MIBs editando o arquivo cliente `sudo nano /etc/snmp/snmp.conf` e comentando a linha `mibs :`:
```text
#mibs :
```

Configure o agente SNMP como "Switch" editando `sudo nano /etc/snmp/snmpd.conf` e garantindo as linhas:
```text
agentAddress udp:127.0.0.1:161
rocommunity public default
rwcommunity private default
```

Conceda privilégios de root ao SNMP para que ele possa desligar as interfaces de rede:
```bash
# Edite o serviço: sudo nano /lib/systemd/system/snmpd.service
# Altere a linha ExecStart removendo as tags de usuário restrito (-u Debian-snmp -g Debian-snmp).
# Deve ficar parecido com: ExecStart=/usr/sbin/snmpd -LOw -I -smux,mteTrigger,mteTriggerConf -f
sudo systemctl daemon-reload
sudo systemctl restart snmpd
```

### 3. Configurando o Banco de Dados (PostgreSQL)
Acesse o prompt do banco:
```bash
sudo -u postgres psql
```
Altere a senha do usuário padrão para a aplicação se conectar:
```sql
ALTER USER postgres PASSWORD 'postgres';
CREATE DATABASE projeto_ogmr;
\c projeto_ogmr
```
Crie as tabelas e insira os dados do ambiente de teste simulado:
```sql
CREATE TABLE switches (id SERIAL PRIMARY KEY, nome VARCHAR(50), ip_address VARCHAR(50), snmp_community VARCHAR(50) DEFAULT 'private');
CREATE TABLE salas (id SERIAL PRIMARY KEY, nome VARCHAR(50));

-- Nova estrutura baseada no Endereço MAC
CREATE TABLE maquinas (
    mac_address VARCHAR(50) PRIMARY KEY,
    nome_host VARCHAR(50) NOT NULL,
    ip_address VARCHAR(50) UNIQUE NOT NULL,
    sala_id INT REFERENCES salas(id),
    switch_id INT REFERENCES switches(id),
    porta_ifindex INT NOT NULL,
    tipo VARCHAR(20) DEFAULT 'aluno'
);

-- Regra de Negócio: Apenas 1 professor permitido por sala
CREATE UNIQUE INDEX unq_professor_por_sala ON maquinas (sala_id) WHERE tipo = 'professor';

-- Populando o banco com o cenário do simulador local
INSERT INTO switches (nome, ip_address, snmp_community) VALUES ('Switch_Core', '127.0.0.1', 'private');
INSERT INTO salas (nome) VALUES ('Sala F203');

-- ATENÇÃO: Substitua 'E4:FD...' pelo MAC Address real da sua máquina (descubra com o comando 'ip a')
INSERT INTO maquinas (mac_address, nome_host, ip_address, sala_id, switch_id, porta_ifindex, tipo) 
VALUES ('E4:FD:45:AB:01:D5', 'MEU-PC', '127.0.0.1', 1, 1, 11, 'professor');

INSERT INTO maquinas (mac_address, nome_host, ip_address, sala_id, switch_id, porta_ifindex, tipo) 
VALUES ('AA:BB:CC:DD:EE:22', 'PC-Aluno-01', '192.168.1.101', 1, 1, 12, 'aluno');

INSERT INTO maquinas (mac_address, nome_host, ip_address, sala_id, switch_id, porta_ifindex, tipo) 
VALUES ('AA:BB:CC:DD:EE:33', 'PC-Aluno-02', '192.168.1.102', 1, 1, 13, 'aluno');
\q
```

### 4. Executando a Aplicação
Crie e ative um ambiente virtual para o Python:
```bash
python3 -m venv venv
source venv/bin/activate
pip install Flask psycopg2-binary
```

Compile o motor Java (certifique-se de estar na raiz do projeto):
```bash
cd java_snmp
javac -cp snmp4j-2.8.18.jar GerenteSNMP.java
cd ..
```

Inicie o servidor Web Backend:
```bash
python3 app.py
```

### 5. Uso e Acesso
Acesse a aplicação no navegador de acordo com o seu ambiente:
* **Ambiente Simulado:** `http://localhost:5000`
* **Ambiente Físico (Cabo):** `http://<SEU_IP_CABEADO>:5000` (Ex: `http://10.90.90.200:5000`)
 * O sistema possui validação estrita de segurança baseada no Endereço Físico (MAC Address). O Python varre a tabela ARP e as interfaces físicas do servidor para garantir que apenas o equipamento exato cadastrado como professor tenha permissão para visualizar a tela de Login. Acessos de outros dispositivos exibirão uma tela de "Acesso Negado", dedurando o IP e o MAC do invasor.
 * * **Senha de acesso padrão:** `admin123`

---

### 6. Transição para o Hardware Real (Switch Físico)
Sendo um sistema *Data-Driven*, migrar do simulador para o hardware real (ex: Switch D-Link do Laboratório) **não exige alterações no código fonte**. Todo o direcionamento é feito via rede e banco de dados.
 
**Passo A: Fixar o IP na placa de rede via terminal (nmcli)**
Para evitar que o Ubuntu derrube a conexão por falta de um servidor DHCP no Switch, fixe seu IP e amarre-o à sua interface de rede (substitua `enx00e04c6800cc` pela sua placa):
```bash
sudo nmcli connection add type ethernet ifname enx00e04c6800cc con-name "Lab-Redes" ipv4.method manual ipv4.addresses 10.90.90.200/24
sudo nmcli connection up "Lab-Redes"
```
 
**Passo B: Encontrar o IP do Switch na rede**
Realize um *arp-scan* forçando o seu IP de origem (bypass) para obrigar o switch a responder:
```bash
sudo arp-scan -I enx00e04c6800cc --arpspa=10.90.90.200 10.90.90.0/24
```
 
**Passo C: Mapear os Índices Físicos (`ifIndex`)**
Execute uma requisição de leitura SNMP no IP do switch encontrado para descobrir os identificadores numéricos exatos de cada porta:
```bash
snmpwalk -v2c -c public 10.90.90.90 ifDescr
```
 
**Passo D: Atualizar a Topologia no Banco de Dados**
Com as portas mapeadas, informe o novo cenário ao PostgreSQL:
```bash
sudo -u postgres psql -d projeto_ogmr
```
```sql
-- 1. Atualiza IP e Community de Escrita do Switch Físico
UPDATE switches SET ip_address = '10.90.90.90', snmp_community = 'private' WHERE id = 1;
 
-- 2. Atualiza a porta física e o IP do Professor 
-- NOTA: Se você passou a usar um Adaptador USB ao invés do Wi-Fi, atualize a coluna mac_address também!
UPDATE maquinas SET ip_address = '10.90.90.200', porta_ifindex = 5 WHERE tipo = 'professor';
 
-- 3. Atualiza o IP da máquina do Aluno e sua porta física (Ex: Porta 3)
UPDATE maquinas SET ip_address = '10.90.90.101', porta_ifindex = 3 WHERE nome_host = 'PC-Aluno-01';
\q
```

---


