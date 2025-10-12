Require Import Coq.Lists.List.
Import ListNotations.


Inductive reg_exp (T : Type) : Type :=
  | EmptySet
  | EmptyStr
  | Char (t : T)
  | App (r1 r2 : reg_exp T)
  | Union (r1 r2 : reg_exp T)
  | Star (r : reg_exp T).

Arguments EmptySet {T}.
Arguments EmptyStr {T}.
Arguments Char {T} _.
Arguments App {T} _ _.
Arguments Union {T} _ _.
Arguments Star {T} _.

Reserved Notation "s =~ re" (at level 80).

Inductive exp_match {T} : list T -> reg_exp T -> Prop :=
  | MEmpty : [] =~ EmptyStr
  | MChar x : [x] =~ (Char x)
  | MApp s1 re1 s2 re2
             (H1 : s1 =~ re1)
             (H2 : s2 =~ re2)
           : (s1 ++ s2) =~ (App re1 re2)
  | MUnionL s1 re1 re2
                (H1 : s1 =~ re1)
              : s1 =~ (Union re1 re2)
  | MUnionR re1 s2 re2
                (H2 : s2 =~ re2)
              : s2 =~ (Union re1 re2)
  | MStar0 re : [] =~ (Star re)
  | MStarApp s1 s2 re
                 (H1 : s1 =~ re)
                 (H2 : s2 =~ (Star re))
               : (s1 ++ s2) =~ (Star re)

  where "s =~ re" := (exp_match s re).

(* Questão 1 *)
Lemma union_inv : forall T (s : list T) (r1 r2 : reg_exp T),
   s =~ r1 \/ s =~ r2 <-> s =~ Union r1 r2.
Proof.
  Admitted.


(* Questão 2 *)

Theorem app_dist_union1 : forall T (s : list T) (r1 r2 r3 : reg_exp T),
  s =~ App (Union r1 r2) r3 -> s =~ Union (App r1 r3) (App r2 r3).
Proof.
  Admitted.

(* Questão 3 *)
Theorem app_dist_union2 : forall T (s : list T) (r1 r2 r3 : reg_exp T),
  s =~ Union (App r1 r3) (App r2 r3) -> s =~ App (Union r1 r2) r3.
Proof.
  Admitted. 

(* Questão 4 *)
Theorem neutral_app1 : forall T (s : list T) (r: reg_exp T),
  s =~ App EmptyStr r /\ s =~ App r EmptyStr -> s =~ r.
Proof.
  Admitted.

(* Questão 5 *)
Theorem neutral_app2 : forall T (s : list T) (r: reg_exp T),
  s =~ r -> s =~ App EmptyStr r /\ s =~ App r EmptyStr.
Proof.
  Admitted.







