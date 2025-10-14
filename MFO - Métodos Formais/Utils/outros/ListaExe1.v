Require Import Coq.Arith.PeanoNat.
(* Não deve ser importado nenhum novo arquivo
todas as definições devem estar neste arquivo *)


Fixpoint div2 (n:nat) : nat :=
  match n with
  | O => O
  | S O => O 
  | S (S n') => S (div2 n')  
end.  

Fixpoint sum (n : nat) : nat :=
  match n with
  | O => O
  | S n' => n + sum n'
  end.

Theorem plus_n_1 : forall (n : nat),
  n + 1 = S (n).
Proof.
  induction n.
  - reflexivity.
  - simpl. rewrite IHn. reflexivity.
Qed.

Theorem plus_n_Sm : forall (n m:nat),
  n + S m = S (n + m).
Proof. 
  intros n m. induction n.
  - reflexivity.
  - simpl. rewrite IHn. reflexivity.
Qed.

Theorem mult_2_n_plus : forall (n : nat),
  n + n = 2 * n.
Proof.
  induction n.
  - reflexivity.
  - simpl. rewrite <- plus_n_O. reflexivity.
Qed.

Theorem mul2_div2 : forall n : nat,
  n = div2 (2 * n).
Proof.
  induction n.
  - reflexivity.
  - rewrite Nat.mul_comm. simpl. rewrite Nat.mul_comm. rewrite <- IHn. reflexivity.
Qed.

Theorem div2_mult2_plus: forall (n m : nat),
  n + div2 m = div2 (2 * n + m).
Proof.
  intros m n. induction m.
  - reflexivity.
  - rewrite Nat.mul_comm. simpl. rewrite Nat.mul_comm. rewrite <- IHm. reflexivity.
Qed.

Theorem mult_Sn_m : forall (n m : nat),
  S n * m = m + n * m.
Proof.
  intros n m. induction n.
  - reflexivity.
  - reflexivity.
Qed.

Theorem sum_Sn : forall n : nat,
  sum (S n) = S n + sum n.
Proof.
  intros n. simpl. reflexivity.
Qed.

Theorem sum_n : forall n : nat,
  sum n = div2 (n * (n + 1)).
Proof.
  induction n.
  - reflexivity.
  - rewrite plus_n_1. simpl.
    assert (I: n + n * S (S n) = 2 * n + n * (n + 1)). 
    { rewrite plus_n_1. rewrite <- mult_n_Sm. rewrite Nat.add_comm. rewrite <- Nat.add_assoc. rewrite mult_2_n_plus. rewrite Nat.add_comm. reflexivity.  }
  rewrite I.
  rewrite <- div2_mult2_plus.
  rewrite IHn.
  reflexivity.
Qed.
