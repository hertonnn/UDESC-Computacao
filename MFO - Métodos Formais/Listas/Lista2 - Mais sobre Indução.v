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
 Admitted.

Search ( _ * _ ).

Theorem plus_n_Sm : forall (n m:nat),
  n + S m = S (n + m).
Proof. 
  Admitted.

Theorem mult_2_n_plus : forall (n : nat),
  n + n = 2 * n.
Proof.
  Admitted.

Print Nat.mul_succ_l.

Theorem mul2_div2 : forall n : nat,
  n = div2 (2 * n).
Proof.
  Admitted.

Theorem div2_mult2_plus: forall (n m : nat),
  n + div2 m = div2 (2 * n + m).
Proof.
  Admitted.
    

Theorem mult_Sn_m : forall (n m : nat),
  S n * m = m + n * m.
Proof.
  Admitted.

Theorem sum_Sn : forall n : nat,
  sum (S n) = S n + sum n.
Proof.
  Admitted.


Theorem sum_n : forall n : nat,
  sum n = div2 (n * (n + 1)).
Proof.
  Admitted.