(* Exame Métodos Formais 
   Nome:  Herton Silveira*)

(* Todas as declarações devem ser feitas nesse arquivo,
   não deve ser importado nenhum módulo adicional. *)

Require Import Arith.
Require Import Coq.Lists.List.
Import ListNotations.

(* Questão 1 *)

Theorem or_distributes_over_and : forall P Q R : Prop,
  P \/ (Q /\ R) <-> (P \/ Q) /\ (P \/ R).
Proof.
  intros.
  split.
  - intros. split.
    * destruct H. left. apply H. destruct H. right. apply H.
    * destruct H. left. apply H. right. apply H.
  - intros. destruct H. destruct H, H0.
    * left. apply H.
    * left. apply H.
    * left. apply H0.
    * right. split.
      + apply H.
      + apply H0.
Qed.

(* Questão 2 *)

Fixpoint index {X : Set} (n : nat) (l : list X) : option X :=
  match l with
  | [] => None
  | h :: t => if n =? 0 then Some h else index (pred n) t
  end.

Theorem index_map : forall {X Y:Set} (n:nat) (f:X->Y) (l:list X) (x:X), 
  index n l = Some x -> Some (f x) = index n (map f l).
Proof.
  intros X Y n f l x H.
  (* Generalizamos n porque ele muda na recursão (pred n) *)
  generalize dependent n.
  induction l as [|h t IHl].
  - (* Caso Base: Lista vazia *)
    intros n H. simpl in H. discriminate H.
  - (* Passo Indutivo *)
    intros n H. simpl in *.
    destruct n.
    + (* n = 0 *)
      inversion H; subst. reflexivity.
    + (* n = S n' *)
      apply IHl. apply H.
Qed.


(* Questão 3 *)

Search (min).
(* Nota: A biblioteca Arith já possui Nat.min_l e Nat.max_r, 
   mas aqui faremos a prova manual por indução. *)

Theorem min_correct : forall (a b:nat), a <= b -> min a b = a /\ max a b = b.
Proof.
  intros a. induction a as [|a' IHa].
  - (* Caso a = 0 *)
    intros b H. simpl. split; reflexivity.
  - (* Caso a = S a' *)
    intros b H.
    destruct b as [|b'].
    + (* b = 0 *)
      inversion H. (* S a' <= 0 é impossível *)
    + (* b = S b' *)
      simpl.
      (* Sabemos que S a' <= S b' implica a' <= b' *)
      assert (H_le: a' <= b'). { apply le_S_n. apply H. }
      (* Aplicamos a Hipótese de Indução *)
      destruct (IHa b' H_le) as [Hmin Hmax].
      split.
      * rewrite Hmin. reflexivity.
      * rewrite Hmax. reflexivity.
Qed.

(* Questão 4 *)

Inductive myle : nat -> nat -> Prop :=
  | myle_0 m : myle 0 m
  | myle_S n m (H : myle n m) : myle (S n) (S m).

(* Lema Auxiliar: Se n <= m, então n <= S m.
   Necessário para provar a questão 4. *)
Lemma myle_n_Sm : forall n m, myle n m -> myle n (S m).
Proof.
  intros n m H.
  induction H.
  - apply myle_0.
  - apply myle_S. apply IHmyle.
Qed.

Lemma myle_Sn_m : forall a b, myle (S a) b -> myle a b.
Proof.
  intros a b H.
  (* Invertemos a hipótese:
     Se myle (S a) b, a única construção possível é myle_S.
     Isso implica que b deve ser (S m) e que vale (myle a m). *)
  inversion H. subst.
  (* Agora temos: H1 : myle a m. Queremos provar: myle a (S m).
     Usamos o lema auxiliar criado acima. *)
  apply myle_n_Sm.
  apply H1.
Qed.
