#include <stdio.h>
#include <stdlib.h>
#include <unistd.h>
#include <sys/types.h>
#include <sys/wait.h>

int main()
{
    pid_t f_pai, f2, f3, f4;
    printf("Processo principal PID:%u\n", getpid()); // pid do processo do atual (principal)
    printf("A  |  Processo Pai PID:%u  |  Processo Atual PID:%u \n", getppid(), getpid());
    f_pai = fork(); // processo pai

    if (f_pai == 0)
    {
        printf("B  |  Processo Pai PID:%u  |  Processo Atual PID:%u \n", getppid(), getpid());
        f2 = fork(); // processo pai
        if (f2 == 0)
        {
            printf("C  |  Processo Pai PID:%u  |  Processo Atual PID:%u \n", getppid(), getpid());
            f3 = fork(); // processo pai
            if (f3 == 0)
            {
                printf("D  |  Processo Pai PID:%u  |  Processo Atual PID:%u \n", getppid(), getpid());
            }
        }
    }

    //return;
    sleep(5); // espera 5s para garantir que o print n seja feito depois do fim da execucao

}