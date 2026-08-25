#include <stdio.h>
#include <pthread.h>
#include <semaphore.h>
#include <unistd.h>

// Define aliases para ficar mais legível
#define down(s) sem_wait(&s)
#define up(s)   sem_post(&s)

// Semáforos
sem_t sem_R_done;
sem_t sem_Y_done;
sem_t sem_Lock;

// Thread que faz a leitura (R)
void* thread_R(void* arg) {
    printf("Thread R: realizando leitura...\n");
    sleep(1); // simula tempo de leitura
    printf("Thread R: leitura concluída.\n");
    up(sem_R_done);  // Sinaliza que a leitura foi feita
    return NULL;
}

// Thread que espera uma condição (Y)
void* thread_Y(void* arg) {
    printf("Thread Y: aguardando condição externa...\n");
    sleep(2); // simula tempo de espera
    printf("Thread Y: condição satisfeita.\n");
    up(sem_Y_done);  // Sinaliza que a condição foi satisfeita
    return NULL;
}

// Thread que realiza ação crítica (L), mas só depois de R e Y
void* thread_L(void* arg) {
    printf("Thread L: aguardando leitura (R) e condição (Y)...\n");

    down(sem_R_done);  // Espera a leitura
    down(sem_Y_done);  // Espera a condição

    down(sem_Lock);    // Entra na seção crítica
    printf("Thread L: executando ação crítica (L)...\n");
    sleep(2);          // Simula trabalho
    printf("Thread L: ação crítica finalizada.\n");
    up(sem_Lock);      // Sai da seção crítica

    return NULL;
}

int main() {
    pthread_t tR, tY, tL;

    // Inicializa os semáforos
    sem_init(&sem_R_done, 0, 0);
    sem_init(&sem_Y_done, 0, 0);
    sem_init(&sem_Lock,    0, 1);  // Lock começa liberado

    // Cria as threads
    pthread_create(&tR, NULL, thread_R, NULL);
    pthread_create(&tY, NULL, thread_Y, NULL);
    pthread_create(&tL, NULL, thread_L, NULL);

    // Aguarda término das threads
    pthread_join(tR, NULL);
    pthread_join(tY, NULL);
    pthread_join(tL, NULL);

    // Destrói os semáforos
    sem_destroy(&sem_R_done);
    sem_destroy(&sem_Y_done);
    sem_destroy(&sem_Lock);

    return 0;
}
