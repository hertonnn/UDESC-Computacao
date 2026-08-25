// Linha de comando para executar: 
// gcc ex1_SOP.c && ./a.out ARQUIVO1 ARQUIVO2
// ARQUIVO1 é o arquivo que existente que irá ser copiado
// ARQUIVO2 é o arquivo não existente que será criado irá receber o conteudo

#include <stdio.h>
#include <stdlib.h>
#include <unistd.h>
#include <fcntl.h>
#include <sys/stat.h>

int main(int argc, char* argv[]){


    int origem = open(argv[1], O_RDONLY);
    if( origem == -1){
        printf("\nArquivo inexistente!\n");
    }

    int tam_buffer = 4096;
    struct stat buffer;
    char conteudo_lido[tam_buffer]; 

    if (stat(argv[1], &buffer) == -1) {
        perror("Erro ao obter informações do arquivo");
        return 1;
    }

    printf("Tamanho do arquivo: %ld bytes\n", buffer.st_size); 

    mode_t modo = buffer.st_mode;
    int destino = open(argv[2], O_WRONLY | O_CREAT | O_EXCL, modo);
    if (destino == -1) {
        fprintf(stderr, "Erro: Arquivo de destino '%s' ja existe.\n", argv[2]);
    }

    ssize_t bytes_lidos;

    while( (bytes_lidos = read(origem, conteudo_lido, buffer.st_size)) > 0){
        write(destino, conteudo_lido, bytes_lidos);
    }


    return 0;

}