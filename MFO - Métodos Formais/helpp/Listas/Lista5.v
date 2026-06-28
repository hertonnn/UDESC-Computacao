Require Export Coq.Lists.List.
Import ListNotations.

Theorem dist_not_exists : forall (X:Type) (P : X -> Prop),
  (forall x, P x) -> ~ (exists x, ~ P x).
Proof.
  unfold not. intros X P H H_exists.
  destruct H_exists as [x H_not_Px].
  unfold not in H_not_Px.
  apply H_not_Px.
  apply H.
Qed.

Theorem dist_exists_or : forall (X:Type) (P Q : X -> Prop),
  (exists x, P x \/ Q x) <-> (exists x, P x) \/ (exists x, Q x).
Proof.
  intros X P Q.
  split.
  - (* -> *)
    intros H_exists.
    destruct H_exists as [x H_or].
    destruct H_or as [HP | HQ].
    + left. exists x. apply HP.
    + right. exists x. apply HQ.
  - (* <- *)
    intros [H_exists_P | H_exists_Q].
    + destruct H_exists_P as [x HP].
      exists x. left. apply HP.
    + destruct H_exists_Q as [x HQ].
      exists x. right. apply HQ.
Qed.

Theorem dist_exists_and : forall (X:Type) (P Q : X -> Prop),
  (exists x, P x /\ Q x) -> (exists x, P x) /\ (exists x, Q x).
Proof.
  intros X P Q H_exists_and.
  destruct H_exists_and as [x H_and].
  destruct H_and as [HP HQ].
  split.
  - exists x. apply HP.
  - exists x. apply HQ.
Qed.

Fixpoint In {A : Type} (x : A) (l : list A) : Prop :=
  match l with
  | [] => False
  | x' :: l' => x' = x \/ In x l'
  end.

Lemma In_map :
  forall (A B : Type) (f : A -> B) (l : list A) (x : A),
    In x l ->
    In (f x) (map f l).
Proof.
  intros A B f l x.
  induction l as [| a l' IHl'].
  - (* Caso base: l = [] *)
    intros H_in. inversion H_in.
  - (* Passo indutivo: l = a :: l' *)
    simpl. intros [H_eq | H_in_l'].
    + (* Caso x = a *)
      rewrite H_eq. left. reflexivity.
    + (* Caso In x l' *)
      right. apply IHl'. apply H_in_l'.
Qed.

Theorem excluded_middle_irrefutable: forall (P:Prop),
  ~ ~ (P \/ ~ P).
Proof.
  intros P H.
  apply H.
  right.
  intros HP.
  apply H.
  left.
  apply HP.
Qed.

Theorem disj_impl : forall (P Q: Prop),
 (~P \/ Q) -> P -> Q.
Proof.
  intros P Q H_or HP.
  destruct H_or as [H_notP | HQ].
  - unfold not in H_notP. contradiction (H_notP HP).
  - apply HQ.
Qed.

Theorem Peirce_double_negation: forall (P:Prop), (forall P Q: Prop,
  (((P->Q)->P)->P)) -> (~~ P -> P).
Proof.
  intros P H H_not_not_P.
  unfold not in H_not_not_P.
  apply (H P False).
  intros H_P_implies_False.
  exfalso.
  apply (H_not_not_P H_P_implies_False).
Qed.

Theorem double_negation_excluded_middle : forall (P:Prop),
  (forall (P:Prop), (~~ P -> P)) -> (P \/ ~P).
Proof.
  intros P H_dne.
  apply H_dne.
  apply excluded_middle_irrefutable.
Qed.
