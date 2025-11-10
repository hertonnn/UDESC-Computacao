/**
 * Uma carta de um baralho comum.
 * Num baralho comum, existem 52 cartas: 13 valores (AS, 2, 3, ..., 10, valete, dama, rei)
 * de 4 naipes (ouros, espadas, copas, paus).
 * Cartas podem ser criadas, comparadas (quanto a seu valor), etc.
 */
public class Carta {
  /**
   * Valor da carta AS. Usado para construir uma carta: new Carta(Carta.AS, Carta.PAUS)
   */
  public static final int AS = 1;
  /**
   * Valor da carta VALETE. Usado para construir uma carta: new Carta(Carta.VALETE, Carta.PAUS)
   */
  public static final int VALETE = 11;
  /**
   * Valor da carta DAMA. Usado para construir uma carta: new Carta(Carta.DAMA, Carta.PAUS)
   */
  public static final int DAMA = 12;
  /**
   * Valor da carta REI. Usado para construir uma carta: new Carta(Carta.REI, Carta.PAUS)
   */
  public static final int REI = 13;

  /**
   * Valor do naipe de PAUS. Usado para construir uma carta: new Carta(Carta.AS, Carta.PAUS)
   */
  public static final int PAUS = 0;
  /**
   * Valor do naipe de OUROS. Usado para construir uma carta: new Carta(Carta.AS, Carta.OUROS)
   */
  public static final int OUROS = 1;
  /**
   * Valor do naipe de COPAS. Usado para construir uma carta: new Carta(Carta.AS, Carta.COPAS)
   */
  public static final int COPAS = 2;
  /**
   * Valor do naipe de ESPADAS. Usado para construir uma carta: new Carta(Carta.AS, Carta.ESPADAS)
   */
  public static final int ESPADAS = 3;

  private int  valor;
  private int  naipe;

  /**
   * Construtor de uma carta comum.
   * @param valor O valor da carta (AS, 2, 3, ..., 10, VALETE, DAMA, REI).
   * @param naipe O naipe da carta (PAUS, OUROS, COPAS, ESPADAS).
   */
  public Carta(int valor, int naipe) {
    this.valor = valor;
    this.naipe = naipe;
  }

  /**
   * Recupera o valor da carta.
   * @return O valor da carta.
   */
  public int getValor() {
    return valor;
  }

  /**
   * Recupera o naipe da carta.
   * @return O naipe da carta.
   */
  public int getNaipe() {
    return naipe;
  }

  /**
   * Recupera o valor da menor carta deste tipo que pode ser criada.
   * � poss�vel fazer um la�o de menorValor() at� maiorValor() para varrer
   * todos os valores poss�veis de cartas.
   * @return O menor valor.
   */
  public static int menorValor() {
      return AS;
  }

  /**
   * Recupera o valor da maior carta deste tipo que pode ser criada.
   * � poss�vel fazer um la�o de menorValor() at� maiorValor() para varrer
   * todos os valores poss�veis de cartas.
   * @return O maior valor.
   */
  public static int maiorValor() {
      return REI;
  }

  /**
   * Recupera o "primeiro naipe" das cartas deste tipo.
   * Ser "primeiro naipe" n�o significa muita coisa, j� que naipes n�o tem valor
   * (um naipe n�o � menor ou maior que o outro).
   * Fala-se de "primeiro naipe" e "�ltimo naipe" para poder
   * fazer um la�o de primeiroNaipe() at� �ltimoNaipe() para varrer
   * todos os naipes poss�veis de cartas.
   * @return O primeiro naipe.
   */
  public static int primeiroNaipe() {
      return PAUS;
  }

  /**
   * Recupera o "�ltimo naipe" das cartas deste tipo.
   * Ser "�ltimo naipe" n�o significa muita coisa, j� que naipes n�o tem valor
   * (um naipe n�o � menor ou maior que o outro).
   * Fala-se de "primeiro naipe" e "�ltimo naipe" para poder
   * fazer um la�o de primeiroNaipe() at� �ltimoNaipe() para varrer
   * todos os naipes poss�veis de cartas.
   * @return O primeiro naipe.
   */
  public static int UltimoNaipe() {
      return ESPADAS;
  }

  /**
   * Compare esta carta a outra.
   * @param outra A carta a comparar a esta.
   * @return Zero se forem iguais. Um valor < 0 se a carta for menor que a outra carta.
   * Um valor > 0 se a carta for maior que a outra carta.
   */
  public int compareTo(Carta outra) {
      return getValor() - outra.getValor();
  }

  /**
   * Testa a igualdade de um objeto com esta carta.
   * @param objeto O objeto a comparar com esta carta.
   * @return true se o objeto for igual a esta carta, false caso contr�rio.
   */
  public boolean equals(Object objeto) {
      if(! (objeto instanceof Carta)) {
          return false;
      }
      Carta outra = (Carta)objeto;
      return getValor() == outra.getValor()
              && getNaipe() == outra.getNaipe();
  }

   protected static final String[] nomeDeCarta = {
    "", // queremos sincronizar o valor da carta e seu indice (AS == 1, etc.)
    "AS",
    "DOIS",
    "TRES",
    "QUATRO",
    "CINCO",
    "SEIS",
    "SETE",
    "OITO",
    "NOVE",
    "DEZ",
    "VALETE",
    "DAMA",
    "REI",
  };

  protected static final String[] nomeDeNaipe = {
    "PAUS",
    "OUROS",
    "COPAS",
    "ESPADAS",
  };

  /**
   * Representa a carta como String.
   * @return Um string representando a carta.
   */
  public String toString() {
    return nomeDeCarta[getValor()] + " de " + nomeDeNaipe[getNaipe()];
  }
}
