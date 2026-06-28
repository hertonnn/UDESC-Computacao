# Métodos Formais  
*Fundamentos matemáticos para software confiável*  

![imag_mfo](https://github.com/hertonnn/UDESC-Computacao/blob/master/utils/img/img_mfo.jpg?raw=true)

---

A disciplina de **Métodos Formais** introduz os princípios de **especificação, verificação e prova de correção de programas**.  
O foco está em compreender **como provar propriedades sobre software** usando **lógica, indução, e sistemas de tipos**, com auxílio da ferramenta **Coq**.

---

## 📚 Material Base

### **Software Foundations in Coq** — Benjamin C. Pierce et al.  
📖 [Logical Foundations (Volume 1)](https://softwarefoundations.cis.upenn.edu/lf-current/Preface.html)  
Coleção fundamental que ensina a formalizar raciocínios e desenvolver provas mecanizadas em Coq.  
Todos os capítulos do curso seguem ou expandem temas do livro.

---

## 🧠 Conteúdo Programático

| Unidade | Tópico | Descrição / Recursos |
|----------|--------|----------------------|
| **1** | **Indução** | Conceitos básicos de linguagens funcionais. 🔗 [Indução](https://softwarefoundations.cis.upenn.edu/lf-current/Induction.html) |
|  | **Biblioteca Padrão Coq.Init.Peano** | Definições fundamentais sobre números naturais. 🔗 [Documentação Coq.Init.Peano](https://rocq-prover.org/doc/V8.12%2Bbeta1/stdlib/Coq.Init.Peano.html) |
|  | **Biblioteca Coq.Arith.PeanoNat** | Teoremas adicionais e suporte à aritmética. 🔗 [Documentação Coq.Arith.PeanoNat](https://rocq-prover.org/doc/v8.9/stdlib/Coq.Arith.PeanoNat.html) |
|  | **📝 Lista de Exercícios 1 (+ Indução)** | Aplicações práticas de provas indutivas em Coq. |
| **2** | **Polimorfismo** | Abstração de tipos e funções genéricas. 🔗 [Polimorfismo](https://softwarefoundations.cis.upenn.edu/lf-current/Poly.html) |
|  | **📝 Lista de Exercícios 2** | Indução com tipos genéricos e táticas adicionais. |
| **3** | **Listas e Polimorfismo** | Estruturas recursivas e provas sobre listas. 🔗 [Táticas](https://softwarefoundations.cis.upenn.edu/lf-current/Tactics.html) |
|  | **📝 Lista de Exercícios 3** | Provas estruturadas e raciocínio sobre funções de lista. |
| **4** | **Cálculo Lambda** | Fundamentos teóricos da computação funcional. 🔗 [Cálculo Lambda](https://www.youtube.com/watch?v=jvAkNij65W4&t=767s) 📄 Slides e Resumo disponíveis. |
| **5** | **Sistemas de Tipos** | Relação entre tipos, lógica e correção de programas. 📄 Slides da disciplina. 🔗 [Proposition as Types – Philip Wadler (SBLP)](https://homepages.inf.ed.ac.uk/wadler/papers/propositions-as-types/propositions-as-types.pdf) |
| **6** | **Lógica e Proposições Indutivas** | Raciocínio lógico, conectivos e definições indutivas. 🔗 [Lógica](https://softwarefoundations.cis.upenn.edu/lf-current/Logic.html) 🔗 [Proposições Indutivas](https://softwarefoundations.cis.upenn.edu/lf-current/IndProp.html) |
| **7** | **Extração de Programas** | Geração automática de código funcional (Haskell) a partir de provas. |
| **8** | **Tópicos Avançados** | 🔗 [CompCert](https://compcert.org/) — Compilador C verificado formalmente. <br> 🔗 [DeepSpec](https://deepspec.org/) — Projeto de especificação profunda. |
| **9** | **Seminários e Provas** | Apresentações sobre aplicações de métodos formais. |

---

## 🧮 Ferramentas e Ambiente

- **Coq / Rocq** — Prover e verificar teoremas formalmente  
- **VS Code + extensão Coq** *(ou CoqIDE)*  
- **Haskell** — Para extração de programas  
- **Git / GitHub** — Controle de versões e submissão de tarefas  

---

## 💡 Resultados esperados

Ao final da disciplina, o estudante será capaz de:
- Compreender o papel da **lógica formal** na engenharia de software.  
- Modelar programas e propriedades em **Coq**.  
- Provar **correção funcional** e **consistência lógica** de sistemas.  
- Relacionar **teoria (λ-cálculo, tipos)** e **implementação (extração de código)**.

---

## 🌱 Leitura Recomendada

- Pierce, B. C. *Software Foundations* (Volumes 1–3).  
- Wadler, P. *Propositions as Types* (SBLP).  
- Leroy, X. *Formal Verification of a Realistic Compiler (CompCert)*.  

---
## 👨‍🏫 Sobre o Professor

**Cristiano Damiani Vasconcellos**  

- 🎓 Graduação em Ciência da Computação (PUCPR, 1993)  
- 🎓 Mestrado em Engenharia Elétrica e Informática Industrial (UTFPR, 1997)  
- 🎓 Doutorado em Ciência da Computação (UFMG, 2004)  

🔎 Áreas de Interesse: Projeto, implementação e uso de linguagens de programação.  
Foco em **linguagens funcionais**, **sistemas de tipos** e **verificação formal**.  

📌 Recursos:  
- [📂 GitHub (Materiais de aula)](https://github.com/cdvasconcellos/)  
- [▶️ YouTube (Videoaulas)](https://www.youtube.com/channel/UCZ0iWiwN2zy5qB4CevpD89Q)  

📧 **E-mail:** cristiano.vasconcellos@udesc.br  
📄 **Lattes:** [Clique aqui](http://lattes.cnpq.br/7291640788372419)  

---
> 🧭 *“Provar é programar — e programar é provar.”*  
> — Princípio fundamental dos Métodos Formais



## Trabalhos Acadêmicos Relacionados (UDESC)

Abaixo estão alguns trabalhos acadêmicos desenvolvidos na UDESC que se relacionam com o conteúdo desta disciplina:

- **Formalização do Símbolo de Legendre em Coq**
  - *Autor(es)/Ano:* Bruno Rafael dos Santos (Orientadora: Karina G. Roggia) / 2024
  - *Link:* [https://repositorio.udesc.br/entities/publication/1808a890-589e-4f31-bb6f-cfe316b995cd](https://repositorio.udesc.br/entities/publication/1808a890-589e-4f31-bb6f-cfe316b995cd)

