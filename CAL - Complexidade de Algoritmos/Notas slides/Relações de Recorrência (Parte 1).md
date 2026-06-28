# Relações de Recorrência (Parte 1)

## Conceitos de Relação de Recorrência
* Quando um algoritmo possui chamadas recursivas, ele pode ser descrito por uma recorrência;
* A ferramenta principal para a análise não é o somatório, e sim a Relação de Recorrência;
* Para cada procedimento recursivo, atribui-se uma função de complexidade $T(n)$ desconhecida;

## Exemplo: Pesquisa Binária

![Imagem Embutida 3](./imagens/Rela%C3%A7%C3%B5es%20de%20Recorr%C3%AAncia%20p1/slide_3_img_3.png)

![Imagem Embutida 1](./imagens/Rela%C3%A7%C3%B5es%20de%20Recorr%C3%AAncia%20p1/slide_4_img_1.png)

A complexidade da Pesquisa Binária pode ser dada pela seguinte relação de recorrência:
```math
T(n) = T\left(\frac{n}{2}\right) + O(1)
```

![Imagem Embutida 1](./imagens/Rela%C3%A7%C3%B5es%20de%20Recorr%C3%AAncia%20p1/slide_5_img_1.png)

Podemos reescrever a relação considerando que o custo adicional é uma constante (1):
```math
T(n) = T\left(\frac{n}{2}\right) + 1
```
```math
T(1) = 1
```

![Imagem Embutida 1](./imagens/Rela%C3%A7%C3%B5es%20de%20Recorr%C3%AAncia%20p1/slide_6_img_1.png)

Aplicando o Método da Substituição (ou Expansão), temos:
```math
T(n) = T\left(\frac{n}{2}\right) + 1
```
```math
T\left(\frac{n}{2}\right) = T\left(\frac{n}{2^2}\right) + 1
```
```math
T\left(\frac{n}{2^2}\right) = T\left(\frac{n}{2^3}\right) + 1
```
...

![Imagem Embutida 1](./imagens/Rela%C3%A7%C3%B5es%20de%20Recorr%C3%AAncia%20p1/slide_7_img_1.png)

Expandindo até o $l$-ésimo termo:
```math
T(n) = T\left(\frac{n}{2}\right) + 1
```
```math
T\left(\frac{n}{2}\right) = T\left(\frac{n}{2^2}\right) + 1
```
```math
T\left(\frac{n}{2^2}\right) = T\left(\frac{n}{2^3}\right) + 1
```
...
```math
T\left(\frac{n}{2^{l-1}}\right) = T\left(\frac{n}{2^l}\right) + 1
```

### Análise da Complexidade Final

Assumimos que o caso base é atingido quando o tamanho do problema é 1, logo:
```math
\frac{n}{2^l} = 1
```
```math
n = 2^l
```
```math
l = \log_2 n
```

Retomando a expansão da recorrência:
```math
T(n) = T\left(\frac{n}{2}\right) + 1
```
```math
T\left(\frac{n}{2}\right) = T\left(\frac{n}{2^2}\right) + 1
```
```math
T\left(\frac{n}{2^2}\right) = T\left(\frac{n}{2^3}\right) + 1
```
...
```math
T\left(\frac{n}{2^{l-1}}\right) = T\left(\frac{n}{2^l}\right) + 1
```

Substituindo até o caso base:
```math
T\left(\frac{n}{2^{l-1}}\right) = T\left(\frac{n}{2^{\log_2 n}}\right) + 1
```
```math
T\left(\frac{n}{2^{l-1}}\right) = T(1) + 1
```

Como a expansão ocorre $l$ vezes ($\log_2 n$ vezes), e a cada passo somamos 1:
```math
T(n) = \log_2 n \cdot 1 + 1
```

Logo, a complexidade final é:
```math
O(\log n)
```

## Exercício

Resolva a seguinte relação de recorrência:
```math
T(n) = 16T\left(\frac{n}{4}\right) + n^2
```
