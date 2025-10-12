Require Import Coq.Lists.List.
Require Import Coq.Arith.Arith.
(** ** Exercício 1 - Números Binários 
 Nome:  Herton Silveira
 Todas as definições devem estar contidas nesse arquivo, não importar outros módulos.*)

(** É possível representar números naturais de forma binária como uma listas de zeros 
    (representado por B0) e uns (representado por B1). O contrutor de dados Z representa 
    a lista vázia. Por exemplo:

    
        decimal               binário                          unário
           0                       Z                              O
           1                    B1 Z                            S O
           2                B0 (B1 Z)                        S (S O)
           3                B1 (B1 Z)                     S (S (S O))
           4            B0 (B0 (B1 Z))                 S (S (S (S O)))
           5            B1 (B0 (B1 Z))              S (S (S (S (S O))))
           6            B0 (B1 (B1 Z))           S (S (S (S (S (S O)))))
           7            B1 (B1 (B1 Z))        S (S (S (S (S (S (S O))))))
           8        B0 (B0 (B0 (B1 Z)))    S (S (S (S (S (S (S (S O)))))))

  Note que para facilitar as operações a lista é definida com os bits mais significativos
  à direita. *)    


Inductive bin : Type :=
  | Z
  | B0 (n : bin) (* Adiciona um '0' à direita *)
  | B1 (n : bin). (* Adiciona um '1' à direita *)

(** Implemente uma função que incrementa um valor binário: *)

Fixpoint incr (m:bin) : bin :=
  match m with
  | Z    => B1 Z
  | B0 n => B1 n
  | B1 n => B0 (incr(n)) 
  end.

(** Implemente uma função que converta um número binário para natural: *)


Fixpoint bin_to_nat (m:bin) : nat :=
  match m with
  | Z    => 0  
  | B0 n => bin_to_nat(n) * 2     (* Se n representa o decimal N, então B0 n representa N * 2 *)
  | B1 n => bin_to_nat(n) * 2 + 1 (* Se n representa o decimal N, então B1 n representa N * 2 + 1 *)
  end.

(* Faça os seguintes testes unitários: *)
(*
Sempre que você estiver testando a computação de uma função definida por 
Fixpoint ou Definition para um resultado específico, simpl seguido de reflexivity 
é a sua combinação de táticas principal.
*)
Example test_bin_incr1 : (incr (B1 Z)) = B0 (B1 Z).
Proof.
  simpl.        (* Esta tática vai computar incr (B1 Z) para B0 (B1 Z) *)
  reflexivity.  (* Agora que ambos os lados são B0 (B1 Z), eles são idênticos *)
Qed.

Example test_bin_incr2 : (incr (B0 (B1 Z))) = B1 (B1 Z).
Proof.
  simpl.        
  reflexivity.  
Qed.

Example test_bin_incr3 : (incr (B1 (B1 Z))) = B0 (B0 (B1 Z)).
Proof.
  simpl.        
  reflexivity.  
Qed.

Example test_bin_incr4 : bin_to_nat (B0 (B1 Z)) = 2.
Proof.
  simpl.        
  reflexivity.  
Qed.

Example test_bin_incr5 :
        bin_to_nat (incr (B1 Z)) = 1 + bin_to_nat (B1 Z).
Proof.
  simpl.
  reflexivity.       
Qed.

Example test_bin_incr6 :
        bin_to_nat (incr (incr (B1 Z))) = 2 + bin_to_nat (B1 Z).
Proof.
  simpl.        
  reflexivity.  
Qed.
(** Prove as transformações definidas no seguinte diagrama:

                            incr
              bin ----------------------> bin
               |                           |
    bin_to_nat |                           |  bin_to_nat
               |                           |
               v                           v
              nat ----------------------> nat
                             S


*)

Theorem bin_to_nat_pres_incr : forall b : bin, bin_to_nat (incr b) = 1 + bin_to_nat b.
Proof.
  intros b.
  induction b as [| n IHn | n IHn].

  (* Caso 1: b = Z *)
  - simpl. simpl. reflexivity.

  (* Caso 2: b = B0 n *)
  - simpl.
    rewrite Nat.add_comm.
    reflexivity.

  (* Caso 3: b = B1 n *)
  - simpl.
    rewrite IHn.
    rewrite Nat.mul_add_distr_r.
    simpl.
    (* O goal aqui é: 2 + bin_to_nat n * 2 = 1 + (bin_to_nat n * 2 + 1) *)
    (* Para evitar múltiplos rewrites de add_comm, podemos usar 'ring' *)
    ring. (* Esta tática resolve igualdades aritméticas automaticamente *)
Qed.

(** Declare uma função que converta números naturais em binários: *)

Fixpoint nat_to_bin (n:nat) : bin := 
  match n with
  | 0   => Z
  | S n => incr (nat_to_bin n) (*n+1 é S n*)
  end.

Example nat_to_bin_teste : (nat_to_bin(8)) = B0 (B0 (B0 (B1 Z))).
Proof.
  simpl.        
  reflexivity.  
Qed.

Lemma bin_to_nat_incr : forall b, bin_to_nat (incr b) = S (bin_to_nat b).
Proof.
  induction b as [| b' IHb' | b' IHb'].
  - (* Caso: b = Z *)
    simpl.
    reflexivity.
  - (* Caso: b = B0 b' *)
    simpl.
    (* O objetivo agora é: 2 * bin_to_nat b' + 1 = S (2 * bin_to_nat b') *)
    lia. (* <<-- AQUI ESTÁ A CORREÇÃO *)
  - (* Caso: b = B1 b' *)
    simpl.
    (* O objetivo é: 2 * bin_to_nat (incr b') = S (S (2 * bin_to_nat b')) *)
    rewrite IHb'.
    (* O objetivo agora é: 2 * S (bin_to_nat b') = S (S (2 * bin_to_nat b')) *)
    lia. (* lia também resolve este caso facilmente *)
Qed.
(** Prove que as conversões podem ser revertidas: *)

Theorem nat_bin_nat : forall n, bin_to_nat (nat_to_bin n) = n.
Proof.
  (* Provaremos por indução sobre n *)
  induction n as [| n' IHn'].

  - (* Caso base: n = 0 *)
    simpl. (* Converte o objetivo para bin_to_nat Z = 0 *)
    reflexivity. (* Prova 0 = 0 *)

  - (* Passo indutivo: n = S n' *)
    (* Hipótese de Indução (IHn'): bin_to_nat (nat_to_bin n') = n' *)
    simpl. (* Converte o objetivo para bin_to_nat (incr (nat_to_bin n')) = S n' *)

    (* Aqui usamos nosso lema auxiliar para reescrever o lado esquerdo *)
    rewrite bin_to_nat_incr.
    (* O objetivo agora é: S (bin_to_nat (nat_to_bin n')) = S n' *)

    (* Agora podemos usar nossa hipótese de indução *)
    rewrite IHn'.
    (* O objetivo final é: S n' = S n', que é trivialmente verdade *)
    reflexivity.
Qed.

Fixpoint normalize (b:bin) : bin
 (* Coloque a definição aqui *). Admitted.

Theorem bin_nat_bin : forall b, nat_to_bin (bin_to_nat b) = normalize b.
Proof.
   Admitted.

(* Pesquise sobre a necessidade da função normalize no capítulo Induction. *) 


