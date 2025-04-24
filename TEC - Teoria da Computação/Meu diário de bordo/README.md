
# 📘 Diário de Bordo – Teoria da Computação  

![img_tec2](https://github.com/hertonnn/UDESC_Ciencia_da_Computacao/blob/master/utils/img/img_tec2.jpg)


**Disciplina:** Teoria da Computação  
**Objetivo:** Registro das dúvidas e reflexões durante o estudo dos capítulos do livro *Introduction to the Theory of Computation* – Michael Sipser.  


---

## 📝 Anotações exercícios 

### 🔹 Problema 3.12 – Capítulo 3 (Sipser)
"...quando a máquina está no estado lendo um , a cabeça da máquina salta para a extremidade esquerda da fita..." Não tinha sacado de cara aqui que o ato de reiniciar é, obviamente, voltar até o início da fita.

#### Passo a passo:

Fita inicial:
```txt
... A B C D ...
      ↑  (Cabeçote sobre B)
```
Marca aonde está o cabeçote:
```txt
... A *B C D ...
       ↑
```
Copia tudo uma célua a direita, reseta e anda até a marca:
```txt
... □ A *B C D ...
      ↑     (Cabeçote sobre A)
```

---

## ❓ Dúvidas em Aberto

### 🔹 Problema 3.9(a) – Capítulo 3 (Sipser)  
**Situação:** Não respondida  
**Dúvida:**  
Na resolução do problema, o livro apenas afirma (seguindo o Teorema 2.20) que nenhum autômato de pilha com uma única pilha (1-AP) reconhece a linguagem:  
```
B = { aⁿ bⁿ cⁿ | n ≥ 0 }
```
Em seguida, ele demonstra como um autômato com duas pilhas (2-AP) pode reconhecê-la.

**Questão:**  
Se essa fosse uma questão de prova, eu deveria apenas partir do ponto em que sabemos que um 1-AP não reconhece tal linguagem (citando o Teorema 2.20), ou seria necessário justificar esse fato?

**Possível justificativa para resposta discursiva:**  
> "Um autômato com apenas uma pilha não consegue verificar três quantidades iguais simultaneamente. Isso é provado na Teoria da Computação: a linguagem `{ aⁿ bⁿ cⁿ | n ≥ 0 }` **não é livre de contexto**, e os autômatos de pilha reconhecem exatamente as **linguagens livres de contexto**."

---

### 🔹 Problema 3.9(b) – Capítulo 3 (Sipser)  
**Situação:** Não respondida  
**Dúvida:**  
Ainda tenho incerteza sobre como se dá a **configuração das duas pilhas** na simulação de uma Máquina de Turing (MT) por um autômato de pilha com duas pilhas (2-AP).  

**Questão específica:**  
Se a entrada da MT tiver **comprimento par ou ímpar**, isso altera a lógica da simulação? Afinal, a fita da MT será "dividida" entre as duas pilhas, e o ponto central pode variar dependendo da paridade do comprimento da entrada.

---

### 🔹 Problema 3.10 – Capítulo 3 (Sipser)  
**Situação:** Não respondida  
**Dúvida:**  
Minha dificuldade está relacionada à **marcação da posição do cabeçote** original da MT.  

**Questão específica:**  
Durante a simulação da MT, essa posição precisa ser indicada na fita. No entanto, isso parece exigir **três informações por célula**:
- O símbolo armazenado;
- Uma marca de controle (por exemplo, um estado codificado);
- A posição do cabeçote.

**Observação:**  
A não ser que a posição do cabeçote seja representada de forma implícita (por exemplo, utilizando um símbolo "branco" para marcar a célula sob o cabeçote), não fica claro como isso é tratado de forma prática com apenas uma célula por posição na fita.
