(* Nenhum outro arquivo deve ser importado.

Nome: Lucas Thomas de Oliveira  *)

Require Import Coq.Arith.PeanoNat.

(* Podemos definir uma representação binária dos números naturais por meio de dois 
construtores que representam 0s e 1s (B0 e B1), e um marcador de final da sequência Z. 

Por exemplo:


        decimal               Binary                          unary
           0                    B0 Z                              O
           1                    B1 Z                            S O
           2                B0 (B1 Z)                        S (S O)
           3                B1 (B1 Z)                     S (S (S O))
           4            B0 (B0 (B1 Z))                 S (S (S (S O)))
           5            B1 (B0 (B1 Z))              S (S (S (S (S O))))
           6            B0 (B1 (B1 Z))           S (S (S (S (S (S O)))))
           7            B1 (B1 (B1 Z))        S (S (S (S (S (S (S O))))))
           8        B0 (B0 (B0 (B1 Z)))    S (S (S (S (S (S (S (S O)))))))

Note que o bit menos significativo fica a esquerda da sequência.

*)

Inductive bin : Type :=
  | Z
  | B0 (n : bin)
  | B1 (n : bin).

(* Complete as definições abaixo, sendo incr uma função que incrementa um número
binário e bin_to_nat a função que converte um binário em natural: *)

Fixpoint incr (m:bin) : bin:=
  match m with
    | Z => B1 Z
    | B0 n => B1 n
    | B1 n => B0 (incr n)
  end.


Fixpoint bin_to_nat (m:bin) : nat :=
  match m with 
    | Z => 0
    | B0 n => 2 * (bin_to_nat n)
    | B1 n => 1 + 2 * (bin_to_nat n)
  end.

(* Declare uma função que converta natural para binário: *)

Fixpoint nat_to_bin (n:nat) : bin:=
  match n with
    | 0 => Z
    | S n' => incr (nat_to_bin n')
  end.

(* Prove que as tranformações definididas no diagrama abaixo são válidas: 

                           incr
              bin ----------------------> bin
               |                           |
    bin_to_nat |                           |  bin_to_nat
               |                           |
               v                           v
              nat ----------------------> nat
                             S

*)    

Theorem bin_to_nat_pres_incr : forall b : bin,
  bin_to_nat (incr b) = 1 + bin_to_nat b.
Proof.
  intros b.
  induction b as [| b' | b'' IHb'].
    - simpl. reflexivity.
    - simpl. reflexivity.
    - simpl. rewrite -> IHb'. rewrite <- Nat.add_shuffle1. reflexivity.
Qed.

Theorem nat_bin_nat : forall n, bin_to_nat (nat_to_bin n) = n.
Proof.
  intros.
  induction n as [| n' IH].
  - reflexivity.
  - simpl. rewrite -> bin_to_nat_pres_incr. rewrite -> IH. reflexivity.
Qed.

