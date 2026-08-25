#include <stdio.h>
 #include <stdlib.h>
 #include <unistd.h>
 #include <sys/types.h>
 #include <sys/wait.h>

int main(void)
{ 
    int n = 5;
    if (fork() == 0)
        n++;
    n += 10;
    if (fork() > 0)
        n++;
    printf("n = %d\n", n);
    return 0;
}