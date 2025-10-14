Require Import Coq.Lists.List.
Import ListNotations.

(* 1 - Prove que o quantificador existêncial é distributivo em relação a conjunção: *)

Theorem dist_exists_and : forall (X:Type) (P Q : X -> Prop),
  (exists x, P x /\ Q x) -> (exists x, P x) /\ (exists x, Q x).
Proof.
  intros. split.
  - destruct H as [x [HP HQ]]. exists x. apply HP.
  - destruct H as [x [HP HQ]]. exists x. apply HQ.
Qed.

(* 2 - Prove que se um elemento pertence a concatenação de duas listas então esse 
       elemento pertence a primeira lista ou a segunda *)

Fixpoint In {A : Type} (x : A) (l : list A) : Prop :=
  match l with
  | [] => False
  | x' :: l' => x' = x \/ In x l'
  end.


Lemma In_app_iff : forall A l l' (a:A),
  In a (l++l') <-> In a l \/ In a l'.
Proof.
  intros. induction l.
  - split.
    + intros H. simpl in H. right. apply H.
    + intros H. simpl. destruct H. 
      * simpl in H. destruct H.
      * apply H.
  - split.
    + intros H. simpl in H. destruct H.
      * simpl. left. left. apply H.
      * simpl. rewrite IHl in H. destruct H.
        -- left. right. apply H.
        -- right. apply H.
    + intros H. simpl in H. destruct H.
      * simpl. destruct H.  
        -- left.  apply H.
        -- rewrite IHl. right. left. apply H.
      * simpl. rewrite IHl. right. right. apply H.
Qed.

(* 3 - Prove que: *) 

Fixpoint All {T : Type} (P : T -> Prop) (l : list T) : Prop :=
  match l with
  | [] => True
  | (h :: t) => P h /\ All P t 
  end.

Theorem All_In :
  forall T (P : T -> Prop) (l : list T),
    (forall x, In x l -> P x) <->
    All P l.
Proof.
  intros. induction l.
  - split.
    + intros H. simpl. reflexivity.
    + intros H. simpl. intros x K. destruct K.
  - split.
    + intros H. simpl. split. 
      * apply H. simpl. left. reflexivity.
      * apply IHl. intros x K. apply H. simpl. right. apply K.
    + intros H. intros x J. simpl in J. simpl in H. destruct H as [Ha HP]. destruct J.
      * rewrite <- H. apply Ha.
      * rewrite <- IHl in HP. apply HP. apply H.
Qed.

(* Um problema com a definição da função que retorna o reverso de 
   uma lista [rev] é sua complexidade de tempo quadrática devido as
   sucessivas chamadas a função de concatenação [app].
   Essa execução pode ser melhorada com a seguinte definição: *)

Fixpoint rev_append {X} (l1 l2 : list X) : list X :=
  match l1 with
  | [] => l2
  | x :: l1' => rev_append l1' (x :: l2)
  end.

Definition tr_rev {X} (l : list X) : list X :=
  rev_append l [].

(* 4 - Prove que essa definição é equivalente a de [rev]: *)

Lemma rev_append_app : forall (X:Type) (l1 l2:list X),
  rev_append l1 l2 = rev l1 ++ l2.
Proof.
  intros X l1. induction l1.
  - reflexivity.
  - intros l2.
    + simpl. rewrite IHl1. rewrite <- app_assoc. simpl. reflexivity.
Qed.

Theorem tr_rev_correct : forall (X:Type) (l:list X), tr_rev l = rev l.
Proof.
  intros. induction l.
  - simpl. unfold tr_rev. simpl. reflexivity.
  - simpl. unfold tr_rev. rewrite rev_append_app. simpl. rewrite app_nil_r. reflexivity.
Qed.

(* 5 - Prove que: *)

Lemma eq_cons : forall (X:Type) (l1 l2: list X) (x: X),
  l1 = l2 -> x :: l1 = x :: l2.
Proof.
  intros X l1. induction l1.
  - intros l2 x H. rewrite H. reflexivity.
  - intros l2 x H. rewrite H. reflexivity.
Qed.

Theorem combine_split : forall X Y (l : list (X * Y)) l1 l2,
  split l = (l1, l2) ->
  combine l1 l2 = l.
Proof.
  intros X Y l. induction l.
  - intros l1 l2 H. unfold split in H. injection H as H1 H2. rewrite <- H1. rewrite <- H2. simpl. reflexivity.
  - intros l1 l2 H. simpl in H. destruct a. destruct (split l). injection H as H1 H2.
    rewrite <- H1, <- H2. simpl. f_equal. apply IHl. reflexivity.
Qed.



