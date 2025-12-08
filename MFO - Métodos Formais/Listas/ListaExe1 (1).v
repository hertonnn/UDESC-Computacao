Require Import Coq.Init.Nat.
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
  intros n.
  induction n.
  -
  simpl.
  reflexivity.
  -
  simpl.
  rewrite IHn.
  reflexivity.
  Qed.
  (*Admitted.*)



Theorem plus_n_Sm : forall (n m:nat),
  n + S m = S (n + m).
Proof. 
  intros n m .
  induction n.
  -
  simpl.
  reflexivity.
  -
  simpl.
  rewrite IHn.
  reflexivity.
 Qed.
  (*Admitted.*)


Theorem N_plus_0: forall (n:nat),
  n + 0 = n.
Proof.
  intros n.
  induction n.
  -
  simpl.
  reflexivity.
  -
  simpl.
  rewrite IHn.
  reflexivity.
 Qed.



Theorem mult_2_n_plus : forall (n : nat),
  n + n = 2 * n.
Proof.
  intros n.
  induction n.
  -
  simpl.
  reflexivity.
  -
  simpl.
  rewrite N_plus_0.
  reflexivity.
  Qed.

  (*Admitted. *)


Theorem mul2_div2 : forall n : nat,
  n = div2 (2 * n).
Proof.
  intros n.
  induction n.
  -
  simpl.
  reflexivity.
  -
  rewrite <- mult_2_n_plus.
  simpl.
  rewrite plus_n_Sm.
  rewrite mult_2_n_plus.
  rewrite <-IHn.
  reflexivity.
  Qed.



Theorem div2_mult2_plus: forall (n m : nat),
  n + div2 m = div2 (2 * n + m).
Proof.
  intros n m.
  induction  n.
  -
  simpl.
  reflexivity.
  -
  rewrite <- mult_2_n_plus.
  rewrite plus_n_Sm.
  simpl.
  rewrite  IHn.
  rewrite  mult_2_n_plus.
  reflexivity.
  Qed.

    

Theorem mult_Sn_m : forall (n m : nat),
  S n * m = m + n * m.
Proof.
  intros n m.
  induction n.
  -
  simpl.
  reflexivity.
  -
  simpl.
  reflexivity.
  Qed.



Theorem sum_Sn : forall n : nat,
  sum (S n) = S n + sum n.
Proof.
  intros n.
  induction n.
  -
  simpl.
  reflexivity.
  -
  simpl.
  reflexivity.
  Qed.

Theorem mult_0: forall n: nat,
  n * 0 = 0.
Proof.
  intros n.
  induction n.
  -
  simpl.
  reflexivity.
  -
  simpl.
  rewrite IHn.
  reflexivity.
  Qed.
  
 
Theorem add_comm : forall n m : nat,
  n + m = m + n.
Proof.
  intros n m.
  induction n.
  - 
  simpl.
  rewrite N_plus_0.
  simpl.
  reflexivity.
  -
  simpl.
  rewrite IHn.
  rewrite plus_n_Sm.
  reflexivity.
  Qed.
  

Theorem add_assoc : forall n m p : nat,
  n + (m + p) = (n + m) + p.
Proof.
  intros n m p.
  induction n.
  - 
  simpl.
  reflexivity.
  -
  simpl. 
  rewrite IHn.
  reflexivity.
  Qed.
  

Theorem doido: forall (n m: nat),
  n* S m = n + n* m.
Proof.
  intros n m.
  induction n.
-
  simpl.
  reflexivity.
-
  simpl.
  rewrite IHn.
  rewrite <- mult_Sn_m.

  simpl.
  rewrite add_comm.

  assert (H:n * m + m = m + n * m).
  {rewrite <-add_comm. 
  reflexivity.
  }
  rewrite <- H.
  rewrite add_assoc.
  
  reflexivity.
  Qed.
  

Theorem sum_n : forall n : nat,
  sum n = div2 (n * (n + 1)).
Proof.
  intros n.
  induction n.
  -
  simpl.
  reflexivity.
  -
  simpl.
  rewrite  plus_n_1 .
  simpl.
  rewrite IHn.
  rewrite plus_n_1.
  rewrite div2_mult2_plus.
  rewrite <- mult_2_n_plus.
  rewrite doido.
  rewrite add_assoc.
  rewrite doido.
  rewrite doido.
  rewrite add_assoc.
  rewrite add_assoc.
  simpl.
  reflexivity.
  Qed.
  