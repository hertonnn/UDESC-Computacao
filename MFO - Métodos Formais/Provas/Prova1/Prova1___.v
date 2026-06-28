(* Primeira Prova de Métodos Formais 6/6/2022 
   Nome: Igor Schiessl Froehner          *)

(* Todas as declarações devem ser feitas nesse arquivo,
   não deve ser importado nenhum módulo. *)

Require Import Coq.Lists.List.
Import ListNotations.

(* Questão 1 - Prove o Teorema evenb_2 *)

Fixpoint evenb (n:nat) : bool :=
  match n with
  | O        => true
  | S O      => false
  | S (S n') => evenb n'
  end.

Search mult PeanoNat.Nat.odd.
Search plus PeanoNat.Nat.even.

(* PeanoNat.Nat.odd_add_even *)
(* PeanoNat.Nat.even_add_even *)

Theorem evenb_2 : forall n:nat,
  evenb (2 * n) = true.
Proof.
  intros n.
  induction n as [|n' IHn].
  - reflexivity. 
  - rewrite PeanoNat.Nat.even_mul. reflexivity.
Qed.

(* Questão 2 Prove o teorema even_S_odd*)

Definition oddb (n:nat) : bool   :=   negb (evenb n).

Search (S) PeanoNat.Nat.even.

Theorem even_S_odd : forall n, 
  evenb n = oddb (S n).
Proof.
  intros n. unfold oddb. induction n.
  - simpl. reflexivity.
  - rewrite PeanoNat.Nat.even_succ. rewrite PeanoNat.Nat.even_succ_succ. reflexivity.
Qed.

(* Questão 3 Prove o teorema combine_nil*)

Fixpoint combine {X Y : Type} (lx : list X) (ly : list Y) : list (X*Y) :=
  match lx, ly with
  | [], _ => []
  | _, [] => []
  | x :: tx, y :: ty => (x, y) :: (combine tx ty)
  end.

Theorem combine_nil : forall (X: Type) (Y: Type) (l1: list X)  (l2:list Y),
  l2 = [] -> combine l1 l2 = [].
Proof.
  intros X Y l1 l2 H.
  rewrite H. destruct l1.
  - reflexivity.
  - simpl. reflexivity.
Qed.

(* Questão 4 - Prove o teorema involutive_f_map *)

Fixpoint map {X Y: Type} (f:X->Y) (l:list X) : (list Y) :=
  match l with
  | []     => []
  | h :: t => (f h) :: (map f t)
  end.

Fixpoint fold {X Y: Type} (f: X->Y->Y) (l: list X) (b: Y) : Y :=
  match l with
  | nil => b
  | h :: t => f h (fold f t b)
  end.

Definition fold_map {X Y: Type} (f: X -> Y) (l: list X) : list Y :=
  fold (fun x l' => f x :: l') l [].

Definition compose {A B C} (g : B -> C) (f : A -> B) :=
  fun x : A => g (f x).

Notation "g (.) f" := (compose g f)
                     (at level 5, left associativity).
Definition involutive {A : Type} (f : A -> A) :=
  forall x: A, f (f x) = x.

Lemma f_f_a_involutive: forall (A: Type) (f : A -> A) (a : A),
  involutive f -> f (.) f a = a.
Proof.
  intros. unfold compose. rewrite H. reflexivity.
Qed.

Theorem involutive_f_map : forall (A : Type) (f : A -> A) (l:list A), 
  involutive f -> map f (.) f l = l.
Proof.
  intros X f l H. induction l.
  - simpl. reflexivity.
  - simpl. rewrite IHl. rewrite f_f_a_involutive. reflexivity.
    + apply H.
Qed.

