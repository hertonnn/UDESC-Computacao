Require Import Coq.Lists.List.
Import ListNotations.

Fixpoint fold {X Y: Type} (f: X->Y->Y) (l: list X) (b: Y) : Y :=
  match l with
  | nil => b
  | h :: t => f h (fold f t b)
  end.

Lemma app_length : forall (X:Type) (l1 l2 : list X),
  length (l1 ++ l2) = length l1 + length l2.
Proof.
  intros X l1.
  induction l1 as [| h t IHl1].
  - intros l2. simpl. reflexivity. 
  - intros l2. simpl. rewrite IHl1. reflexivity.
Qed.

Theorem rev_app_distr: forall X (l1 l2 : list X),
  rev (l1 ++ l2) = rev l2 ++ rev l1.
Proof.
  intros X l1.
  induction l1 as [| h t IHl1].

  (* Base Case: l1 = nil *)
  - intros l2.
    simpl.
    rewrite app_nil_r.
    reflexivity.

  (* Inductive Step: l1 = h :: t *)
  - intros l2.
    simpl.
    rewrite IHl1.

    symmetry. 
    apply app_assoc. 
Qed.

Theorem app_comm_fold :forall {X Y} (f: X->Y->Y) l1 l2 b,
  fold f (l1 ++ l2) b = fold f l1 (fold f l2 b).
Proof.
  intros X Y f l1. 
  induction l1 as [| h t IHl1]. 

  (* Base Case: l1 = nil *)
  - intros l2 b. 
    simpl.       
                           
                    
    reflexivity. 


  - intros l2 b. 
    simpl.       
                    
                    
    rewrite IHl1. 
                     
                     
    reflexivity. 
Qed.
Definition fold_length {X : Type} (l : list X) : nat :=
  fold (fun _ n => S n) l 0.
  
Theorem fold_length_correct : forall X (l : list X),
  fold_length l = length l.
Proof. Admitted.

Lemma fold_length_head : forall X (h : X) (t : list X),
  fold_length (h::t) = S (fold_length t).
Proof.
  intros X h t.
  unfold fold_length.
  simpl. 
  reflexivity. 
Qed.
(** Também é possível definir a função [map] por meio da função [fold]. *)

Definition fold_map {X Y: Type} (f: X -> Y) (l: list X) : list Y :=
  fold (fun h t => f h::t) l [ ].

Example test_fold_map : fold_map (mult 2) [1; 2; 3] = [2; 4; 6].
Proof. reflexivity. Qed. 

(** Prove que [fold_map] tem um comportamento identico a [map], defina lemas 
    auxiliares se necessário *)
Theorem fold_map_correct : forall X Y (f: X -> Y) (l: list X),
  fold_map f l = map f l.
Proof.
  intros X Y f l.
  induction l as [| h t IHl].
  - (* Caso base: l = nil *)
    unfold fold_map.
    simpl. (* fold em nil resulta no valor inicial ([]). map f nil também é []. *)
    reflexivity.
  - (* Caso indutivo: l = h::t *)
    unfold fold_map.
    simpl. 

    rewrite IHl. 

    reflexivity.
Qed.