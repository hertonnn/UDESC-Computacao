#include <stdio.h>
#include <string.h>

int converterBin(int valor)
{
    int cont = 0;
    int resto = 0;
    while (valor > 0)
    {
        resto = (valor % 2);
        if (resto == 1)
        {
            cont++;
        }
        valor = valor / 2;
    }
    return cont;
}

int main(int argc, char *argv[])
{

    int cont = 0;
    int valor = atoi(argv[1]);

    cont = converterBin(valor);

    printf("O numero %i possui %i bits em 1\n", valor, cont);
}