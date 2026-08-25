import java.util.ArrayList;
import java.util.Scanner;

public class GameEntry2 {

    /**
    Crie uma classe para armazenar o score de um jogador, de acordo com a definição
    abaixo. Em seguida, crie um vetor para armazenar 10 scores, não é necessário que os
    scores estejam ordenados. Os dados dos scores devem ser informados pelo usuário.
    Por fim, crie um método para listar todos os scores.

    Segunda alteração: Altere o programa anterior para utilizar uma
    lista (ArrayList ou Vector) do pacote java.utils.
    */

    private String nome;
    private int score;
    
    public GameEntry2(String nome, int score) {
        this.nome = nome;
        this.score = score;
    }

    public String getNome() {
        return this.nome;
    }

    public int getScore() {
        return this.score;
    }

    public String toString() {
        return "nome: '" + nome + "', score: " + score;
    }

    public static void listarScores(GameEntry2[] vetor){
        for(GameEntry2 entrada : vetor){
            System.out.println(entrada);
        }
    }
    public static void main(String[] args) {
        
        ArrayList listaScores = new ArrayList();

        Scanner scanner = new Scanner(System.in);

        String tempNome;
        int tempScore;

        for (int i = 0; i < 10; i++){
            System.out.print("Digite o nome do jogador " + i + ": ");

            tempNome = scanner.nextLine();
            
            System.out.print("Digite o score do jogador " + i + ": ");
            tempScore = scanner.nextInt();
            scanner.nextLine();
            
            listaScores.add(new GameEntry2(tempNome, tempScore));
        }

        System.out.println("Scores cadastrados: ");
        
        for (Object obj : listaScores) {
            GameEntry2 entrada = (GameEntry2) obj;
            System.out.println(entrada);
        }

        scanner.close();
    }

}