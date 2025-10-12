(* Exame Métodos Formais 
   Nome: Igor Schiessl Froehner*)

(* Todas as declarações devem ser feitas nesse arquivo,
   não deve ser importado nenhum módulo adicional. *)

Require Import Arith.
Require Import Coq.Lists.List.
Import ListNotations.


Fixpoint index {X : Set} (n : nat) (l : list X) : option X :=
  match l with
  | [] => None
  | h :: t => if n =? 0 then Some h else index (pred n) t
  end. 

(* Questão 1 *)

Theorem repeat_n : forall {X:Set} (n:nat) (x:X),
  length (repeat x n) = n.
Proof.
  intros. induction n as [|n' IHn].
  - reflexivity.
  - simpl. f_equal. apply IHn.
Qed.

(* Questão 2 *)

(* Alguns Teoremas uteis envolvendo <=
Theorem le_pred : forall n m, n <= m -> pred n <= pred m.
Theorem le_S_n  : forall n m, S n <= S m -> n <= m.
Theorem le_0_n  : forall n, 0 <= n.
Theorem le_n_S  : forall n m, n <= m -> S n <= S m. *)

Theorem le_plus_l : forall a b,
  a <= a + b.
Proof.
  intros. induction a as [|a' IHa].
  - simpl. apply le_0_n.
  - simpl. apply le_n_S. apply IHa.
Qed.

(* Questão 3*)

Search le.

Theorem repeat_index : forall {X:Set} (x:X) (i:nat) (n:nat) ,
  i <= n -> index i (repeat x (S n)) = Some x.
Proof.
  induction i as [|i' IHi].
  - intros n H. simpl. reflexivity.
  - intros n H. destruct n.
    + simpl. inversion H.
    + apply IHi. apply le_S_n. apply H.
Qed.

(* Questão 4 *)

Theorem index_map : forall {X Y:Set} (n:nat) (f:X->Y) (l:list X) (x:X), 
  index n l = Some x -> Some (f x) = index n (map f l).
Proof.
  Admitted.
