/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */

/**
 *
 * @author rebeca
 */

public class VaraBean {
   private int idVara;
   private String nome;
   private String tipo;
   private String entrancia;

   public VaraBean(int idVara, String nome, String tipo, String entrancia) {
       this.idVara = idVara;
       this.nome = nome;
       this.tipo = tipo;
       this.entrancia = entrancia;
   }

   public VaraBean(String nome, String tipo, String entrancia) {
       this.nome = nome;
       this.tipo = tipo;
       this.entrancia = entrancia;
   }

   public int getIdVara() {
       return idVara;
   }

   public void setIdVara(int idVara) {
       this.idVara = idVara;
   }

   public String getNome() {
       return nome;
   }

   public void setNome(String nome) {
       this.nome = nome;
   }

   public String getTipo() {
       return tipo;
   }

   public void setTipo(String tipo) {
       this.tipo = tipo;
   }

   public String getEntrancia() {
       return entrancia;
   }

   public void setEntrancia(String entrancia) {
       this.entrancia = entrancia;
   }

   @Override
   public String toString() {
       return "id_vara: " + idVara + ", nome: " + nome + ", tipo: " + tipo + ", entrancia: " + entrancia;
   }
}