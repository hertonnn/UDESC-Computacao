import java.util.*;

/**
 * Um jogo de cartas simples.
 * Cada jogador recebe uma carta do baralho.
 * A maior carta ganha.
 * Repete para cada rodada.
 */
public class MaiorCarta {
  private int     suasVitorias;  // pontua��o
  private int     minhasVitorias;
  private Baralho baralho;

  /**
   * Construtor do jogo.
   */
   public MaiorCarta() {
    suasVitorias = 0;
    minhasVitorias = 0;
    // Factory method para permitir jogar com outros baralhos
    // com override de criaBaralho()
    baralho = criaBaralho();
    baralho.baralhar();
  }
    
  /**
   * Cria um baralho para jogar.
   * @return O baralho.
   */
  protected Baralho criaBaralho() {
    return new Baralho();
  }

  /**
   * Joga o jogo de Maior Carta.
   * @param rodadas O n�mero de rodadas a jogar.
   */
  public void joga(int rodadas) {
    for(int i = 0; i < rodadas; i++) {
      Carta suaCarta = baralho.pegaCarta();
      System.out.print("Sua carta: " + suaCarta + " ");
      Carta minhaCarta = baralho.pegaCarta();
      System.out.print("Minha carta: " + minhaCarta + " ");
      if(suaCarta.compareTo(minhaCarta) > 0) {
        System.out.println("Voce ganha.");
        suasVitorias++;
      } else if(suaCarta.compareTo(minhaCarta) < 0) {
        System.out.println("Eu ganho.");
        minhasVitorias++;
      } else {
        System.out.println("Empate.");
      }
    }
    System.out.println("Voce ganhou " + suasVitorias +
      " vezes, eu ganhei " + minhasVitorias + " vezes, " +
      (rodadas-suasVitorias-minhasVitorias) + " empates.");
  }

  public static void main(String[] args) {
  jogo = MaiorCarta();
  jogo.joga(10);
 }
}
