Require Import Coq.Lists.List.
Import ListNotations.


Inductive reg_exp {T : Type} : Type :=
  | EmptySet
  | EmptyStr
  | Char (t : T)
  | App (r1 r2 : reg_exp)
  | Union (r1 r2 : reg_exp)
  | Star (r : reg_exp).

Inductive exp_match {T} : list T -> reg_exp -> Prop :=
  | MEmpty : exp_match [] EmptyStr
  | MChar x : exp_match [x] (Char x)
  | MApp s1 re1 s2 re2
             (H1 : exp_match s1 re1)
             (H2 : exp_match s2 re2) :
             exp_match (s1 ++ s2) (App re1 re2)
  | MUnionL s1 re1 re2
                (H1 : exp_match s1 re1) :
                exp_match s1 (Union re1 re2)
  | MUnionR re1 s2 re2
                (H2 : exp_match s2 re2) :
                exp_match s2 (Union re1 re2)
  | MStar0 re : exp_match [] (Star re)
  | MStarApp s1 s2 re
                 (H1 : exp_match s1 re)
                 (H2 : exp_match s2 (Star re)) :
                 exp_match (s1 ++ s2) (Star re).

Notation "s =~ re" := (exp_match s re) (at level 80).

Lemma union_inv : forall T (s : list T) (r1 r2 : reg_exp),
   s =~ r1 \/ s =~ r2 <-> s =~ Union r1 r2.
Proof.
  intros T s r1 r2. split.
  - intros H. destruct H as [H1 | H2].
    + apply MUnionL. apply H1.
    + apply MUnionR. apply H2.
  - intros H. inversion H.
    + left. apply H2.
    + right. apply H1.
Qed.



Theorem app_dist_union1 : forall T (s : list T) (r1 r2 r3 : reg_exp),
  s =~ App (Union r1 r2) r3 -> s =~ Union (App r1 r3) (App r2 r3).
Proof.
  intros T s r1 r2 r3 H. rewrite <- union_inv.
  inversion H. apply union_inv in H3. 
  destruct H3 as [H3' | H3'].
  - left. apply MApp. apply H3'. apply H4.
  - right. apply MApp. apply H3'. apply H4.
Qed.

Theorem app_dist_union2 : forall T (s : list T) (r1 r2 r3 : reg_exp),
  s =~ Union (App r1 r3) (App r2 r3) -> s =~ App (Union r1 r2) r3.
Proof.
  intros T s r1 r2 r3 H. apply union_inv in H.
  destruct H as [H1 | H1].
  - inversion H1. apply MApp. apply MUnionL. 
    apply H3. apply H4.
  - inversion H1. apply MApp. apply MUnionR.
    apply H3. apply H4.
Qed.

Theorem neutral_app1 : forall T (s : list T) (r: reg_exp),
  s =~ App EmptyStr r /\ s =~ App r EmptyStr -> s =~ r.
Proof.
  intros T s r [H1 H2]. inversion H1. inversion H4.
    simpl. apply H5.
Qed.

Theorem neutral_app2 : forall T (s : list T) (r: reg_exp),
  s =~ r -> s =~ App EmptyStr r /\ s =~ App r EmptyStr.
Proof.
  intros T s r H. split.
  - apply MApp with (s1 := nil) (s2 := s). apply MEmpty.
    apply H.
  - assert (Happ : s = s ++ []). {rewrite app_nil_r. reflexivity. }   
    rewrite Happ. apply MApp. apply H. apply MEmpty.
Qed.






