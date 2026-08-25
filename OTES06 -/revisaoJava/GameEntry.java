import java.util.Scanner;

public class GameEntry {

    /**
    Crie uma classe para armazenar o score de um jogador, de acordo com a definição
    abaixo. Em seguida, crie um vetor para armazenar 10 scores, não é necessário que os
    scores estejam ordenados. Os dados dos scores devem ser informados pelo usuário.
    Por fim, crie um método para listar todos os scores.
    */

    private String nome;
    private int score;
    
    public GameEntry(String nome, int score) {
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

    public static void listarScores(GameEntry[] vetor){
        for(GameEntry entrada : vetor){
            System.out.println(entrada);
        }
    }
    public static void main(String[] args) {
        GameEntry[] scores = new GameEntry[10];
        
        Scanner scanner = new Scanner(System.in);

        String tempNome;
        int tempScore;

        for (int i = 0; i < 10; i++){
            System.out.print("Digite o nome do jogador " + i + ": ");

            tempNome = scanner.nextLine();
            
            System.out.print("Digite o score do jogador " + i + ": ");
            tempScore = scanner.nextInt();
            scanner.nextLine();
            
            scores[i] = new GameEntry(tempNome, tempScore);
        }

        System.out.println("Scores cadastrados: ");
        listarScores(scores);


        scanner.close();
    }

}