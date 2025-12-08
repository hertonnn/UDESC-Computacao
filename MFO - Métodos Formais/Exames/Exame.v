(* Nome: Herton Silveira*)

(* Todas as declarações devem ser feitas nesse arquivo,
   não deve ser importado nenhum módulo. *)

Require Export Arith.
Require Import Coq.Bool.Bool.

(* Questão 1 *)
(* Estratégia: Como p é um booleano, só existem dois casos possíveis: true ou false.
   Usamos 'destruct p' para analisar ambos os casos.
*)
Theorem p_or_negp : forall p,
  p = true <-> negb p = false.
Proof.
  intros p.
  destruct p.
  - (* Caso p = true *)
    split.
    + intros H. simpl. reflexivity.
    + intros H. reflexivity.
  - (* Caso p = false *)
    split.
    + intros H. discriminate H. (* true = false é impossível *)
    + intros H. simpl in H. discriminate H.
Qed.

(* Questão 2 *)
(* Estratégia: Expandimos a definição de oddb. Se oddb n é true, então
   negb (evenb n) é true. Fazemos a análise de casos no valor de (evenb n).
*)
Fixpoint evenb (n:nat) : bool :=
  match n with
  | O        => true
  | S O      => false
  | S (S n') => evenb n'
  end.

Definition oddb (n:nat) : bool   :=   negb (evenb n).

Theorem even_S_odd : forall n, 
  oddb n = true -> evenb n = false.
Proof.
  intros n H.
  unfold oddb in H.     (* Revela que oddb é negb (evenb n) *)
  destruct (evenb n).   (* Analisa o resultado de evenb n: true ou false *)
  - (* Se evenb n for true *)
    simpl in H. discriminate H. (* negb true é false, logo false = true, contradição *)
  - (* Se evenb n for false *)
    reflexivity.
Qed.

(* Questão 3 *)
(* Estratégia: Indução na estrutura da derivação de le' (H).
   Se sabemos que a <= b, queremos provar que a <= S b.
*)
Inductive le' : nat -> nat -> Prop :=
  | le_0' m : le' 0 m
  | le_S' n m (H : le' n m) : le' (S n) (S m).

Lemma le'_n_Sm : forall a b, le' a b -> le' a (S b). 
Proof.
  intros a b H.
  induction H.
  - (* Caso base: le_0' *)
    (* Temos le' 0 m, queremos le' 0 (S m) *)
    apply le_0'.
  - (* Passo indutivo: le_S' *)
    (* Hipótese IHle': le' n (S m). Queremos le' (S n) (S (S m)) *)
    apply le_S'.
    exact IHle'.
Qed.

(* Questão 4 *)
(* Estratégia: Dividir o 'se, e somente se' (<->) em duas direções.
   -> : Usamos indução na definição padrão 'le'. Vamos precisar provar reflexividade para le' e usar o Lema da Q3.
   <- : Usamos indução na definição customizada 'le''. Usamos le_0_n e le_n_S da biblioteca padrão.
*)
(* Questão 4 *)

Theorem le_le' : forall a b, le a b <-> le' a b.
Proof.
  intros a b.
  split.
  
  (* Direção -> : le a b implica le' a b *)
  - intros H.
    (* CORREÇÃO AQUI: Nomeamos explicitamente as variáveis da indução.
       [| ...] separa o caso base do caso indutivo.
       m    : o número intermediário
       H_le : a prova de (le a m)
       IH   : a hipótese de indução (que diz que le' a m é verdade)
    *)
    induction H as [| m H_le IH].
    + (* Caso base do le (reflexividade: le n n) *)
      (* Precisamos provar le' a a. Faremos uma indução rápida em 'a' *)
      induction a.
      * apply le_0'.
      * apply le_S'. apply IHa.
    + (* Passo indutivo do le (le n m -> le n (S m)) *)
      (* Agora temos certeza que a hipótese se chama 'IH' *)
      apply le'_n_Sm.
      exact IH.

  (* Direção <- : le' a b implica le a b *)
  - intros H.
    induction H.
    + (* Caso le_0': le' 0 m implies le 0 m *)
      apply le_0_n.
    + (* Caso le_S': le' (S n) (S m) implies le (S n) (S m) *)
      apply le_n_S.
      exact IHle'.
Qed.
