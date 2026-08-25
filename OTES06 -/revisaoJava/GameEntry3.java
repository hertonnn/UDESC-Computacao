import java.util.ArrayList;
import java.util.Collections;
import java.util.Comparator;
import java.util.Scanner;

public class GameEntry3 {

    /**
    Crie uma classe para armazenar o score de um jogador, de acordo com a definição
    abaixo. Em seguida, crie um vetor para armazenar 10 scores, não é necessário que os
    scores estejam ordenados. Os dados dos scores devem ser informados pelo usuário.
    Por fim, crie um método para listar todos os scores.

    Terceira alteração:  Altere o programa anterior para ordenar os scores armazenados na lista em ordem decrescente. Utilize o método Collections.sort() e implemente um método compare da interface Comparator.
    */

    private String nome;
    private int score;
    
    public GameEntry3(String nome, int score) {
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

    public static void listarScores(GameEntry3[] vetor){
        for(GameEntry3 entrada : vetor){
            System.out.println(entrada);
        }
    }

    public static class OrdenarScoreDecrescente implements Comparator<GameEntry3>{

        @Override
        public int compare(GameEntry3 o1, GameEntry3 o2) {
            return Integer.compare(o2.getScore(), o1.getScore());
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
            
            listaScores.add(new GameEntry3(tempNome, tempScore));
        }

        // Ordenando:
        Collections.sort(listaScores, new OrdenarScoreDecrescente());

        System.out.println("Scores cadastrados: ");
        
        for (Object obj : listaScores) {
            GameEntry3 entrada = (GameEntry3) obj;
            System.out.println(entrada);
        }

        scanner.close();
    }

}