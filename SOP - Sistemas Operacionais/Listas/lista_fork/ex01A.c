#include <stdio.h>
#include <stdlib.h>
#include <unistd.h>
#include <sys/types.h>
#include <sys/wait.h>

int main()
{
    printf("Processo principal PID:%u\n", getpid()); // pid do processo do atual (principal)
    printf("A  |  Processo Pai PID:%u  |  Processo Atual PID:%u \n", getppid(), getpid());
    pid_t f_pai = fork(); // processo pai

    if (f_pai == 0) // criou o primeiro processo filho
    {
        printf("B  |  Processo Pai PID:%u  |  Processo Atual PID:%u \n", getppid(), getpid());
    }
    else
    {                   // acabou o processo filho de f_pai
        f_pai = fork(); // processo pai gera um novo filho
        if (f_pai == 0)
        { // gerou o segundo filho
            printf("C  |  Processo Pai PID:%u  |  Processo Atual PID:%u \n", getppid(), getpid());
        }
        else
        {
            f_pai = fork(); // processo pai gera um novo filho
            if (f_pai == 0)
            { // gerou o segundo filho
                printf("D  |  Processo Pai PID:%u  |  Processo Atual PID:%u \n", getppid(), getpid());
            }
        }
    }
}