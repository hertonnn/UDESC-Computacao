#include <stdio.h> 
#include <string.h>
#include <stdlib.h>

struct data{
int dia;
int mes;
int ano;
};


struct pessoas {
char nome[30];
char endereco[50];
float salario;
struct data x;
char cargo[20];
};

void mostra_agenda(struct pessoas* a, int x){
for(int i = 0; i < x; i++){
printf("Nome: %s\n", (a[i].nome));
printf("Data de nascimento: %d/%d/%d\n", a[i].x.dia, a[i].x.mes, a[i].x.ano);
printf("Endereço(Bairro): %s\n", (a[i].endereco));
printf("Taxa: %f\n", a[i].salario);
printf("Cargo: %s\n", a[i].cargo);
printf("\n");
}

}

int validar_data(int dia, int mes, int ano){

//return 1 = validado
//return 2 = refazer
    if(ano > 1900 && ano < 2024 ){
        if(mes > 0 && mes < 13){
            if(mes == 1 || mes == 3 || mes == 7 || mes == 5 || mes == 8|| mes == 10|| mes == 12){
                if(dia > 0 && dia <= 31){
                    return 1;
                }else{
                    return 2;
                }

                }else if(mes == 4|| mes == 6|| mes == 9|| mes == 11){
                if(dia > 0 && dia <= 30){
                    return 1;
                }else{
                    return 2;
                }

                }else if(mes == 2){
                if(ano % 4 == 0){
                   if(dia > 0 && dia <= 29){
                    return 1;
                }else{
                    return 2;
                }

                }else{
                    if(dia > 0 && dia <= 28){
                        return 1;
                    }else{
                        return 2;
                    }
                }
                
                }else{
                return 2;
                }
        }else{
            return 2;
        }
                       
    }else{
        return 2;
    }

}


void le_pessoas(struct pessoas* a, int x) {
int i = x - 1;

for(int i = 0; i < x; i++){
int n = 2;
printf("Insira o nome da pessoa %i:\n", i+1);
scanf("%s", a[i].nome);
printf("Insira a data de nascimento:\n");
while( n == 2){

scanf("%d/%d/%d", &(a[i].x.dia), &(a[i].x.mes), &(a[i].x.ano) );
n = validar_data(a[i].x.dia, a[i].x.mes, a[i].x.ano);
if(n == 2){
    printf("Insira uma data valida!\n");
}
}


printf("Insira o bairro(Joinville):\n");
scanf("%s", a[i].endereco);
printf("Insira o taxa:\n");
scanf("%f", &(a[i].salario));
printf("Insira o cargo:\n");
scanf("%s", a[i].cargo);

}

}


void adiciona_pessoa(struct pessoas* a, int x) {
int i = x-1;
printf("Insira o nome da pessoa %i:\n", i+1);
scanf("%s", a[i].nome);
printf("Insira a data de nascimento:\n");
scanf("%d/%d/%d", &(a[i].x.dia), &(a[i].x.mes), &(a[i].x.ano) );
printf("Insira o bairro(Joinville):\n");
scanf("%s", a[i].endereco);
printf("Insira o taxa:\n");
scanf("%f", &(a[i].salario));
printf("Insira o cargo:\n");
scanf("%s", a[i].cargo);

}

void procurar_bairro(struct pessoas *a, int x, char y[30]){

for(int i=0; i<x; i++){

 if( strcmp( (a[i].endereco), y ) == 0){
printf("Nome: %s\n", (a[i].nome));
printf("Data de nascimento: %d/%d/%d\n", a[i].x.dia, a[i].x.mes, a[i].x.ano);
printf("Endereço(cidade): %s\n", (a[i].endereco));
printf("Salario: %f\n", a[i].salario);
printf("Cargo: %s\n", a[i].cargo);
printf("\n");

}else{
    printf("Nenhum dado levantado deste bairro, tente inserir novamente\n");
}

}
}




void remover_pessoa(struct pessoas *a, int *x, char nome[20]){
for(int i=0; i<*x;i++){
    if (strcmp((a[i].nome), nome)==0){
        for(int j = i; j<*x;j++){
            (a[j]) = (a[j+1]);
}
}
}
    (*x)--;
    a = (struct pessoas*)realloc(a, (*x) * sizeof(struct pessoas));
}

int main(){

int num;

printf("Insira o numero de pessoas para add na lista:\n");
scanf("%i", &num);

struct pessoas* a = (struct pessoas*)malloc(num*sizeof(struct pessoas));

le_pessoas(a, num);

int acao;

int ben10 = 0;

while(ben10 == 0){
printf("\n---- MENU ----\n");
printf("O que deseja fazer?\n");
printf("- Insira 1 para inserir uma pessoa\n");
printf("- Insira 2 para remover uma pessoa\n");
printf("- Insira 3 para efetuar o relatório\n");
printf("- Insira 4 para exibir a agenda\n");
printf("- Insira 5 para sair\n");
scanf("%i", &acao);

switch(acao){
case 1:
num++;
a = (struct pessoas*)realloc(a, (num) * sizeof(struct pessoas));
adiciona_pessoa(a, num);
break;

case 2:
char nome[20];
printf("Digite o nome da pessoa que você deseja remover:\n");
scanf("%s", nome);
remover_pessoa(a, &num, nome);
break;

case 3:
char bairro[30];
printf("Digite o bairro que deseja efetuar o relatório:\n");
scanf("%s", bairro);
printf("\n-- Relatório do bairro %s --\n", bairro);
procurar_bairro(a, num, bairro);
break;

case 4:
printf("\n----- AGENDA -----\n");
mostra_agenda(a, num);
break;

case 5:
ben10 = 1;
break;
}

}
printf("\n----- AGENDA FINAL-----\n");
mostra_agenda(a, num);

free(a);

}