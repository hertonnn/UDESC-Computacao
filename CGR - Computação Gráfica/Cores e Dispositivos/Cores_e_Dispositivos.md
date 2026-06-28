# Cores e Dispositivos Gráficos

Este documento consolida o estudo de como as cores funcionam física e biologicamente, os modelos matemáticos que as representam e o hardware responsável por captar e exibir imagens na Computação Gráfica.

---

## 1. Luz, Cor e o Olho Humano

A luz é uma forma de **energia (radiação eletromagnética)**. A cor de um objeto que percebemos é, na verdade, os comprimentos de onda que as moléculas do objeto *não absorveram* (foram refletidos). Um objeto vermelho absorve quase todo o espectro visível e reflete apenas a faixa avermelhada.

O nosso olho possui dois tipos de células fotossensíveis na retina:
- **Bastões (120 milhões):** Extremamente sensíveis à luz, mas **não distinguem cores**. Usados em ambientes muito escuros e visões periféricas.
- **Cones (6 a 7 milhões):** Responsáveis pela **visão em cores**. Estão divididos em três grupos sensíveis a diferentes espectros: comprimentos de onda longos (Vermelho), médios (Verde) e curtos (Azul). Esta é a base biológica para o padrão RGB.

## 2. Sistemas e Modelos de Cores

Para reproduzir a luz fisicamente no espaço digital, utilizamos modelos matemáticos:

- **RGB (Red, Green, Blue):** Modelo **Aditivo** (baseado em luz). Usado em monitores. Começa no escuro (0,0,0 = Preto) e, somando as três luzes no máximo, gera-se luz Branca.
- **CMYK (Cyan, Magenta, Yellow, Black):** Modelo **Subtrativo** (baseado em tinta/pigmento). Usado em impressoras. A ausência de pigmento revela o papel (Branco) e a soma das três tintas anula a reflexão, gerando (teoricamente) Preto. O "K" (Black) foi adicionado para gerar pretos mais puros, melhorar contraste e economizar tinta colorida.
- **HSV / HLS:** Modelos focados na intuição humana:
  - **H (Hue / Matiz):** O ângulo no disco de cores (ex: Vermelho a 0º, Verde a 120º). Representa a cor pura.
  - **S (Saturation / Saturação):** Pureza da cor. Saturação zero gera tons de cinza/branco.
  - **V (Value / Intensidade) ou L (Lightness / Luminosidade):** O "brilho" da cor, onde zero representa o escuro total (preto).
- **Padrões S-RGB, Adobe RGB e ProPhoto RGB:** Perfis que ditam o quão grande (gamut) é o espaço de cores num ambiente. S-RGB é o menor e mais seguro universalmente. ProPhoto é usado por câmeras profissionais em RAW porque capta uma gama muito maior.

## 3. Dispositivos Gráficos (Hardware)

Para permitir a troca de informações espaciais, utilizamos hardware focado em **Entrada**, **Saída** e **Processamento**:

### Entrada (Captura e Posição)
Ajudam a interagir com os modelos 2D e 3D.
- **Mouses e Mesas Digitalizadoras:** Fornecem coordenadas X, Y bidimensionais.
- **Dispositivos Específicos:** Como Trackballs, Joysticks e Magellan 3D Controllers fornecem 6-DOF (Degrees of Freedom) – ou seja, posição 3D ($X,Y,Z$) e Rotação 3D ($Roll, Pitch, Yaw$) simultaneamente.
- **Sistemas de Feedback Tátil (Haptics) e Luvas de Dados:** Essenciais em Realidade Virtual para passar sensação física de interação.

### Saída (Display)
Comunica os resultados calculados para os olhos do usuário.
- Monitores, Painéis Multi-Monitor, Mesas Interativas.
- **HMDs (Head Mounted Displays):** Óculos de Realidade Virtual (Oculus Rift, Meta Quest) ou Óculos de Realidade Aumentada (Microsoft Hololens) que substituem a tela tradicional por visão estéreo perfeitamente alinhada com o olho.
- **Cavernas (CAVEs):** Salas onde todas as paredes são projetadas, imergindo o usuário na cena.

### Processamento Gráfico
Historicamente, tínhamos meros Kb de VRAM com capacidade de renderizar pontos básicos. Hoje temos GPUs superpoderosas contendo dezenas de GBs e dezenas de Teraflops de performance para executar *shaders* em tempo real sobre milhões de polígonos iluminados simultaneamente.
