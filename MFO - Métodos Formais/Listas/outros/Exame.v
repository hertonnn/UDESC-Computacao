(* Nome:                                       *)

(* Todas as declarações devem ser feitas nesse arquivo,
   não deve ser importado nenhum módulo. *)

Require Export Arith.
Require Import Coq.Bool.Bool.

(* Questão 1 *)

Theorem p_or_negp : forall p,
  p = true <-> negb p = false.
Proof.
  Admitted.
 
(* Questão 2 *)

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
  Admitted.

(* Questão 3 *)

Inductive le' : nat -> nat -> Prop :=
  | le_0' m : le' 0 m
  | le_S' n m (H : le' n m) : le' (S n) (S m).

Lemma le'_n_Sm : forall a b, le' a b -> le' a (S b). 
Proof.
  Admitted.

(* Questão 4 *)

Theorem le_le' : forall a b, le a b <-> le' a b.
Proof.
  Admitted.





