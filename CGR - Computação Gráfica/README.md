<div align="center">

# 🎨 Computação Gráfica (CGR) - UDESC

![img_cgr](https://i.ytimg.com/vi/-4_OU95nKuU/maxresdefault.jpg)
[Computação Gráfica | Nerdologia Tech](https://www.youtube.com/watch?v=-4_OU95nKuU)


[![C++](https://img.shields.io/badge/C++-%2300599C.svg?style=for-the-badge&logo=c%2B%2B&logoColor=white)](https://cplusplus.com/)
[![OpenGL](https://img.shields.io/badge/OpenGL-%23FFFFFF.svg?style=for-the-badge&logo=opengl)](https://www.opengl.org/)
[![Vulkan](https://img.shields.io/badge/Vulkan-%23AA2222.svg?style=for-the-badge&logo=vulkan&logoColor=white)](https://www.vulkan.org/)

Estudo dos princípios, algoritmos e ferramentas para a síntese, manipulação e exibição de imagens digitais. Repositório dedicado aos estudos, exercícios e projetos da disciplina de Computação Gráfica.

[O que é Computação Gráfica?](#-o-que-é-computação-gráfica) •
[Setup e Ferramentas](#️-materiais-e-ferramentas) •
[Conteúdos](#-conteúdos-gerais) •
[Roadmap](#️-roadmap-da-disciplina)

</div>

---

## 🚀 O que é Computação Gráfica?

A **Computação Gráfica (CGR)** é a área da ciência da computação voltada para a geração de imagens a partir de modelos matemáticos e geométricos. Enquanto o processamento de imagens analisa imagens prontas, a CG foca na sua **criação**, simulando a interação da luz com objetos em ambientes virtuais.

---

## 🗺️ Roadmap da Disciplina

Tópicos e projetos que serão abordados durante o semestre:

- [ ] **Introdução à Computação Gráfica**
- [ ] **Cores e Dispositivos**
- [ ] **Modelagem Geométrica**
- [ ] **OpenGL**
- [ ] **Visualização 2D**
- [ ] **Transformações Geométricas**
- [ ] **Câmera Sintética**
- [ ] **Geometria Computacional**
- [ ] **Curvas e Superfícies**
- [ ] **Mapeamento de Textura**
- [ ] **Iluminação e Sombreamento (Shading)**
- [ ] **Iluminação em OpenGL**
- [ ] **Iluminação Global:** *Implementação de algoritmos de Ray Tracing utilizando C++ e OpenGL.*
- [ ] **Animação Computacional**
- [ ] **Processamento de Imagens**
- [ ] **Visão Computacional:** *Extração e análise de características de imagens.*
- [ ] **Redes Neurais Convolucionais**
- [ ] **Vulkan**

---

<b>Demos Históricas de CGR e Física (1999 - 2016)</b>
<br>
Coleção de simulações físicas e efeitos gráficos da nVidia ao longo dos anos:

* **1999** - Bubble/deformação | [Crystal Ball](https://eduplay.rnp.br/portal/video/embed/276169)
* **2000** - Grove/enxame | Toy Soldiers
* **2001** - [Inferno / Cometa](https://eduplay.rnp.br/portal/video/embed/276173)
* **2002** - Grace/dança | Squid | Wolfman | [Twister](https://eduplay.rnp.br/portal/video/embed/276176)
* **2003** - Ogre | Vulcan/fogo
* **2004** - Timbury
* **2005** - Mad Mod Mike
* **2006** - [Box of Smoke](https://eduplay.rnp.br/portal/video/embed/276182)
* **2007** - [Cascades](https://eduplay.rnp.br/portal/video/embed/276183)
* **2008** - [Cryostasis / Chuva](https://eduplay.rnp.br/portal/video/embed/276184) | [Particle Fluid](https://eduplay.rnp.br/portal/video/embed/276185)
* **2010** - Alien vs Triangles
* **2014** - Gameworks PhysX Flex | [Flameworks](https://eduplay.rnp.br/portal/video/embed/276187)
* **2016** - VR Funhouse



---


## 🛠️ Materiais e Ferramentas

Documentação e guias para configurar o ambiente de desenvolvimento local para as aulas práticas.

### 📦 Materiais Básicos
* 📖 [**Apostila da disciplina**](https://udesc-my.sharepoint.com/:w:/g/personal/90873602072_udesc_br/ES1gVnIiaPNMrOy4haIsaT8BttJ735cMMgWZe6FUb0a1Aw)
* 📝 **Lista de Exercícios:** Disponível nos diretórios deste repositório.

### 💻 Ambientes e Bibliotecas
* 💿 [**ISO TinyCore**](https://udesc-my.sharepoint.com/:u:/g/personal/90873602072_udesc_br/Eca3R9trQOdOhA7JU1m0wFQB0SPtaFbd9m_e2KXxT04oGg?e=qxxajv) *(Ambiente OpenGL pré-configurado)*
* 🐧 [**Guia de Instalação: OpenGL no Linux**](https://en.wikibooks.org/wiki/OpenGL_Programming/Installation/Linux)
* 🔴 [**Vulkan Tutorials**](https://www.vulkan.org/learn#vulkan-tutorials)

### ⚙️ Setup Windows + VSCode (C/C++)
Para compilar e rodar os projetos localmente:
1. Instalar o **VSCode** com a extensão para **C/C++**.
2. Baixar o [**GLAD**](https://glad.dav1d.de/) *(escolher a versão da API OpenGL, gerar e baixar o `.zip`)*.
3. Baixar o [**GLFW**](https://www.glfw.org/download.html) *(binários pré-compilados)*.
4. Extrair e copiar os diretórios de `includes` e binários para a pasta raiz do seu projeto.

---

## 📚 Conteúdos Gerais

### 🌈 Cores
Entendendo a física e a biologia por trás da percepção visual:

| Tópico | Material de Estudo |
| :--- | :--- |
| **Física das Cores** | 🎥 [Why Is Blue So Rare In Nature?](https://www.youtube.com/watch?v=3g246c6Bv58) |
| **Visão Animal** | 🎥 [Como aves enxergam as cores](https://www.youtube.com/watch?v=fuM_0Yf_tM8) |
| **Biologia Mística** | 🎥 [Olho versus Câmera (Michael Mauser)](https://www.youtube.com/watch?v=mY9YmX_Gf6o) |
| **Genética** | 🎥 [Seres Tetracromáticos](https://www.youtube.com/watch?v=tVRE_v18KIs) |

> **💡 O Mistério do Azul na Natureza:**
> O azul raramente é um *pigmento* natural devido ao imenso esforço metabólico necessário para absorver a luz vermelha (de baixa energia). Borboletas e araras azuis utilizam a **cor estrutural**: nanoestruturas microscópicas que funcionam como prismas para refletir apenas o comprimento de onda azul. 

### 🖼️ Visualização 2D
[![Experiment 01 - Line Clipping](https://img.youtube.com/vi/R355cpuORCM/hqdefault.jpg)](https://www.youtube.com/watch?v=R355cpuORCM)

## 🎥 Câmera Sintética
* 📄 **Câmera Sintética e Visibilidade** *(Arquivo Moodle)*
* 🎥 [**Olho versus Câmera - Michael Mauser (TED-Ed)**](https://www.youtube.com/watch?v=OGqAM2Mykng)
* 🎥 [**Fast Inverse Square Root - A Quake III Algorithm**](https://www.youtube.com/watch?v=p8u_k2LIZyo)

## 🌗 Iluminação e Sombreamento (Shading)
* 📄 [**Modelos de Iluminação**](https://moodle.joinville.udesc.br/mod/resource/view.php?id=332264) *(Arquivo Moodle)*
  * **Luz:** Luz Ambiente, Reflexão Difusa, Atenuação Atmosférica, Reflexão Especular, Modelo de Iluminação de Phong e Múltiplas Fontes de Luz.
* 📄 [**Tipos de Luz**](https://moodle.joinville.udesc.br/mod/resource/view.php?id=332265) *(Arquivo Moodle)*
  * **Puntiforme:** Omnidirecional, Direcional/Paralela.
  * **Spot:** Lanterna, abajur.
  * **Extensa/Área**
* 📄 **Modelos de Sombreamento para Polígonos (Shading):**
  * Flat Shading
  * Interpolated Shading
  * Polygon-Mesh Shading
  * Gouraud Shading
  * Phong Shading

## 📐 Geometria Computacional
* 📄 [**Geometria Computacional**](https://moodle.joinville.udesc.br/mod/resource/view.php?id=332311) *(Arquivo Moodle)*
  * **Tópicos:** Fundamentação, Interseções de Segmentos de Linha, Envoltória Convexa, Particionamento de Polígonos, Triangulações de Delaunay, Diagramas de Voronoy, Nível de Detalhe, Grafos de Visibilidade, Planejamento de Movimento, BSP-trees p/ visibilidade.

## ➰ Curvas e Superfícies
* 📄 [**Curvas e Superfícies**](https://moodle.joinville.udesc.br/mod/resource/view.php?id=332310) *(Arquivo Moodle)*
  * **Tópicos:** Curvas Interpoladoras ou Aproximadoras, Grau da Curva, Controle Local ou Global, Aberta / Fechada, Continuidade.

## 🧱 Mapeamento de Textura
* 📄 [**Mapeamento de Textura**](https://moodle.joinville.udesc.br/mod/resource/view.php?id=332269) *(Arquivo Moodle)*
* 📄 [**Exemplos de textura em C**](https://moodle.joinville.udesc.br/mod/resource/view.php?id=332271) *(Código Fonte)*
* 📄 [**Uso de textura em modelos de iluminação local**](https://moodle.joinville.udesc.br/mod/resource/view.php?id=332278) *(Arquivo Moodle)*
  * Textura Procedural, Environment Mapping, Shadow Map, Bump Mapping, Normal Mapping, Displacement Mapping.
* 📝 [**TC4 - Textura**](https://moodle.joinville.udesc.br/mod/resource/view.php?id=332279): Tire fotos de algum objeto simples e crie o modelo geométrico usando a imagem como textura.
* 🔗 [**Túnel - exemplo de textura simples**](https://www.youtube.com/watch?v=STTi6qzHXUA)
* 🔗 [**Skybox (e uma caixa)**](https://www.youtube.com/watch?v=wyuGqgjFXYw)
* 🔗 [**UV mapping**](https://www.youtube.com/watch?v=Q_AYQh8r_GQ)
* 🔗 [**Textura em partículas (fogo e fumaça)**](https://www.youtube.com/watch?v=c1PSM30LZGM)
* 🎥 [**Vídeo: O melhor site para TEXTURAS DE GRAÇA**](https://www.youtube.com/watch?v=o0-CfeRVIAo)
* 🔗 [**TinyObjLoader - wavefront obj loader**](https://github.com/tinyobjloader/tinyobjloader)
* 🔗 [**Open Asset Import Library (assimp)**](https://github.com/assimp/assimp)
* 🔗 [**rapidobj**](https://github.com/guybrush77/rapidobj)
* 🔗 [**fast_obj**](https://github.com/thisistherk/fast_obj)

## 💡 Iluminação em OpenGL
* 📄 [**Iluminação em OpenGL**](https://moodle.joinville.udesc.br/mod/resource/view.php?id=332266) *(Arquivo Moodle)*
* 📄 [**Exemplo em C**](https://moodle.joinville.udesc.br/mod/resource/view.php?id=352418) *(Código Fonte)*

## 🌟 Iluminação Global: *Implementação de algoritmos de Ray Tracing utilizando C++ e OpenGL.*
* 📄 [**Modelos de Iluminação Global**](https://moodle.joinville.udesc.br/mod/resource/view.php?id=332290): Ray Tracing, Radiosidade, Path Tracing.
* 📄 [**POVRay**](https://moodle.joinville.udesc.br/mod/resource/view.php?id=332304) *(Arquivo Moodle)*
* 📝 [**TC5 - Iluminação Global**](https://moodle.joinville.udesc.br/mod/resource/view.php?id=332301): Tire fotos de algum objeto simples e crie o modelo geométrico usando a imagem como textura, visualizando o modelo através de um método de iluminação global (RT, Radiosidade,...).
* 📝 [**Trabalho Complementar 6**](https://moodle.joinville.udesc.br/mod/resource/view.php?id=353978) - [Tema Escolhido TC6](https://udesc-my.sharepoint.com/:w:/g/personal/90873602072_udesc_br/IQAUXSizdVN9RIoNGEjNbU2xAZBi0AxhY7bzYlq42Pd4m14?e=F0jd6I)
* 🔗 [**Ray Tracing in One Weekend**](https://raytracing.github.io/)
* 🎥 [**Render engine speed comparison (Blender Guru)**](https://www.youtube.com/watch?v=myg-VbapLno)
* 🎥 [**Blender Cycles, Renderman & Redshift Render Comparison (Small Robot Studio)**](https://www.youtube.com/watch?v=6v7ZuFXPPQg)
* 🎥 [**Blender 3D Eevee, SSGI, Cycles & Redshift Render Comparison (Small Robot Studio)**](https://www.youtube.com/watch?v=ljkaCQIXs_I)
* 🔗 [**Learn Computer Graphics From Scratch**](https://www.scratchapixel.com/)
* 🔗 [**O que tem de novo? DirectX e Ray Tracing**](https://www.youtube.com/watch?v=VHfN_w5ll4o)
* 🔗 [**Bounding volume**](https://en.wikipedia.org/wiki/Bounding_volume)
* 🔗 [**Bounding Volume Hierarchy (BVH)**](https://en.wikipedia.org/wiki/Bounding_volume_hierarchy)
* 📄 [**Paper nVidia: BVHs, Octrees e k-d Trees**](https://research.nvidia.com/sites/default/files/pubs/2012-06_Maximizing-Parallelism-in/karras2012hpg_paper.pdf) *(PDF)*
* 🔗 [**NVIDIA Turing Architecture In-Depth**](https://developer.nvidia.com/blog/nvidia-turing-architecture-in-depth/)
* 🔗 [**NVIDIA Ada Lovelace Architecture**](https://www.nvidia.com/en-us/geforce/news/rtx-40-series-graphics-cards-announcements/)
* 🔗 [**NVIDIA DLSS 4 Introduces Multi Frame Generation**](https://www.nvidia.com/en-us/geforce/news/dlss4-multi-frame-generation-ai-innovations/)

## 🎬 Animação Computacional
* 📄 [**Animação Computacional**](https://moodle.joinville.udesc.br/mod/resource/view.php?id=332323) *(Arquivo Moodle)*
* 🔗 [**Multidão de personagens animados (The Hobbit)**](https://www.youtube.com/watch?v=qkyLDE_o0FM&t=0s)
* 🔗 [**Character Articulation through Profile Curves (Pixar)**](https://vimeo.com/707052757)
* 🔗 [**The Power Particle-In-Cell Method**](https://www.youtube.com/watch?v=fhq0HpAUkLY)
* 🔗 [**(nVidia / SIGGRAPH 2025) Neurally Integrated Finite Elements for Differentiable Elasticity on Evolving Domains**](https://research.nvidia.com/labs/toronto-ai/flexisim/)
* 🔗 [**Quadtree Tall Cells for Eulerian Liquid Simulation (SIGGRAPH 2025)**](https://graphics.c.u-tokyo.ac.jp/hp/en/archives/3252)
* 🔗 [**AnyTop: Character Animation Diffusion with Any Topology (SIGGRAPH 2025)**](https://anytop2025.github.io/Anytop-page/)

## 🪄 Processamento de Imagens
* 📄 [**Processamento de Imagens**](https://moodle.joinville.udesc.br/mod/resource/view.php?id=332313) *(Arquivo Moodle)*

## 👁️ Visão Computacional: *Extração e análise de características de imagens.*
* 📄 [**Visão Computacional**](https://moodle.joinville.udesc.br/mod/resource/view.php?id=332320) *(Arquivo Moodle)*

## 🧠 Redes Neurais Convolucionais
* 📄 [**Redes Neurais Convolucionais**](https://moodle.joinville.udesc.br/mod/resource/view.php?id=332314) *(Arquivo Moodle)*
* 🖼️ **Comparativo arquiteturas GPU vs NPU para IA (Snapdragon):

![NPU_comparativo](/utils/img/NPU_comparativo.png)

## 🌋 Vulkan
* 🔗 *Material de apoio extraído:* [**Vulkan Tutorials**](https://moodle.joinville.udesc.br/mod/url/view.php?id=332216)
* 🔗 *Material de apoio extraído:* [**Instalar Vulkan**](https://moodle.joinville.udesc.br/mod/url/view.php?id=332227)

## 🔬 Laboratórios e Pesquisa

**LARVA** - *LAboratory for Research on Visual Applications*

---

## 👨‍🏫 Sobre o Professor

👤 **Prof. Dr. André Tavares da Silva** 📧 **Contato:** andre.silva@udesc.br

**Formação Acadêmica:**
* 🎓 Graduação em Informática (UNISINOS, 1999)
* 🎓 Mestrado em Computação Aplicada (UNISINOS, 2005)
* 🎓 Doutorado em Engenharia Elétrica (UNICAMP, 2011)

**Áreas de Pesquisa e Interesse:**
Sistemas de Computação, com foco primário em:
* **CBIR** *(Content-Based Image Retrieval)*
* **Relevance Feedback**
* **OPF** *(Optimum-Path Forest)*

---


## Trabalhos Acadêmicos Relacionados (UDESC)

Abaixo estão alguns trabalhos acadêmicos desenvolvidos na UDESC que se relacionam com o conteúdo desta disciplina:

- **Zenbreath: jogo sério ativo para promover o relaxamento pela respiração**
  - *Autor(es)/Ano:* Henrique Sant’anna de Faria (Orientador: Marcelo D. S. Hounsell) / 2024
  - *Link:* [https://repositorio.udesc.br/entities/publication/8a2cbfe5-bbc1-40da-ac2b-6aabebc789ff](https://repositorio.udesc.br/entities/publication/8a2cbfe5-bbc1-40da-ac2b-6aabebc789ff)

- **Investigação e desenvolvimento nas áreas tecnológicas afins à computação gráfica**
  - *Autor(es)/Ano:* Dino Raffael Cristofoleti Magri (Orientador: Vilson Vieira da Silva Junior) / 2009
  - *Link:* [https://repositorio.udesc.br/handle/UDESC/18552](https://repositorio.udesc.br/handle/UDESC/18552)

---

### 📋 Trabalhos apresentados no TC6 (2026)

- **Implementação e otimização de uma técnica de Ray Tracing**
  - *Autor(es)/Ano:* Felipe Augusto Rieck / 2008
  - *Resumo:* Aprimoramento de um Ray Tracer desenvolvido para CGR. Aborda otimizações de alto custo computacional via estrutura de aceleração KD-Tree e processamento em GPU, para renderização de esferas, malhas de triângulos, texturas, reflexões e transparências.
  - *Link:* [https://repositorio.udesc.br/handle/UDESC/18475](https://repositorio.udesc.br/handle/UDESC/18475)

- **Reconhecimento de placas de sinalização do trânsito brasileiro através de redes neurais convolucionais**
  - *Autor(es)/Ano:* Gabriel Lenz Balatka / 2024
  - *Resumo:* Desenvolvimento de sistema de reconhecimento automático de placas de sinalização do trânsito brasileiro utilizando redes neurais convolucionais (CNN).
  - *Link:* [https://repositorio.udesc.br/handle/UDESC/20053](https://repositorio.udesc.br/handle/UDESC/20053)

- **Controle Motor com Realidade Aumentada** *(Análise do Controle Motor com Interações baseadas em Dispositivos Convencionais e Realidade Aumentada)*
  - *Autor(es)/Ano:* Débora Cristine Xavier; Marcelo da Silva Hounsell / 2009
  - *Resumo:* Desenvolvimento do software MOSKA (MOtor SKill Analyser) para diagnóstico e monitoramento de problemas de controle motor fino, comparando dispositivos convencionais (mouse, tablet) com Realidade Aumentada via webcam e marcadores jARToolKit.
  - *Link:* [https://repositorio.udesc.br/](https://repositorio.udesc.br/) *(buscar por: "Controle Motor com Realidade Aumentada" — disponível também na RITA: Revista de Informática Teórica e Aplicada)*

- **Fusão de imagens em diferentes perspectivas para geração de fachadas livres de oclusão**
  - *Autor(es)/Ano:* Gustavo Pedrini Maestri / 2024–2025
  - *Resumo:* Trabalho sobre visão computacional e processamento de imagens aplicado à fusão de múltiplas perspectivas fotográficas para reconstrução de fachadas sem oclusões (árvores, veículos, postes).
  - *Link:* [https://repositorio.udesc.br/](https://repositorio.udesc.br/) *(buscar por: "Fusão de imagens em diferentes perspectivas")*

- **Geração automática de código LaTeX a partir de expressões matemáticas manuscritas**
  - *Autor(es)/Ano:* Emanuel Henrique Farias / 2016
  - *Resumo:* Aplicação web que reconhece expressões matemáticas manuscritas (offline) e as converte automaticamente para código LaTeX, utilizando filtros de mediana, limiarização, componentes conexos, rede neural convolucional e estrutura de dados em árvore.
  - *Link:* [https://repositorio.udesc.br/handle/UDESC/18918](https://repositorio.udesc.br/handle/UDESC/18918)

- **Um Framework para a Construção de Agentes Autônomos Life-Like**
  - *Autor(es)/Ano:* UDESC / 2009–2015 *(data aproximada)*
  - *Resumo:* Proposta de framework para construção de agentes autônomos com comportamento semelhante a seres vivos (life-like), para uso em ambientes interativos e simulações.
  - *Link:* [https://repositorio.udesc.br/](https://repositorio.udesc.br/) *(buscar por: "Framework Agentes Autônomos Life-Like")*

- **Simulador de direção com vistas panorâmicas georreferenciadas**
  - *Autor(es)/Ano:* Marcos Vinícius Lenz Balatka / 2019
  - *Resumo:* Desenvolvimento de um simulador de direção veicular que utiliza vistas panorâmicas georreferenciadas (dados do mundo real) para a geração de cenários imersivos.
  - *Link:* [https://repositorio.udesc.br/handle/UDESC/18895](https://repositorio.udesc.br/handle/UDESC/18895)

- **Aprendizado de Máquina aplicado no reconhecimento de placas de identificação no transporte de substâncias perigosas**
  - *Autor(es)/Ano:* Murilo Francisco de Freitas (Orientador: Rafael Parpinelli) / 2024–2025
  - *Resumo:* Aplicativo móvel com redes neurais convolucionais para identificar automaticamente painéis de segurança de veículos transportadores de substâncias perigosas, fornecendo número ONU, código de risco, classe e medidas de segurança. Base de dados com 682 registros.
  - *Link:* [https://repositorio.udesc.br/](https://repositorio.udesc.br/) *(buscar por: "Aprendizado de Máquina placas substâncias perigosas")*

- **Interface de teleoperação em ambiente de realidade virtual para robôs industriais colaborativos**
  - *Autor(es)/Ano:* Lucas Keiji Hori Rosa / 2023
  - *Resumo:* Interface de teleoperação desenvolvida em ambiente de realidade virtual para controle remoto de robôs industriais colaborativos.
  - *Link:* [https://repositorio.udesc.br/handle/UDESC/20058](https://repositorio.udesc.br/handle/UDESC/20058)

- **Otimizações para motores de jogos através de projeto orientado a dados**
  - *Autor(es)/Ano:* Vinícius Bruch Zuchi (Orientador: André Tavares da Silva) / 2018
  - *Resumo:* Implementação de um motor de jogos (game engine) utilizando Data-Oriented Design (DOD) para mitigar o gargalo processador-memória. Compara DOD com Programação Orientada a Objetos em benchmarks de desempenho com biblioteca matemática de vetores e matrizes.
  - *Link:* [https://repositorio.udesc.br/](https://repositorio.udesc.br/) *(buscar por: "Otimizações para motores de jogos projeto orientado a dados")*

- **Reconhecimento de imagens aplicado a partituras musicais**
  - *Autor(es)/Ano:* Thiago Margarida / 2009
  - *Resumo:* Sistema de reconhecimento óptico de música (OMR) que aplica processamento de imagens para identificar e interpretar símbolos em partituras musicais digitalizadas.
  - *Link:* [https://repositorio.udesc.br/handle/UDESC/18583](https://repositorio.udesc.br/handle/UDESC/18583)

- **S2D2: um sistema de simulação dinâmica de direção: construindo cenários com dados reais**
  - *Autor(es)/Ano:* Carlos Henrique da Costa (Orientador: Marcelo da Silva Hounsell) / 2025
  - *Resumo:* Simulador de direção que utiliza dados do mundo real (Google Maps) para geração automática de cenários e rotas em grafo, com integração de hardware (volante com force feedback) e interface gráfica em OpenGL.
  - *Link:* [https://repositorio.udesc.br/handle/UDESC/18833](https://repositorio.udesc.br/handle/UDESC/18833)

- **Análise de desempenho na etapa de voxelização do método Voxel Cone Tracing para iluminação global interativa**
  - *Autor(es)/Ano:* Karll Henning / 2019
  - *Resumo:* Análise do desempenho da etapa de voxelização no método Voxel Cone Tracing, uma técnica avançada de iluminação global em tempo real que converte a geometria da cena em voxels para posterior rastreamento de cones.
  - *Link:* [https://repositorio.udesc.br/](https://repositorio.udesc.br/) *(buscar por: "Voxelização Voxel Cone Tracing Karll Henning")*

- **Visão Computacional para Sistema de Notificação de Risco de Colisão Veicular**
  - *Autor(es)/Ano:* Márcio Koch (Orientador: André Tavares da Silva) / 2017
  - *Resumo:* Dissertação de Mestrado (PPGCAP/UDESC) sobre sistema de detecção e notificação de risco de colisão veicular utilizando visão computacional.
  - *Link:* [https://repositorio.udesc.br/](https://repositorio.udesc.br/) *(buscar por: "Visão Computacional Notificação Risco Colisão Veicular Márcio Koch")*

- **Uma ferramenta de animação de avatares humanóides para jogos tridimensionais**
  - *Autor(es)/Ano:* Usla da Silva Delfino / 2009–2012 *(data aproximada)*
  - *Resumo:* Desenvolvimento de uma ferramenta para animação de avatares humanóides voltada para aplicações em jogos tridimensionais, explorando técnicas de processamento gráfico e modelagem de objetos reais.
  - *Link:* [https://repositorio.udesc.br/](https://repositorio.udesc.br/) *(buscar por: "animação de avatares humanóides jogos tridimensionais")*

- **Interpolação de Curvas com Mudança Topológica**
  - *Autor(es)/Ano:* Guilherme Rossetti Anzollin / 2009–2012 *(data aproximada)*
  - *Resumo:* Trabalho sobre técnicas de interpolação de curvas que suportam mudanças topológicas, com aplicações em animação computacional e modelagem geométrica.
  - *Link:* [https://repositorio.udesc.br/](https://repositorio.udesc.br/) *(buscar por: "Interpolação de Curvas Mudança Topológica")*

- **Investigação e desenvolvimento nas áreas tecnológicas afins à computação gráfica**
  - *Autor(es)/Ano:* Dino Raffael Cristofoleti Magri (Orientador: Vilson Vieira da Silva Junior) / 2009
  - *Link:* [https://repositorio.udesc.br/handle/UDESC/18552](https://repositorio.udesc.br/handle/UDESC/18552)

- **Impactos do uso de tecnologias imersivas em exergames**
  - *Autor(es)/Ano:* Leonardo Silva Vasquez Ribeiro / 2024
  - *Resumo:* Monografia sobre os impactos da utilização de tecnologias imersivas (como realidade virtual e aumentada) em exergames — jogos que combinam atividade física com interação digital.
  - *Link:* [https://repositorio.udesc.br/handle/UDESC/11459](https://repositorio.udesc.br/handle/UDESC/11459)

- **Desenvolvimento de tecnologia para detecção e identificação individual de cães por meio de biometria do plano nasal utilizando análise de imagem**
  - *Autor(es)/Ano:* (UDESC) / 2024
  - *Resumo:* Desenvolvimento de solução baseada em análise de imagem para identificação biométrica individual de cães por meio do padrão único do plano nasal (focinho), similar à biometria de impressões digitais humanas.
  - *Link:* [https://repositorio.udesc.br/](https://repositorio.udesc.br/) *(buscar por: "detecção identificação cães biometria plano nasal")*

- **Modelagem de Exteriores Extensos: Estudo de Caso com "Campus Virtual do Centro de Ciências Tecnológicas da UDESC Joinville"**
  - *Autor(es)/Ano:* Alessandro Pinto Schulz (Orientador: Marcelo da Silva Hounsell) / 2004
  - *Resumo:* Desenvolvimento de ambiente virtual 3D do campus CCT/UDESC Joinville usando VRML e o plug-in Cortona. Inclui modelagem das fachadas externas dos blocos B, D, E, K, G e H com texturas digitalizadas e ambiente interior detalhado do Bloco F.
  - *Link:* [https://repositorio.udesc.br/](https://repositorio.udesc.br/) *(buscar por: "Modelagem de Exteriores Extensos Campus Virtual UDESC")*

- **Uma Ontologia para a Modelagem de Ambientes 3D com Smart Objects para Atores Digitais Autônomos**
  - *Autor(es)/Ano:* Lucas Gustavo Amaral Fernandes / 2012
  - *Resumo:* Proposta de ontologia para modelagem semântica de ambientes tridimensionais com objetos inteligentes (Smart Objects), permitindo que atores digitais autônomos interajam com o ambiente de forma contextualizada.
  - *Link:* [https://repositorio.udesc.br/handle/UDESC/18742](https://repositorio.udesc.br/handle/UDESC/18742)
---
<div align="center">
  <i>"Computação Gráfica é a arte de tornar visível aquilo que a matemática descreve."</i> 🖥️✨
</div>