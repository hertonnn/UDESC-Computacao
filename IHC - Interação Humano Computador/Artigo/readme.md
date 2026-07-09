# 📝 Aprendizados de LaTeX e Overleaf

Guia rápido de soluções e boas práticas para formatação de artigos acadêmicos (Template SBC).

## 1. Posicionamento Exato de Tabelas e Figuras

Por padrão, o LaTeX faz os elementos "flutuarem" para o topo ou fim da página. Para travar uma tabela ou imagem exatamente onde ela está no texto:

* Adicione o pacote no preâmbulo: `\usepackage{float}`
* Use o parâmetro de posição `[H]` (maiúsculo): `\begin{table}[H]` ou `\begin{figure}[H]`

## 2. Quebra de Linha em URLs Longas

URLs de artigos e sites costumam estourar a margem lateral do PDF nas referências.

* **A Solução:** Substitua `\usepackage{url}` por `\usepackage{xurl}` no preâmbulo. Esse pacote força a quebra do link em qualquer caractere, mantendo o alinhamento perfeito do documento.

## 3. Ajustes no Arquivo `.bib` (BibTeX)

* **Proteger Letras Maiúsculas:** O BibTeX converte os títulos automaticamente para letras minúsculas. Para preservar as maiúsculas em nomes próprios ou siglas (como Brasil ou Paraná), envolva a palavra em chaves.
* *Exemplo:* `title = {Os desafios da Educação em Computação no {Brasil}...}`


* **Símbolo de Porcentagem em Links:** Dentro do comando `\url{}`, não é necessário "escapar" o símbolo de porcentagem com barra invertida (`\%`). Use a URL crua (ex: `%20` no lugar de espaço).

## 4. Boas Práticas de Escrita Acadêmica

* **Tabelas Autossuficientes:** Em tabelas comparativas, evite marcações genéricas como "Artigo 1" ou "Artigo 2". Utilize a citação no padrão SBC `Autor (Ano)`, para que o leitor identifique a fonte sem precisar buscar no texto.
* **Citações no Texto:** O ideal é dar o protagonismo da pesquisa aos autores, e não ao título extenso do trabalho.
* *Evite:* O artigo "Nome do Artigo" \cite{chave} aborda...
* *Prefira:* Segundo Silva (2017), o ensino de programação...