#include <stdio.h>

int main(int argc, char *argv[])
{
    int qnt = atoi(argv[1]);
    int v[qnt];
    int valor = 0;
    int topo = 0;
    
    while (1)
    {   
        scanf("%i", &valor);

        if(valor == -1){
            break;
        }

        if (valor == -2)
        {
            printf("Fila: ");
            for (int i = 0; i < qnt; i++)
            {
                printf("%i ", v[i]);
            }
            break;
        
        }else{

            v[topo] = valor;
            topo++;
            if (topo == qnt)
            {
                topo = 0;
            }
        }
        
    }
    return 0;
}