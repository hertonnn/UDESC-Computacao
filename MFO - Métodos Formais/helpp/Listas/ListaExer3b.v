(** * Métodos Formais - Lista de Exercícios 3 
 Não importar nenhum outro módulo.*)


Require Import Coq.Lists.List.
Import ListNotations.


Fixpoint fold {X Y: Type} (f: X->Y->Y) (l: list X) (b: Y)
                         : Y :=
  match l with
  | nil => b
  | h :: t => f h (fold f t b)
  end.


(** O tamanho da lista resultante da concatenação de duas listas é
    igual a soma dos tamanhos das listas, prove esse teorema *)


Lemma app_length : forall (X:Type) (l1 l2 : list X),
  length (l1 ++ l2) = length l1 + length l2.
Proof.
   Admitted.


(** A operação de reverso é distributiva em relação a concatenação, prove 
    esse teorema *)
    
Theorem rev_app_distr: forall X (l1 l2 : list X),
  rev (l1 ++ l2) = rev l2 ++ rev l1.
Proof.
  Admitted.

(** Informalmente podemos dizer, que o seguinte teorema estabelece que a 
    função [fold] é comutativa em relação a concatenação ([++]), prove esse 
    teorema: *)
 
Theorem app_comm_fold :forall {X Y} (f: X->Y->Y) l1 l2 b,
  fold f (l1 ++ l2) b = fold f l1 (fold f l2 b).
Proof.
  Admitted.
 

(** Como visto no módulo [Poly.v], muitas funções sobre listas podem ser 
    implementadas usando a função [fold], por exemplo, a função a função 
    que retorna o número de elementos de uma listas pode ser implementada 
    como: *)

Definition fold_length {X : Type} (l : list X) : nat. Admitted.

(** Prove que [fold_length] retorna a número de elementos de uma lista.
    Para facilitar essa prova demostre o lema [fold_length_head]. Dica
    as vezes a tática [reflexivty] aplica uma simplificação mais agressiva 
    que a tática [simpl], isso seŕá util na prova desse lema. *) 

Lemma fold_length_head : forall X (h : X) (t : list X),
  fold_length (h::t) = S (fold_length t).
Proof. Admitted.

Theorem fold_length_correct : forall X (l : list X),
  fold_length l = length l.
Proof. Admitted.

(** Também é possível definir a função [map] por meio da função [fold],
    faça essa definição *)

Definition fold_map {X Y: Type} (f: X -> Y) (l: list X) : list Y. Admitted. 

Example test_fold_map : fold_map (mult 2) [1; 2; 3] = [2; 4; 6].
Proof. Admitted. 

(** Prove que [fold_map] tem um comportamento identico a [map], defina lemas 
    auxiliares se necessário *)

Theorem fold_map_head : forall X Y (f: X -> Y) (h: X) (t: list X),
  fold_map f (h::t) = f h :: fold_map f t.
Proof. 
  Admitted.

Theorem fold_map_correct : forall X Y (f: X -> Y) (l: list X),
  fold_map f l = map f l.
Proof. 
  Admitted.

(** Podemos imaginar que a função [fold] coloca uma operação binária entre
    cada elelento de uma lista, por exemplo, [fold plus [1; 2; 3] 0] é igual 
    (1+(2+(3+0))). Da forma que foi declarada a função [fold] a operação 
    binária é executada da direita para esquerda. Declare uma função [foldl]
    que aplique a operação da esquerda para direita: *)

Fixpoint foldl {X Y: Type} (f: Y->X->Y) (b: Y) (l: list X)
                         : Y. Admitted.


(** Exemplo: [foldl minus 10 [1; 2; 3]] igual (((10-1)-2)-3). *)

Example test_foldl : foldl minus 10 [1; 2; 3] = 4.
Proof. Admitted.




