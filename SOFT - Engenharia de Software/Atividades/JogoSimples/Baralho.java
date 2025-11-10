import java.util.*;
import java.lang.Math.*;

/**
 * Um baralho comum de cartas.
 * Num baralho comum, tem 52 cartas:
 * 13 valores (AS, 2, 3, ..., 10, valete, dama, rei)
 * de 4 naipes (ouros, espadas, copas, paus).
 */
public class Baralho {
  /**
   * O baralho � armazenado aqui.
   * � protected porque alguns baralhos subclasses dessa classe
   * poder�o talvez ter que mexer diretamente aqui
   * para construir baralhos especiais.
   */
  protected Vector baralho;

  /**
   * Construtor de um baralho comum.
   */
  public Baralho() {
    // Usa um Vector para ter um iterador facilmente
    baralho = new Vector();
    // enche o baralho
    for(int valor = menorValor(); valor <= maiorValor(); valor++) {
      for(int naipe = primeiroNaipe(); naipe <= UltimoNaipe(); naipe++) {
        // chama criaCarta e n�o "new" para poder fazer override
        // de criaCarta em baralhos de subclasses e
        // criar classes diferentes.
        baralho.add(criaCarta(valor, naipe));
      }
    }
  }

  /**
   * Cria uma carta para este baralho.
   * @param valor O valor da carta a criar.
   * @param naipe O naipe da carta a criar.
   * @return A carta criada.
   */
  protected Carta criaCarta(int valor, int naipe) {
    return new Carta(valor, naipe);
  }

  /**
   * Recupera o valor da menor carta poss�vel deste baralho.
   * � poss�vel fazer um la�o de menorValor() at� maiorValor()
   * para varrer todos os valores poss�veis de cartas.
   * @return O menor valor.
   */
  public int menorValor() {
    return Carta.menorValor();
  }

  /**
   * Recupera o valor da maior carta poss�vel deste baralho.
   * � poss�vel fazer um la�o de menorValor() at� maiorValor()
   * para varrer todos os valores poss�veis de cartas.
   * @return O maior valor.
   */
  public int maiorValor() {
    return Carta.maiorValor();
  }

  /**
   * Recupera o "primeiro naipe" das cartas que podem estar
   * no baralho.
   * Ser "primeiro naipe" n�o significa muita coisa,
   * j� que naipes n�o tem valor
   * (um naipe n�o � menor ou maior que o outro).
   * Fala-se de "primeiro naipe" e "�ltimo naipe" para poder
   * fazer um la�o de primeiroNaipe() at� �ltimoNaipe() para varrer
   * todos os naipes poss�veis de cartas.
   * @return O primeiro naipe.
   */
  public int primeiroNaipe() {
    return Carta.primeiroNaipe();
  }

  /**
   * Recupera o "�ltimo naipe" das cartas que podem estar
   * no baralho.
   * Ser "�ltimo naipe" n�o significa muita coisa,
   * j� que naipes n�o tem valor
   * (um naipe n�o � menor ou maior que o outro).
   * Fala-se de "primeiro naipe" e "�ltimo naipe" para poder
   * fazer um la�o de primeiroNaipe() at� �ltimoNaipe() para varrer
   * todos os naipes poss�veis de cartas.
   * @return O primeiro naipe.
   */
  public int UltimoNaipe() {
    return Carta.UltimoNaipe();
  }

  /**
   * Recupera o n�mero de cartas atualmente no baralho.
   * @return O n�mero de cartas no baralho.
   */
  public int numeroDeCartas() {
    return baralho.size();
  }
  
  /**
   * Recupera um iterador para poder varrer todas
   * as cartas do baralho.
   * @return Um iterador do baralho.
   */
  public Iterator iterator() {
    return baralho.iterator();
  }

  /**
   * Baralha (tra�a) o baralho.
   */
  public void baralhar() {
    int posicao;
    for(posicao = 0; posicao < numeroDeCartas() - 1; posicao++) {
      // escolhe uma posicao aleat�ria entre posicao e n�meroDeCartas()-1
      int posAleatoria = posicao +
                         (int)((numeroDeCartas() - posicao) *
                               Math.random());
      // troca as cartas em posicao e posAleat�ria
      Carta temp = (Carta)baralho.get(posicao);
      baralho.set(posicao, baralho.get(posAleatoria));
      baralho.set(posAleatoria, temp);
    }
  }

    /**
     * Retira uma carta do topo do baralho e a retorna.
     * A carta � removida do baralho.
     * @return A carta retirada do baralho.
     */
  public Carta pegaCarta() {
    if(numeroDeCartas() == 0) return null;
    return (Carta)baralho.remove(numeroDeCartas()-1);
  }
}