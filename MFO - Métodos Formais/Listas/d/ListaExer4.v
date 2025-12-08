(*  Lucas Thomas de Oliveira   *)

Require Export Arith.


Theorem O_le_n : forall n,
  0 <= n.
Proof.
  intros.
  induction n as [| n' IH].
  - apply le_n.
  - apply le_S. apply IH.
Qed.

Print le_n.

Theorem n_le_m__Sn_le_Sm : forall n m,
  n <= m -> S n <= S m.
Proof.
  intros.
  induction H.
  - apply le_n.
  - apply le_S.
    apply IHle.
Qed.

Lemma n_le_m__Sn_le_Sm' : forall a b, a <= b -> S a <= S b.
Proof.
  intros.
  induction H.
  - apply le_n.
  - apply le_S.
    apply IHle.
Qed.

Lemma le_trans : forall m n o, m <= n -> n <= o -> m <= o.
Proof.
  intros.
  induction H0.
  - apply H.
  - apply le_S. apply IHle.
Qed.


Theorem n_le_Sn: forall n,
  n <= S n.
Proof.
  intros. apply le_S. apply le_n.
Qed.

Theorem Sn_le_Sm__n_le_m : forall n m,
  S n <= S m -> n <= m.
Proof.
  intros.
  inversion H.
  - apply le_n.
  - apply le_trans with (n:=S n).
    + apply n_le_Sn.
    + apply H1.
Qed.



Theorem le_plus_l : forall a b,
  a <= a + b.
Proof.
  intros.
  induction a as [| a' IH].
  - apply O_le_n.
  - simpl.
    apply n_le_m__Sn_le_Sm.
    apply IH.
Qed.

Theorem lt_ge_cases : forall n m,
  n < m \/ n >= m.
Proof.
  Admitted.

Inductive le' : nat -> nat -> Prop :=
  | le_0' m : le' 0 m
  | le_S' n m (H : le' n m) : le' (S n) (S m).

Lemma n_le'_m__Sn_le'_Sm : forall a b, le' a b -> le' (S a) (S b).
Proof.
  intros. apply le_S'. apply H.
Qed.

Lemma le'_n_n : forall a, le' a a.
Proof.
  intros. induction a. apply le_0'. apply le_S'. apply IHa.
Qed. 
  
Lemma le'_n_Sm : forall a b, le' a b -> le' a (S b). 
Proof.
  intros. generalize dependent b. induction a.
  - intros. apply le_0'.
  - intros. induction b.
    + inversion H.
    + apply le_S'. apply IHa. inversion H. apply H2.
Qed. 


Theorem le_le' : forall a b, le a b <-> le' a b.
Proof.
  split.
  - intros. generalize dependent a. induction b.
    + intros. inversion H. apply le_0'.
    + intros. destruct a.
      * apply le_0'. 
      * apply le_S'. apply IHb. Search le. apply le_S_n in H. apply H.
  - generalize dependent a. induction b.
    + intros. inversion H. apply le_0_n.
    + intros. induction a.
      * apply le_0_n.
      * Search le. apply le_n_S. apply IHb. inversion H. apply H2.
Qed.

Theorem plus_lt : forall n1 n2 m,
  n1 + n2 < m ->
  n1 < m /\ n2 < m.
Proof.
 unfold lt.
 intros.
 split.
 - assert (I: S n1 <= S (n1 + n2)).
    { apply n_le_m__Sn_le_Sm. apply le_plus_l. }
   apply (le_trans (S n1) (S (n1 + n2)) m I) in H.
   apply H.
 - assert (I: S n2 <= S (n1 + n2)).
    { apply n_le_m__Sn_le_Sm. 
      rewrite -> plus_comm.
      apply le_plus_l. }
   apply (le_trans (S n2) (S (n1 + n2)) m I) in H.
   apply H.
Qed.

Theorem Sn_le_m__n_le_m: forall n m,
  (S n) <= m -> n <= m.
Proof.
  intros.
  apply (le_trans n (S n) m (n_le_Sn n)) in H.
  apply H.
Qed.

Theorem lt_S : forall n m,
  n < m ->
  n < S m.
Proof.
  unfold lt.
  intros.
  apply n_le_m__Sn_le_Sm.
  apply Sn_le_m__n_le_m in H.
  apply H.
Qed.





