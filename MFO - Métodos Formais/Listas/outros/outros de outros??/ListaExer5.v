(* Exercícios - Expressões Regulares *)
(* Lucas Thomas de Oliveira *)

Require Export Coq.Init.Logic.
Require Export Coq.Bool.Bool.
Require Export Coq.Lists.List.
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

Fixpoint reg_exp_of_list {T} (l : list T) :=
  match l with
  | [] => EmptyStr
  | x :: l' => App (Char x) (reg_exp_of_list l')
  end.


(* Exercício 1*)
(* Dica pode ser necessário o uso da tática [generalize dependent]. *)

Lemma reg_exp_of_list_spec : forall T (s1 s2 : list T),
  s1 =~ reg_exp_of_list s2 <-> s1 = s2.
Proof.
  intros T s1 s2. 
  generalize dependent s1.
  induction s2 as [|h t].
  - (* s2 = [] *)
    split. 
    + intros H. simpl in H. inversion H. reflexivity.
    + intros H. simpl. rewrite H. apply MEmpty.
  - (* s2 = h::t *)
    intros s1. split. 
    + intros H. simpl in H. inversion H. 
      inversion H3. simpl. 
      rewrite (IHt s2) in H4. rewrite H4. reflexivity.
    + intros H. simpl. rewrite H.
      assert ( A : forall S (x:S) y, [x]++y = x::y).
      {  intros S x y. simpl. reflexivity.  }
      rewrite <- A. apply MApp.
      * apply MChar.
      * apply IHt. reflexivity.
Qed.

Fixpoint re_not_empty {T : Type} (re : @reg_exp T) : bool :=
  match re with
    | EmptySet => false
    | EmptyStr => true
    | Char _ => true
    | App re1 re2 => andb (re_not_empty re1) (re_not_empty re2)
    | Union re1 re2 => orb (re_not_empty re1) (re_not_empty re2)
    | Star re1 => true
end.

(* Exercício 2*)
Lemma re_not_empty_correct : forall T (re : @reg_exp T),
  (exists s, s =~ re) <-> re_not_empty re = true.
Proof.
  intros.
  split.
  - intros.
    destruct H.
    induction H.
    + reflexivity.
    + reflexivity.
    + simpl.
      rewrite -> IHexp_match1.
      rewrite -> IHexp_match2.
      reflexivity.
    + simpl.
      apply orb_true_iff.
      left. apply IHexp_match.
    + simpl.
      apply orb_true_iff.
      right. apply IHexp_match.
    + reflexivity.
    + reflexivity.
  - intros.
    induction re.
    + inversion H.
    + exists [].
      apply MEmpty.
    + exists [t].
      apply MChar.
    + simpl in H.
      apply andb_true_iff in H.
      destruct H.
      apply IHre1 in H. apply IHre2 in H0.
      destruct H. destruct H0.
      exists (x ++ x0).
      apply MApp.
      * apply H.
      * apply H0.
    + simpl in H.
      apply orb_true_iff in H.
      destruct H.
      * apply IHre1 in H.
        destruct H.
        exists x.
        apply MUnionL. apply H.
      * apply IHre2 in H.
        destruct H.
        exists x.
        apply MUnionR. apply H.
    + exists [].
      apply MStar0.
Qed.
(* Exercício 3*)
Lemma MStar'' : forall T (s : list T) (re : reg_exp),
  s =~ Star re ->
  exists ss : list (list T),
    s = fold_right (@app T) [] ss
    /\ forall s', In s' ss -> s' =~ re.
Proof.
  intros T s re H.
  remember (Star re) as re'.
  induction H
    as [|x'|s1 re1 s2 re2 Hmatch1 IH1 Hmatch2 IH2
        |s1 re1 re2 Hmatch IH|re1 s2 re2 Hmatch IH
        |re''|s1 s2 re'' Hmatch1 IH1 Hmatch2 IH2].
  - inversion Heqre'.
  - inversion Heqre'.
  - inversion Heqre'.
  - inversion Heqre'.
  - inversion Heqre'.
  - (* Star 0 *)
    exists []. split.
    + reflexivity. 
    + intros s' H. inversion H.
  - (* Star  *)
    destruct (IH2 Heqre') as [ss' [L R]].
    exists (s1::ss'). split.
    + simpl. rewrite <- L. reflexivity.
    + intros s' H. destruct H.
      { rewrite <- H. inversion Heqre'. rewrite H1 in Hmatch1. apply Hmatch1. }
      { apply R. apply H. }
Qed.