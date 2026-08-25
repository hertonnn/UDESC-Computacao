#include <stdio.h>
#include <stdlib.h>
#include <unistd.h>
#include <sys/types.h>
#include <sys/wait.h>

int main()
{
    pid_t f_pai, f2, f3, f4, f5;
    printf("Processo principal PID:%u\n", getpid()); // pid do processo do atual (principal)
    printf("A  |  Processo Pai PID:%u  |  Processo Atual PID:%u \n", getppid(), getpid());
    f_pai = fork(); // processo pai

    if (f_pai == 0)
    {
        printf("B  |  Processo Pai PID:%u  |  Processo Atual PID:%u \n", getppid(), getpid());
    }
    else
    {
        f_pai = fork();
        if (f_pai == 0)
        {
            printf("C  |  Processo Pai PID:%u  |  Processo Atual PID:%u \n", getppid(), getpid());
            f3 = fork();
            if (f3 == 0)
            {
                printf("D  |  Processo Pai PID:%u  |  Processo Atual PID:%u \n", getppid(), getpid());
            }
            else
            {
                f3 = fork();
                if (f3 == 0)
                {
                    printf("E  |  Processo Pai PID:%u  |  Processo Atual PID:%u \n", getppid(), getpid());
                }
            }
        }
    }
    sleep(4);
}