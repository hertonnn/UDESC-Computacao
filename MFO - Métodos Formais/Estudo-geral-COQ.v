Require Import Arith. (* Para 'S' e '0' de nat *)

(*
 # Meu estudo DE COQ/Galina para Métodos formais
 
 1. Instalação e ambiente:
 - É possível estudar de forma rápida com uma versão online do 
   [Coq](https://coq.vercel.app/scratchpad.html): 
 - Mas também, é possível ter o Coq e o CoqIDE (ou uma integração com VS Code via VsCoq) 
   instalados e funcionando. O CoqIDE é ótimo para iniciantes, pois mostra o estado atual 
   da prova e o contexto.
 - Exercício: Abra o CoqIDE, crie um novo arquivo .v e digite Check nat.. 
   Salve o arquivo e compile/verifique no CoqIDE para se familiarizar com o processo.
 
 2. Lógica e Tipos (Calculus of Constructions):
- Inductive: Para definir tipos de dados e proposições
- Definion: Para definir funções e termos
- Variable, Parameter: Para introduzir variáveis ou parâmetros globais
- foral: Quantificador universal
- (->)seta: Implicação lógica e tipo de função
- match... with... end: Para análise de caso (pattern matching).
- Fixpoint: Para definir funções recursivas

Exercicio: 
 - Defina um tipo indutivo para números pares (ex: Inductive even : nat -> Proop := ...)
 - Defina uma função add_one_then_two que recebe um nat e retorna n + 3 (você pode usar S para +1)
*) 
(*Exercicio 1*)
(*Vamos aprender sobre provas mais adiante, por agora preste atenção apenas nas lógicas*)

Inductive even : nat -> Prop :=
  | even_0 : even 0 (*even_0 é o construtor e e even 0 afirma que zero é par*)
  | even_S_S : forall n : nat, even n -> even(S (S n)). (*even_S_S construtor e
  
  forall n : nat, even n -> even(S (S n)). Significa que para qualquer numero natural n, 
  se n é par, então n + 2 ((S (S n))) é par.
  *)
  
 (*Prova que 0 é par*)
 Lemma zero_is_even : even 0.
 Proof.
  apply even_0. (*Usamos o construtor even_0 diretamente*)
 Qed.
 
 
 (*Prova que 2 é par*)
 Lemma two_is_even : even 2.
 Proof.
  apply (even_S_S 0). (* Aplica o construtor even_S_S para n=0 *)
  apply even_0.       (* Prova o subobjetivo even 0 *)
 Qed.
 
 (*Prova que 4 é par*)
 Lemma four_is_even : even 4.
 Proof.
  apply (even_S_S 2). (* Aplica o construtor even_S_S para n=2 *)
  apply (even_S_S 0). (* Aplica o construtor even_S_S para n=0 *)
  apply even_0.       (* Prova o subobjetivo even 0 *)
 Qed.
 
 (*Exercicio 2*)
 
 Definition add_one_then_two (n : nat) : nat := (*Recebe n do tipo nat e retorna 
                                                  um nat (:= atribui a definição)*)
  S (S (S n)).
 
 Example test_add_one_then_two : add_one_then_two 5 = 8.
 Proof.
    reflexivity. (* Coq pode computar ambos os lados para S (S (S 5)) = 8 *)
 Qed.
 
(*
  3. Provas (Tatics):

- Coq usa o conceito de "táticas" para construir provas
- *Táticas Essenciais para iniciantes:*
    - Proof. ... Qed.: Inicia e termina uma prova.
    - intros: Introduz variáveis no contexto (antecedentes da implicação).
    - reflexivity: Prova metas de igualdade se os dois lados são computacionalmente equivalentes.
    - simpl: Simplifica termos.
    - unfold: Expande definições.
    - rewrite: Reescreve termos usando uma igualdade.
    - apply: Aplica um teorema ou hipótese.
    - induction: Para provas indutivas (especialmente em nat e list).
    - destruct: Para análise de caso em tipos indutivos (similar a match para termos).
    - auto, eauto: Táticas automatizadas para resolver metas simples.
    - Admitted: Para "admitir" uma prova (útil para continuar sem provar algo imediatamente).
Exercicios:
  - Prove que forall n m : nat, n + m = m + n (comutatividade da adição). Use induction 
    em n e rewrite com lemas da biblioteca padrão (ex: plus_0_r, plus_succ_r).
  - Prove que forall n : nat, n = n.
*)
Inductive comutatividade : 



