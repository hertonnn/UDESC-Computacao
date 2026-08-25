#include <string.h>
#include <stdlib.h>
#include <stdio.h>
#include <time.h>

#define RED "\x1B[31m"
#define BLUE "\x1B[34m"
#define CIANO "\x1B[36m"
#define GRAY "\x1B[30m"
#define RESET "\x1B[0m"
#define YELLOW "\033[0;33m"
#define GREEN "\033[0;32m"
#define PURPLE "\033[0;35m"

struct data
{
    int dia;
    int mes;
    int ano;
    int hora_i;
    int hora_f;
    int min_i;
    int min_f;
};

int validar_data(int dia, int mes, int ano)
{

    // return 1 = validado
    // return 2 = refazer
    if (ano > 1900 && ano < 2024)
    {
        if (mes > 0 && mes < 13)
        {
            if (mes == 1 || mes == 3 || mes == 7 || mes == 5 || mes == 8 || mes == 10 || mes == 12)
            {
                if (dia > 0 && dia <= 31)
                {
                    return 1;
                }
                else
                {
                    return 2;
                }
            }
            else if (mes == 4 || mes == 6 || mes == 9 || mes == 11)
            {
                if (dia > 0 && dia <= 30)
                {
                    return 1;
                }
                else
                {
                    return 2;
                }
            }
            else if (mes == 2)
            {
                if (ano % 4 == 0)
                {
                    if (dia > 0 && dia <= 29)
                    {
                        return 1;
                    }
                    else
                    {
                        return 2;
                    }
                }
                else
                {
                    if (dia > 0 && dia <= 28)
                    {
                        return 1;
                    }
                    else
                    {
                        return 2;
                    }
                }
            }
            else
            {
                return 2;
            }
        }
        else
        {
            return 2;
        }
    }
    else
    {
        return 2;
    }
}

int validar_hora(int hora, int min)
{

    if (hora >= 0 && hora < 24)
    {
        if (min >= 0 && min < 60)
        {
            return 1;
        }
        else
        {
            return 2;
        }
    }
    else
    {
        return 2;
    }
}

struct sala
{

    int sala;
    int cadeiras;
    int mesas;
    int projetores;
    int quadros;
    int pcs;
};

struct ambientes
{
    char nome[15];
    struct sala x;
};

struct agenda
{
    char nome[15];
    struct data z;
    struct sala y;
};

void busca_sala(int sala, int tamanho, int *vetor_sala, int quant_salas, struct ambientes *a)
{
    char proj;
    char quad;
    int qntd_pcs;
    char resp_aud;
    int contador_disponivel = 0;

    switch (sala)
    {
    case 1:

        contador_disponivel = 0;
        printf("\nPrecisa de projetor(S/N)\n");
        scanf(" %c", &proj);
        getchar();
        printf("\n");

        for (int i = 0; i < quant_salas; i++)
        {
            if ((vetor_sala[i]) == 1 || (vetor_sala[i]) == 7 || (vetor_sala[i]) == 8 || (vetor_sala[i]) == 9 || (vetor_sala[i]) == 10)
            {
                if (tamanho <= a[i].x.cadeiras)
                {
                    if (proj == 'S' && (a[i].x.projetores) == 1)
                    {
                        contador_disponivel++;
                        printf("Sala[%i]: %s %i proj: %i cap: %i pcs: %i\n", i, a[i].nome, a[i].x.sala, a[i].x.projetores, a[i].x.cadeiras, a[i].x.pcs);
                    }
                    else if (proj == 'N')
                    {
                        contador_disponivel++;
                        printf("Sala[%i]: %s %i proj: %i cap: %i pcs: %i\n", i, a[i].nome, a[i].x.sala, a[i].x.projetores, a[i].x.cadeiras, a[i].x.pcs);
                    }
                }
            }
        }

        if (contador_disponivel == 0)
        {
            printf(RED);
            printf("Nenhuma sala disponivel!\n");
            printf(RESET);
        }

        break;

    case 2:

        contador_disponivel = 0;
        printf("\nPrecisa de projetor(S/N)\n");
        scanf(" %c", &proj);
        getchar();

        printf("Gostaria de quantos computadores?\n");
        scanf("%i", &qntd_pcs);
        printf("\n");

        for (int i = 0; i < quant_salas; i++)
        {
            if (vetor_sala[i] == 2)
            {
                if (tamanho <= a[i].x.cadeiras)
                {
                    if (qntd_pcs <= a[i].x.pcs)
                    {
                        if (proj == 'S' && (a[i].x.projetores) == 1)
                        {
                            contador_disponivel++;
                            printf("Sala[%i]: %s %i proj: %i cap: %i pcs: %i\n", i, a[i].nome, a[i].x.sala, a[i].x.projetores, a[i].x.cadeiras, a[i].x.pcs);
                        }
                        else if (proj == 'N')
                        {
                            contador_disponivel++;
                            printf("Sala[%i]: %s %i proj: %i cap: %i pcs: %i\n", i, a[i].nome, a[i].x.sala, a[i].x.projetores, a[i].x.cadeiras, a[i].x.pcs);
                        }
                    }
                }
            }
        }

        if (contador_disponivel == 0)
        {
            printf(RED);
            printf("Nenhuma sala disponivel!\n");
            printf(RESET);
        }

        break;

    case 3:

        contador_disponivel = 0;
        printf("\nPrecisa de projetor(S/N)\n");
        scanf(" %c", &proj);
        getchar();

        printf("\nPrecisa de quadro(S/N)\n");
        scanf(" %c", &quad);
        getchar();
        printf("\n");

        for (int i = 0; i < quant_salas; i++)
        {
            if (vetor_sala[i] == 4)
            {
                if (tamanho <= a[i].x.cadeiras)
                {
                    if (proj == 'S' && (a[i].x.projetores) == 1)
                    {
                        if (quad == 'S' && a[i].x.quadros == 1)
                        { // precisa ter projetor e quadro
                            contador_disponivel++;

                            printf("Sala[%i]: %s %i proj: %i cap: %i pcs: %i quad: %i\n", i, a[i].nome, a[i].x.sala, a[i].x.projetores, a[i].x.cadeiras, a[i].x.pcs, a[i].x.quadros);
                        }
                        else if (quad == 'N')
                        { // precisa ter quadro mas nao precisa ter projetor
                            contador_disponivel++;

                            printf("Sala[%i]: %s %i proj: %i cap: %i pcs: %i quad: %i\n", i, a[i].nome, a[i].x.sala, a[i].x.projetores, a[i].x.cadeiras, a[i].x.pcs, a[i].x.quadros);
                        }
                    }
                    else if (proj == 'N')
                    {
                        if (quad == 'S' && a[i].x.quadros == 1)
                        { // nao precisa ter projetor mas precisa de quadro
                            contador_disponivel++;

                            printf("Sala[%i]: %s %i proj: %i cap: %i pcs: %i quad: %i\n", i, a[i].nome, a[i].x.sala, a[i].x.projetores, a[i].x.cadeiras, a[i].x.pcs, a[i].x.quadros);
                        }
                        else if (quad == 'N')
                        { // nao precisa nem de projetor nem de quadro
                            contador_disponivel++;

                            printf("Sala[%i]: %s %i proj: %i cap: %i pcs: %i quad: %i\n", i, a[i].nome, a[i].x.sala, a[i].x.projetores, a[i].x.cadeiras, a[i].x.pcs, a[i].x.quadros);
                        }
                    }
                }
            }
        }

        if (contador_disponivel == 0)
        {
            printf(RED);
            printf("Nenhuma sala disponivel!\n");
            printf(RESET);
        }

        break;

    case 4:

        printf("\n");
        contador_disponivel = 0;
        for (int i = 0; i < quant_salas; i++)
        {
            if (vetor_sala[i] == 5)
            {
                if (tamanho <= a[i].x.cadeiras)
                {
                    contador_disponivel++;
                    printf("Sala[%i]: %s %i proj: %i cap: %i pcs: %i quad: %i\n", i, a[i].nome, a[i].x.sala, a[i].x.projetores, a[i].x.cadeiras, a[i].x.pcs, a[i].x.quadros);
                }
            }
        }

        if (contador_disponivel == 0)
        {
            printf(RED);
            printf("Nenhuma sala disponivel!\n");
            printf(RESET);
        }

        break;

    case 5:

        contador_disponivel = 0;
        printf("\nPrecisa de projetor(S/N)\n");
        scanf(" %c", &proj);
        getchar();

        printf("\nPrecisa de quadro(S/N)\n");
        scanf(" %c", &quad);
        getchar();
        printf("\n");

        for (int i = 0; i < quant_salas; i++)
        {
            if (vetor_sala[i] == 3)
            {
                if (tamanho <= a[i].x.cadeiras)
                {
                    if (proj == 'S' && (a[i].x.projetores) == 1)
                    {
                        if (quad == 'S' && a[i].x.quadros == 1)
                        { // precisa ter projetor e quadro
                            contador_disponivel++;

                            printf("Sala[%i]: %s %i proj: %i cap: %i pcs: %i quad: %i\n", i, a[i].nome, a[i].x.sala, a[i].x.projetores, a[i].x.cadeiras, a[i].x.pcs, a[i].x.quadros);
                        }
                        else if (quad == 'N')
                        { // precisa ter quadro mas nao precisa ter projetor
                            contador_disponivel++;

                            printf("Sala[%i]: %s %i proj: %i cap: %i pcs: %i quad: %i\n", i, a[i].nome, a[i].x.sala, a[i].x.projetores, a[i].x.cadeiras, a[i].x.pcs, a[i].x.quadros);
                        }
                    }
                    else if (proj == 'N')
                    {
                        if (quad == 'S' && a[i].x.quadros == 1)
                        { // nao precisa ter projetor mas precisa de quadro
                            contador_disponivel++;

                            printf("Sala[%i]: %s %i proj: %i cap: %i pcs: %i quad: %i\n", i, a[i].nome, a[i].x.sala, a[i].x.projetores, a[i].x.cadeiras, a[i].x.pcs, a[i].x.quadros);
                        }
                        else if (quad == 'N')
                        { // nao precisa nem de projetor nem de quadro
                            contador_disponivel++;

                            printf("Sala[%i]: %s %i proj: %i cap: %i pcs: %i quad: %i\n", i, a[i].nome, a[i].x.sala, a[i].x.projetores, a[i].x.cadeiras, a[i].x.pcs, a[i].x.quadros);
                        }
                    }
                }
            }
        }

        if (contador_disponivel == 0)
        {
            printf(RED);
            printf("Nenhuma sala disponivel!\n");
            printf(RESET);
        }

        break;

    case 6:

        contador_disponivel = 0;

        printf("\nPrecisa de quadro(S/N)\n");
        scanf(" %c", &quad);
        getchar();

        printf("Gostaria de quantos computadores?\n");
        scanf("%i", &qntd_pcs);
        printf("\n");

        for (int i = 0; i < quant_salas; i++)
        {
            if (vetor_sala[i] == 6)
            {
                if (tamanho <= a[i].x.cadeiras)
                {
                    if (qntd_pcs <= a[i].x.pcs)
                    {
                        if (quad == 'S' && a[i].x.quadros == 1)
                        { // precisa ter os pcs e o quadro
                            contador_disponivel++;

                            printf("Sala[%i]: %s %i proj: %i cap: %i pcs: %i quad: %i\n", i, a[i].nome, a[i].x.sala, a[i].x.projetores, a[i].x.cadeiras, a[i].x.pcs, a[i].x.quadros);
                        }
                        else if (quad == 'N')
                        { // precisa ter os pcs mas nao o quadro
                            contador_disponivel++;

                            printf("Sala[%i]: %s %i proj: %i cap: %i pcs: %i quad: %i\n", i, a[i].nome, a[i].x.sala, a[i].x.projetores, a[i].x.cadeiras, a[i].x.pcs, a[i].x.quadros);
                        }
                    }
                }
            }
        }

        if (contador_disponivel == 0)
        {
            printf(RED);
            printf("Nenhuma sala disponivel!\n");
            printf(RESET);
        }

        break;
    }
}

void adicionar_agenda(struct ambientes *a, struct agenda *b, int num_salas, int sala, int cont)
{
    for (int i = 0; i < num_salas; i++)
    {
        if (a[i].x.sala == sala)
        {
            strcpy(b[cont - 1].nome, a[i].nome);
            b[cont - 1].y.sala = a[i].x.sala;
            b[cont - 1].y.cadeiras = a[i].x.cadeiras;
            b[cont - 1].y.mesas = a[i].x.mesas;
            b[cont - 1].y.projetores = a[i].x.projetores;
            b[cont - 1].y.quadros = a[i].x.quadros;
            b[cont - 1].y.pcs = a[i].x.pcs;
            printf(GREEN);
            printf("Sala agendada com sucesso!\n");
            printf(RESET);
        }
    }
}

int mostrar_sala(struct ambientes *a, struct agenda *c, struct agenda *b, int num_salas, int sala, int cont, int contc, int *point)
{

    char reserva;
    int verifica_b = 0;
    int verifica_c = 0;
    for (int i = 0; i < num_salas; i++)
    {
        if (a[i].x.sala == sala)
        {
            printf("\n*** Informacoes do ambiente %i ***\n", a[i].x.sala);
            printf("Local: %s %i\n", a[i].nome, a[i].x.sala);
            printf("Mesas: %i\n", a[i].x.mesas);
            printf("Cadeiras: %i\n", a[i].x.cadeiras);
            printf("Pcs: %i\n", a[i].x.pcs);
            printf("Projetores: %i\n", a[i].x.projetores);
            printf("Quadros: %i\n", a[i].x.quadros);

            printf("\nVoce gostaria de reservar?(S/N)\n");
            scanf(" %c", &reserva);
            getchar();
            printf("\n");

            if (reserva == 'S')
            {

                return 1;
            }
            else
            {
                return 0;
            }
        }
    }
    return 0;
}

void mostrar_agenda(struct agenda *b, int cont)
{

    for (int i = 0; i < cont; i++)
    {
        printf("\n --- Ambiente %i agendado ---\n", b[i].y.sala);
        printf("Local: %s %i\n", b[i].nome, b[i].y.sala);
        printf("Mesas: %i\n", b[i].y.mesas);
        printf("Cadeiras: %i\n", b[i].y.cadeiras);
        printf("Pcs: %i\n", b[i].y.pcs);
        printf("Projetores: %i\n", b[i].y.projetores);
        printf("Quadros: %i\n", b[i].y.quadros);
        printf("Data: %i/%i/%i\n", b[i].z.dia, b[i].z.mes, b[i].z.ano);
        printf("Horario: %i:%i - %i:%i", b[i].z.hora_i, b[i].z.min_i, b[i].z.hora_f, b[i].z.min_f);
        printf("\n");
    }
}

void printa_sala(struct ambientes *a, int num_salas, int *tipo_sala)
{

    printf("\n*** Salas Disponiveis ***\n");
    for (int i = 0; i < num_salas; i++)
    {
        switch (tipo_sala[i])
        {

        case 1:
        case 7:
        case 8:
        case 9:
        case 10:
            printf(YELLOW);
            printf("Sala[%i]: %s %i Infos:(proj:%i cap:%i pcs:%i quad:%i)\n", i, a[i].nome, a[i].x.sala, a[i].x.projetores, a[i].x.cadeiras, a[i].x.pcs, a[i].x.quadros);
            printf(RESET);
            break;

        case 2:
            printf(BLUE);
            printf("Sala[%i]: %s %i Infos:(proj:%i cap:%i pcs:%i quad:%i)\n", i, a[i].nome, a[i].x.sala, a[i].x.projetores, a[i].x.cadeiras, a[i].x.pcs, a[i].x.quadros);
            printf(RESET);
            break;

        case 3:
            printf(GREEN);
            printf("Sala[%i]: %s %i Infos:(proj:%i cap:%i pcs:%i quad:%i)\n", i, a[i].nome, a[i].x.sala, a[i].x.projetores, a[i].x.cadeiras, a[i].x.pcs, a[i].x.quadros);
            printf(RESET);
            break;

        case 4:
            printf(CIANO);
            printf("Sala[%i]: %s %i Infos:(proj:%i cap:%i pcs:%i quad:%i)\n", i, a[i].nome, a[i].x.sala, a[i].x.projetores, a[i].x.cadeiras, a[i].x.pcs, a[i].x.quadros);
            printf(RESET);
            break;

        case 5:
            printf(RED);
            printf("Sala[%i]: %s %i Infos:(proj:%i cap:%i pcs:%i quad:%i)\n", i, a[i].nome, a[i].x.sala, a[i].x.projetores, a[i].x.cadeiras, a[i].x.pcs, a[i].x.quadros);
            printf(RESET);
            break;

        case 6:
            printf(PURPLE);
            printf("Sala[%i]: %s %i Infos:(proj:%i cap:%i pcs:%i quad:%i)\n", i, a[i].nome, a[i].x.sala, a[i].x.projetores, a[i].x.cadeiras, a[i].x.pcs, a[i].x.quadros);
            printf(RESET);
            break;
        }
    }
}

// Função que verifica se o numero da sala gerado já existe
int verifica_sala(struct ambientes *a, int sala, int num_salas)
{
    for (int i = 0; i < num_salas; i++)
    {
        if (sala == a[i].x.sala)
        {
            return 1;
        }
    }
    return 2;
}
// função para reordenar sala antes de remover
void remov_ambiente(struct ambientes *a, int *num_salas, int remover, int *tipo_sala)
{
    int index_remover = -1;

    // Encontrar o índice da sala a ser removida
    for (int i = 0; i < (*num_salas); i++)
    {
        if (a[i].x.sala == remover)
        {
            index_remover = i;
        }
    }

    // Se a sala não foi encontrada, sair da função
    if (index_remover == -1)
    {
        printf("Sala não encontrada.\n");
        return;
    }

    // Mover todos os elementos à direita da sala a ser removida uma posição para a esquerda
    for (int i = index_remover; i < (*num_salas) - 1; i++)
    {
        a[i] = a[i + 1];
        tipo_sala[i] = tipo_sala[i + 1];
    }

    // Decrementar o número de salas
    (*num_salas)--;
}

void remov_da_agenda(struct ambientes *a, struct agenda *b, int *cont, int sala)
{
    for (int i = 0; i < (*cont); i++)
    {
        if (b[i].y.sala == sala)
        {
            for (int j = i; j < (*cont) - 1; j++)
            {
                b[j] = b[j + 1];
            }
            (*cont)--;
        }
    }
}

int compara_agenda(struct agenda *b, int cont, int sala, int dia, int mes, int ano, int hora_i, int min_i, int hora_f, int min_f)
{

    int contador = 0;
    // return 1 ja esta agendado
    // return 0 nao esta agendado, logo pode adicionar
    for (int i = 0; i < (cont - 1); i++)
    {
        if (b[i].y.sala == sala)
        {
            if ((dia == b[i].z.dia) && (mes == b[i].z.mes) && (ano == b[i].z.ano))
            { 
                if((b[i].z.hora_i < hora_i && b[i].z.hora_f > hora_i)||(b[i].z.hora_i < hora_f && b[i].z.hora_f > hora_f)){

                contador++;
            } else if((b[i].z.hora_f == hora_i && b[i].z.min_f > min_i)||(b[i].z.hora_i == hora_f && b[i].z.min_i < min_f )){
                contador++;
            }
            }
        }
    }

    if (contador > 0)
    {
        return 1;
    }
    else
    {
        return 0;
    }
}

int main()
{
    time_t t;
    srand((unsigned)time(&t));

    int inicio, selecao, sala, user, menu, cadeiras, salas, remover_sala;
    char cpf[12];
    char senha[40];
    int inicializacao = 1;
    char projetor;
    int num_salas = 40;
    int cont = 0;
    int contc = 0;

    char cpf_admin[12] = "11100011100";
    char senha_admin[40] = "54321";

    char cpf_usuario[12] = "66655566655";
    char senha_usuario[40] = "12345";

    char cpf_aluno[12] = "33344433344";
    char senha_aluno[40] = "98765";

    struct agenda *b = NULL;
    struct agenda *c = NULL;

    struct ambientes *a = (struct ambientes *)malloc(num_salas * sizeof(struct ambientes));

    int *tipo_sala;
    tipo_sala = malloc(sizeof(int) * num_salas);

    // gerando as salas
    for (int i = 0; i < num_salas; i++)
    {
        tipo_sala[i] = (rand() % 10) + 1;
        switch (tipo_sala[i])
        {

        case 1:
        case 7:
        case 8:
        case 9:
        case 10:
            int sala_num = 1;
            strcpy(a[i].nome, "Sala de Aula");
            // repete ate gerar um valor de sala que ainda não existe
            while (sala_num == 1)
            {
                a[i].x.sala = (rand() % 100) + 1;
                sala_num = verifica_sala(a, a[i].x.sala, i);
            }
            a[i].x.cadeiras = (rand() % 10) + 25;
            a[i].x.mesas = a[i].x.cadeiras;
            a[i].x.quadros = 1;
            a[i].x.projetores = (rand() % 2);
            a[i].x.pcs = a[i].x.projetores;
            break;

        case 2:
            int lab_num = 1;
            strcpy(a[i].nome, "Laboratório");
            while (lab_num == 1)
            {
                a[i].x.sala = (rand() % 100) + 100;
                lab_num = verifica_sala(a, a[i].x.sala, i);
            }
            a[i].x.mesas = (rand() % 10) + 25;
            a[i].x.cadeiras = (a[i].x.mesas) * 2;
            a[i].x.quadros = 1;
            a[i].x.pcs = a[i].x.mesas;
            a[i].x.projetores = (rand() % 2);
            break;

        case 3:
            int aud_num = 1;
            strcpy(a[i].nome, "Auditório");
            while (aud_num == 1)
            {
                a[i].x.sala = (rand() % 100) + 200;
                aud_num = verifica_sala(a, a[i].x.sala, i);
            }
            a[i].x.projetores = (rand() % 2);
            a[i].x.pcs = a[i].x.projetores;
            a[i].x.cadeiras = (rand() % 20) + 80;
            a[i].x.quadros = (rand() % 2);
            a[i].x.mesas = 1;
            break;

        case 4:
            int reu_num = 1;
            strcpy(a[i].nome, "Sala de Reuniao");
            while (reu_num == 1)
            {
                a[i].x.sala = (rand() % 100) + 300;
                reu_num = verifica_sala(a, a[i].x.sala, i);
            }
            a[i].x.projetores = (rand() % 2);
            a[i].x.pcs = a[i].x.projetores;
            a[i].x.mesas = (rand() % 1) + 1;
            a[i].x.cadeiras = (rand() % 10) + 10;
            a[i].x.quadros = (rand() % 2);
            break;

        case 5:
            int prof_num = 1;
            strcpy(a[i].nome, "Sala Professor");
            while (prof_num == 1)
            {
                a[i].x.sala = (rand() % 100) + 400;
                prof_num = verifica_sala(a, a[i].x.sala, i);
            }
            a[i].x.mesas = 1;
            a[i].x.pcs = 1;
            a[i].x.cadeiras = (rand() % 3) + 2;
            a[i].x.quadros = 1;
            a[i].x.projetores = 0;
            break;

        case 6:
            int sec_num = 1;
            strcpy(a[i].nome, "Secretaria");
            while (sec_num == 1)
            {
                a[i].x.sala = (rand() % 100) + 500;
                sec_num = verifica_sala(a, a[i].x.sala, i);
            }
            a[i].x.mesas = (rand() % 2) + 1;
            a[i].x.pcs = a[i].x.mesas;
            a[i].x.cadeiras = (rand() % 6) + 1;
            a[i].x.quadros = (rand() % 2);
            a[i].x.projetores = 0;
            break;
        }
    }

    while (inicializacao == 1)
    {
        printf(CIANO);
        printf("\n*** BEM VINDO SISTEMA DE AGENDAMENTO ***\n");
        printf(RESET);
        int login = 1;

        while (login == 1)
        {
            printf("CPF:\n");
            scanf(" %s", cpf);
            getchar();
            printf("Senha:\n");
            scanf(" %s", senha);
            getchar();

            // analise do tipo de usuario
            if ((strcmp(cpf, cpf_admin)) == 0 && (strcmp(senha, senha_admin) == 0))
            {
                printf(GREEN);
                printf("\nBem vindo ADM!\n");
                printf(RESET);
                user = 0;
                login++;
            }

            else if ((strcmp(cpf, cpf_usuario)) == 0 && (strcmp(senha, senha_usuario) == 0))
            {
                printf(GREEN);
                printf("\nBem vindo professor!\n");
                printf(RESET);
                user = 1;
                login++;
            }
            else if ((strcmp(cpf, cpf_aluno)) == 0 && (strcmp(senha, senha_aluno) == 0))
            {
                printf(GREEN);
                printf("\nBem vindo aluno!\n");
                printf(RESET);
                user = 2;
                login++;
            }

            else
            {
                printf(RED);
                printf("Usuário e ou senha incorretos!\n");
                printf(RESET);
            }
        }
        switch (user)
        {

        case 0:
            // inicio do adm
            int adm = 1;
            while (adm == 1)
            {

                printf(CIANO);
                printf("\n*** MENU INICIAL ***\n");
                printf(RESET);
                printf("Digite (1) para consultar as salas\n");
                printf("Digite (2) para ver seus agendamentos\n");
                printf("Digite (3) para trocar de usuario\n");
                printf("Digite (4) para finalizar o programa\n");
                scanf("%i", &inicio);
                switch (inicio)
                {
                case 1:

                    printa_sala(a, num_salas, tipo_sala);
                    printf(CIANO);
                    printf("\n*** MENU DE BUSCA ***\n");
                    printf(RESET);
                    printf("Digite (1) para filtrar as salas \n");
                    printf("Digite (2) para selecionar uma sala \n");
                    printf("Digite (3) para adicionar uma sala\n");
                    printf("Digite (4) para remover uma sala\n");
                    scanf("%i", &selecao);

                    switch (selecao)
                    {
                    case 1:
                        printf(CIANO);
                        printf("\n*** MENU DE FILTRAGEM ***\n");
                        printf(RESET);
                        printf("Insira o numero do ambiente desejado:\n");
                        printf("-- Sala de Aula (1) ---------\n");
                        printf("-- Laboratorio (2) ----------\n");
                        printf("-- Sala de Reunião (3) ------\n");
                        printf("-- Sala de Professor (4) ----\n");
                        printf("-- Auditório (5) ------------\n");
                        printf("-- Secretaria (6) -----------\n");
                        scanf("%i", &salas);

                        printf("Insira a capacidade de pessoas que procura:\n");
                        scanf("%i", &cadeiras);

                        busca_sala(salas, cadeiras, tipo_sala, num_salas, a);
                        break;

                    case 2:
                        printf("Qual sala você deseja?(selecione o numero)\n");
                        scanf("%i", &sala);
                        /*abre especificacoes da sala*/
                        int agendar_sim_nao;

                        agendar_sim_nao = mostrar_sala(a, c, b, num_salas, sala, contc, cont, &contc);
                        if (agendar_sim_nao == 0)
                        {

                            printf(RED);
                            printf("Nao foi agendado e/ou sala não disponivel!\n");
                            printf(RESET);
                        }
                        else
                        {
                            contc++;
                            c = (struct agenda *)realloc(c, (contc) * sizeof(struct agenda));

                            int val_data = 2;
                            while (val_data == 2)
                            {
                                printf("Qual data que você deseja agendar a sala(dd/mm/aaaa): \n");
                                scanf("%i/%i/%i", &(c[contc - 1].z).dia, &(c[contc - 1].z).mes, &(c[contc - 1].z).ano);
                                
                                val_data = validar_data((c[contc - 1].z).dia, (c[contc - 1].z).mes, (c[contc - 1].z).ano);
                            }

                    
                            int possivel = 2;

                            while (possivel == 2)
                            {
                                int verifica_hora_f = 2;
                                int verifica_hora_i = 2;
                                while (verifica_hora_i == 2)
                                {
                                    printf("Qual a hora que você deseja entrar na sala?(hh:mn)\n");
                                    scanf("%i:%i", &c[contc - 1].z.hora_i, &c[contc - 1].z.min_i);
                                    verifica_hora_i = validar_hora(c[contc - 1].z.hora_i, c[contc - 1].z.min_i);
                                }

                                while (verifica_hora_f == 2)
                                {
                                    printf("Qual a hora que você deseja sair da sala?(hh:mn)\n");
                                    scanf("%i:%i", &c[contc - 1].z.hora_f, &c[contc - 1].z.min_f);
                                    verifica_hora_f = validar_hora(c[contc - 1].z.hora_f, c[contc - 1].z.min_f);
                                }

                                if (c[contc - 1].z.hora_i > c[contc - 1].z.hora_f)
                                {
                                    printf(RED);
                                    printf("Hora invalida\n");
                                    printf(RESET);
                                    possivel = 2;
                                }
                                else if ((c[contc - 1].z.hora_i == c[contc - 1].z.hora_f) && (c[contc - 1].z.min_i > c[contc - 1].z.min_f))
                                {
                                    printf(RED);
                                    printf("Hora invalida\n");
                                    printf(RESET);
                                    possivel = 2;
                                }
                                else
                                {
                                    possivel++;
                                }
                            }

                            int val_agenda_b = compara_agenda(b, cont + 1, sala, (c[contc - 1].z).dia, (c[contc - 1].z).mes, (c[contc - 1].z).ano, c[contc - 1].z.hora_i, c[contc - 1].z.min_i, c[contc - 1].z.hora_f, c[contc - 1].z.min_f);

                            int val_agenda_c = compara_agenda(c, contc, sala, (c[contc - 1].z).dia, (c[contc - 1].z).mes, (c[contc - 1].z).ano, c[contc - 1].z.hora_i, c[contc - 1].z.min_i, c[contc - 1].z.hora_f, c[contc - 1].z.min_f);

                            if (val_agenda_b == 0 && val_agenda_c == 0)
                            {
                                adicionar_agenda(a, c, num_salas, sala, contc);
                            }
                            else
                            {
                                contc--;
                                c = (struct agenda *)realloc(c, (contc) * sizeof(struct agenda));

                                printf(RED);
                                printf("Nao foi agendado e/ou sala não disponivel!\n");
                                printf(RESET);
                            }
                        }

                        break;
                    case 3:
                        // adiciona uma sala no struct
                        int sala_add;
                        printf("Qual ambiente você gostaria de adicionar?\n");
                        printf("-- Sala de Aula (1) ---------\n");
                        printf("-- Laboratorio (2) ----------\n");
                        printf("-- Auditório (3) ------------\n");
                        printf("-- Sala de Reunião (4) ------\n");
                        printf("-- Sala de Professor (5) ----\n");
                        printf("-- Secretaria (6) -----------\n");
                        scanf("%i", &sala_add);
                        num_salas++;

                        a = (struct ambientes *)realloc(a, sizeof(struct ambientes) * num_salas);

                        tipo_sala = realloc(tipo_sala, sizeof(int) * num_salas);

                        tipo_sala[num_salas - 1] = sala_add;

                        switch (sala_add)
                        {
                        case 1:
                            strcpy(a[num_salas - 1].nome, "Sala de Aula");
                            break;
                        case 2:
                            strcpy(a[num_salas - 1].nome, "Laboratorio");
                            break;
                        case 4:
                            strcpy(a[num_salas - 1].nome, "Sala de Reunião");
                            break;
                        case 5:
                            strcpy(a[num_salas - 1].nome, "Sala de Professor");
                            break;
                        case 3:
                            strcpy(a[num_salas - 1].nome, "Auditório");
                            break;
                        case 6:
                            strcpy(a[num_salas - 1].nome, "Secretaria");
                            break;
                        }

                        int dig_num = 1;

                        while (dig_num == 1)
                        {
                            printf("Digite o numero da sala:\n");
                            scanf("%i", &a[num_salas - 1].x.sala);
                            dig_num = verifica_sala(a, a[num_salas - 1].x.sala, num_salas - 1);
                        }
                        printf("Quantas mesas tem nessa sala?\n");
                        scanf("%i", &a[num_salas - 1].x.mesas);
                        printf("Quantos computadores tem nessa sala?\n");
                        scanf("%i", &a[num_salas - 1].x.pcs);
                        printf("Quantas cadeiras tem nessa sala?\n");
                        scanf("%i", &a[num_salas - 1].x.cadeiras);
                        printf("Quantos quadros tem nessa sala?\n");
                        scanf("%i", &a[num_salas - 1].x.quadros);
                        printf("Tem projetor nessa sala?(S/N)\n");
                        char project;
                        scanf(" %c", &project);
                        getchar();
                        if (project == 'S')
                        {
                            a[num_salas - 1].x.projetores = 1;
                        }
                        else
                        {
                            a[num_salas - 1].x.projetores = 0;
                        }
                        break;

                    case 4:
                        // remove uma sala do struct
                        int remover;
                        int ageb = 0, agec = 0;
                        printf("Qual sala você deseja remover?\n");
                        scanf("%i", &remover);
                        remov_ambiente(a, &num_salas, remover, tipo_sala);
                        a = (struct ambientes *)realloc(a, num_salas * sizeof(struct ambientes));
                        // removendo a sala dos agendamentos caso ela tenha sido agendada
                        for (int i = 0; i < contc; i++)
                        {
                            if (c[i].y.sala == remover)
                            {
                                agec++;
                            }
                        }
                        if (agec > 0)
                        {
                            remov_da_agenda(a, c, &contc, remover);
                            c = (struct agenda *)realloc(c, contc * sizeof(struct agenda));
                        }
                        for (int i = 0; i < cont; i++)
                        {
                            if (b[i].y.sala == remover)
                            {
                                ageb++;
                            }
                        }
                        if (ageb > 0)
                        {
                            remov_da_agenda(a, b, &cont, remover);
                            b = (struct agenda *)realloc(b, cont * sizeof(struct agenda));
                        }

                        break;
                    }

                    break;

                case 2:

                    printf(CIANO);
                    printf("\n*** AGENDA PESSOAL ***\n");
                    printf(RESET);
                    if (contc == 0)
                    {
                        printf(RED);
                        printf("Nenhuma sala agendada ainda!\n");
                        printf(RESET);
                    }
                    else
                    {
                        printf(GREEN);
                        mostrar_agenda(c, contc);
                        printf(RESET);

                        printf(CIANO);
                        printf("\n*** MENU DA AGENDA ***");
                        printf(RESET);

                        printf("\nDigite (1) para remover um agendamento\n");
                        printf("Digite (2) para voltar ao menu inicial\n");

                        scanf("%i", &remover_sala);
                        if (remover_sala == 1)
                        {
                            int num_sala_remover, dia_remover, mes_remover, ano_remover, hora_remover, minuto_remover;
                            printf("Insira o numero do ambiente que deseja remover\n");
                            scanf("%i", &num_sala_remover);
                            printf("Qual o data do agendamento(dd/mm/aaaa): \n");
                            scanf("%i/%i/%i", &dia_remover, &mes_remover, &ano_remover);
                            printf("Qual a hora de inicio do agendamento(hh:mn): \n");
                            scanf("%i:%i", &hora_remover, &minuto_remover);

                            // inicia o processo de remocao da sala da agenda
                            int index_remover = -1;

                            // Encontrar o índice da sala a ser removida
                            for (int i = 0; i < contc; i++)
                            {
                                if (c[i].y.sala == num_sala_remover && c[i].z.dia == dia_remover && c[i].z.mes == mes_remover && c[i].z.ano == ano_remover && c[i].z.hora_i == hora_remover && c[i].z.min_i == minuto_remover)
                                {
                                    index_remover = i;
                                }
                            }

                            // Se a sala não foi encontrada
                            if (index_remover == -1)
                            {
                                printf(RED);
                                printf("\nSala não encontrada!\n");
                                printf(RESET);
                            }

                            // Decrementar o número de salas SOMENTE se o numero de agendamentos for maior que 0
                            if (contc > 0 && index_remover != -1)
                            {
                                // Mover todos os elementos à direita da sala a ser removida uma posição para a esquerda
                                for (int i = index_remover; i < (contc - 1); i++)
                                {
                                    c[i] = c[i + 1];
                                }

                                contc--;

                                // Realocando a struct agendas com uma posicao a menos
                                c = (struct agenda *)realloc(c, contc * sizeof(struct agenda));

                                printf(GREEN);
                                printf("\nAmbiente removido com sucesso!\n");
                                printf(RESET);
                            }
                        }
                    }

                    break;

                case 3:
                    // trocara de conta pelo menu principal
                    adm++;
                    break;

                case 4:

                    adm++;
                    inicializacao++;
                    break;

                default:
                    printf(RED);
                    printf("Ação invalida!\n");
                    printf(RESET);
                    break;
                }

                // Fim do adm
            }

            break;
            // fim do adm

        case 1:
            // inicio do professor
            int prof = 1;
            while (prof == 1)
            {
                printf(CIANO);
                printf("\n*** MENU INICIAL ***\n");
                printf(RESET);
                printf("Digite (1) para consultar as salas\n");
                printf("Digite (2) para ver seus agendamentos\n");
                printf("Digite (3) para trocar de usuario\n");
                printf("Digite (4) para finalizar o programa\n");
                scanf("%i", &inicio);
                switch (inicio)
                {
                case 1:

                    printa_sala(a, num_salas, tipo_sala);
                    printf(CIANO);
                    printf("\n*** MENU DE BUSCA ***\n");
                    printf(RESET);
                    printf("Digite 1 para filtrar as salas \n");
                    printf("Digite 2 para selecionar uma sala \n");
                    scanf("%i", &selecao);

                    switch (selecao)
                    {
                    case 1:
                        printf(CIANO);
                        printf("\n*** MENU DE FILTRAGEM ***\n");
                        printf(RESET);
                        printf("Insira o numero do ambiente desejado:\n");
                        printf("-- Sala de Aula (1) ---------\n");
                        printf("-- Laboratorio (2) ----------\n");
                        printf("-- Sala de Reunião (3) ------\n");
                        printf("-- Sala de Professor (4) ----\n");
                        printf("-- Auditório (5) ------------\n");
                        printf("-- Secretaria (6) -----------\n");
                        scanf("%i", &salas);

                        printf("Insira a capacidade de pessoas que procura:\n");
                        scanf("%i", &cadeiras);

                        busca_sala(salas, cadeiras, tipo_sala, num_salas, a);
                        break;

                    case 2:

                        printf("Qual sala você deseja?(selecione o numero)\n");
                        scanf("%i", &sala);
                        int agendar_sim_nao;
                        // printf("%i\n", cont);
                        // e = (struct data*)realloc(e, (cont)*sizeof(struct data));
                        agendar_sim_nao = mostrar_sala(a, b, c, num_salas, sala, cont, contc, &cont);
                        if (agendar_sim_nao == 0)
                        {
                            printf(RED);
                            printf("Nao foi agendado e/ou sala não disponivel!\n");
                            printf(RESET);
                        }
                        else
                        {
                            cont++;

                            b = (struct agenda *)realloc(b, (cont) * sizeof(struct agenda));

                            int val_data = 2;
                            while (val_data == 2)
                            {
                                printf("Qual data que você deseja agendar a sala?(dd/mm/aaaa)\n");
                                scanf("%i/%i/%i", &(b[cont - 1].z).dia, &(b[cont - 1].z).mes, &(b[cont - 1].z).ano);
                                
                                val_data = validar_data((b[cont - 1].z).dia, (b[cont - 1].z).mes, (b[cont - 1].z).ano);
                            }
                            int possivel = 2;
                            while (possivel == 2)
                            {
                                int verifica_hora_f = 2;
                                int verifica_hora_i = 2;
                                while (verifica_hora_i == 2)
                                {
                                    printf("Qual a hora que você deseja entrar na sala?(hh:mn)\n");
                                    scanf("%i:%i", &b[cont - 1].z.hora_i, &b[cont - 1].z.min_i);
                                    verifica_hora_i = validar_hora(b[cont - 1].z.hora_i, b[cont - 1].z.min_i);
                                }

                                while (verifica_hora_f == 2)
                                {
                                    printf("Qual a hora que você deseja sair da sala?(hh:mn)\n");
                                    scanf("%i:%i", &b
                                    [cont - 1].z.hora_f, &b[cont - 1].z.min_f);
                                    verifica_hora_f = validar_hora(b[cont - 1].z.hora_f, b[cont - 1].z.min_f);
                                }

                                if (b[cont - 1].z.hora_i > b[cont - 1].z.hora_f)
                                {
                                    printf(RED);
                                    printf("Hora invalida\n");
                                    printf(RESET);
                                    possivel = 2;
                                }
                                else if ((b[cont - 1].z.hora_i == b[cont - 1].z.hora_f) && (b[cont - 1].z.min_i > b[cont - 1].z.min_f))
                                {
                                    printf(RED);
                                    printf("Hora invalida\n");
                                    printf(RESET);
                                    possivel = 2;
                                }
                                else
                                {
                                    possivel++;
                                }
                            }

                            int val_agenda_b = compara_agenda(b, cont, sala, (b[cont - 1].z).dia, (b[cont - 1].z).mes, (b[cont - 1].z).ano, (b[cont-1].z).hora_i, b[cont - 1].z.min_i, b[cont - 1].z.hora_f, b[cont - 1].z.min_f);

                            int val_agenda_c = compara_agenda(c, contc + 1, sala, (b[cont - 1].z).dia, (b[cont - 1].z).mes, (b[cont - 1].z).ano, (b[cont-1].z).hora_i, b[cont - 1].z.min_i, b[cont - 1].z.hora_f, b[cont - 1].z.min_f);

                            if (val_agenda_b == 0 && val_agenda_c == 0)
                            {
                                 adicionar_agenda(a, b, num_salas, sala, cont);
                            }
                            else
                            {
                                cont--;
                                b = (struct agenda *)realloc(b, (cont) * sizeof(struct agenda));

                                printf(RED);
                                printf("Nao foi agendado e/ou sala não disponivel!\n");
                                printf(RESET);
                            }
                        }

                        break;

                    default:
                        break;
                    }

                    break;

                case 2:

                    printf(CIANO);
                    printf("\n*** AGENDA PESSOAL ***\n");
                    printf(RESET);
                    if (cont == 0)
                    {
                        printf(RED);
                        printf("Nenhuma sala agendada ainda!\n");
                        printf(RESET);
                    }
                    else
                    {
                        printf(GREEN);
                        mostrar_agenda(b, cont);
                        printf(RESET);

                        printf(CIANO);
                        printf("\n*** MENU DA AGENDA ***");
                        printf(RESET);

                        printf("\nDigite (1) para remover um agendamento\n");
                        printf("Digite (2) para voltar ao menu inicial\n");

                        scanf("%i", &remover_sala);

                        if (remover_sala == 1)
                        {
                            int num_sala_remover, dia_remover, mes_remover, ano_remover, hora_remover, minuto_remover;
                            printf("Insira o numero do ambiente que deseja remover\n");
                            scanf("%i", &num_sala_remover);
                            printf("Qual o data do agendamento(dd/mm/aaaa): \n");
                            scanf("%i/%i/%i", &dia_remover, &mes_remover, &ano_remover);
                            printf("Qual a hora de inicio do agendamento(hh:mn): \n");
                            scanf("%i:%i", &hora_remover, &minuto_remover);

                            // inicia o processo de remocao da sala da agenda
                            int index_remover = -1;

                            // Encontrar o índice da sala a ser removida
                            for (int i = 0; i < cont; i++)
                            {
                                if (b[i].y.sala == num_sala_remover && b[i].z.dia == dia_remover && b[i].z.mes == mes_remover && b[i].z.ano == ano_remover && b[i].z.hora_i == hora_remover && b[i].z.min_i == minuto_remover)
                                {
                                    index_remover = i;
                                }
                            }

                            // Se a sala não foi encontrada
                            if (index_remover == -1)
                            {
                                printf(RED);
                                printf("\nSala não encontrada!\n");
                                printf(RESET);
                            }

                            // Decrementar o número de salas SOMENTE se o numero de agendamentos for maior que 0
                            if (cont > 0 && index_remover != -1)
                            {
                                // Mover todos os elementos à direita da sala a ser removida uma posição para a esquerda
                                for (int i = index_remover; i < (cont - 1); i++)
                                {
                                    b[i] = b[i + 1];
                                }

                                cont--;

                                // Realocando a struct agendas com uma posicao a menos
                                b = (struct agenda *)realloc(b, cont * sizeof(struct agenda));

                                printf(GREEN);
                                printf("\nAmbiente removido com sucesso!\n");
                                printf(RESET);
                            }
                        }
                    }

                    break;

                case 3:
                    // trocara de conta pelo menu principal
                    prof++;
                    break;

                case 4:

                    prof++;
                    inicializacao++;
                    break;

                default:
                    printf(RED);
                    printf("Ação invalida!\n");
                    printf(RESET);
                    break;
                }

                // Fim do prof
            }

            break;
            // fim do professor

        case 2:
            // inicio do aluno
            int alu = 1;
            while (alu == 1)
            {
                printf(CIANO);
                printf("\n*** MENU INICIAL ***\n");
                printf(RESET);

                printf("Digite (1) para consultar as salas\n");
                printf("Digite (2) trocar de usuario\n");
                printf("Digite (3) para encerrar o programa\n");
                scanf("%i", &inicio);
                switch (inicio)
                {
                case 1:
                    printa_sala(a, num_salas, tipo_sala);
                    printf(CIANO);
                    printf("\n*** MENU DE BUSCA ***\n");
                    printf(RESET);

                    printf("\nDigite 1 para filtrar as salas \n");
                    printf("Digite 2 para selecionar uma sala \n");
                    scanf("%i", &selecao);

                    switch (selecao)
                    {
                    case 1:
                        printf(CIANO);
                        printf("\n*** MENU DE FILTRAGEM ***\n");
                        printf(RESET);
                        printf("Insira o numero do ambiente desejado:\n");
                        printf("-- Sala de Aula (1) ---------\n");
                        printf("-- Laboratorio (2) ----------\n");
                        printf("-- Sala de Reunião (3) ------\n");
                        printf("-- Sala de Professor (4) ----\n");
                        printf("-- Auditório (5) ------------\n");
                        printf("-- Secretaria (6) -----------\n");
                        scanf("%i", &salas);

                        printf("Qual a capacidade da sala que você está procurando:\n");
                        scanf("%i", &cadeiras);

                        busca_sala(salas, cadeiras, tipo_sala, num_salas, a);
                        break;

                    case 2:
                        int sala_aluno = 0;
                        printf("Qual sala você deseja?(selecione o numero)\n");
                        scanf("%i", &sala);

                        for (int i = 0; i < num_salas; i++)
                        {
                            if (a[i].x.sala == sala)
                            {
                                sala_aluno++;
                                printf("\n --- Ambiente selecionado ---\n");
                                printf("Local: %s %i\n", a[i].nome, a[i].x.sala);
                                printf("Mesas: %i\n", a[i].x.mesas);
                                printf("Cadeiras: %i\n", a[i].x.cadeiras);
                                printf("Pcs: %i\n", a[i].x.pcs);
                                printf("Projetores: %i\n", a[i].x.projetores);
                                printf("Quadros: %i\n", a[i].x.quadros);
                            }
                        }
                        if (sala_aluno == 0)
                        {
                            printf(RED);
                            printf("Sala não disponivel!\n");
                            printf(RESET);
                        }

                        break;

                    default:
                        break;
                    }

                    break;

                case 2:
                    alu++;
                    break;

                case 3:

                    alu++;
                    inicializacao++;

                    break;

                default:
                    break;
                }

                // Fim do aluno
            }

            break;

        default:
            printf(RED);
            printf("\nUsuário invalido!\n\n");
            printf(RESET);
            break;
        }
    }
    printf(GREEN);
    printf("\nObrigado por testar o programa!\n");
    printf(RESET);

    free(a);
    free(b);
    free(c);
    free(tipo_sala);
}