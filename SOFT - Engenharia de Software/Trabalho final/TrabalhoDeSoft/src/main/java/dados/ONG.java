/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package dados;
import java.util.ArrayList;
import negocio.Sistema;
import java.util.Date;

/**
 *
 * @author Mariana dos Santos
 */
public class ONG {
    private int IdOng;
    private String nome;
    private String CNPJ;
    private String email;
    private String telefone;
    private Endereco endereco;
    private String senha;
    private String fotoPerfil;
    private ArrayList<Animal> animaisCadastrados;
    private float avaliacao;
    private int numeroAvaliacoes;
    private ArrayList<Comentario> comentarios;
    private ArrayList<Adocao> historicoAdocao;
    private ArrayList<Notificacao> notificacoesRecebidas;

    public ONG(int IdOng, String nome, String CNPJ, String email, String telefone, Endereco endereco, String senha) {
        this.IdOng = IdOng;
        this.nome = nome;
        this.CNPJ = CNPJ;
        this.email = email;
        this.telefone = telefone;
        this.endereco = endereco;
        this.senha = senha;
        this.fotoPerfil = "";
        this.animaisCadastrados = new ArrayList<>();
        this.avaliacao = 0;
        this.numeroAvaliacoes = 0;
        this.comentarios = new ArrayList<>();
        this.historicoAdocao = new ArrayList<>();
        this.notificacoesRecebidas = new ArrayList<>();
    }
    
    public Boolean cadastrarONG(ONG ong, Sistema sistema){
        for(ONG onger : sistema.getOngsCadastradas()){
            if(onger.getEmail().equals(ong.getEmail())){
                return false;
            }
            if(onger.getCNPJ().equals(ong.getCNPJ())){
                return false;
            }
        }
        sistema.getOngsCadastradas().add(ong);
        return true;
    }
    
    public Boolean LoginONG(String email, String senha, Sistema sistema){
        for(ONG onger: sistema.getOngsCadastradas()){
            if(onger.getEmail().equals(email) && onger.getSenha().equals(senha)){
                return true;
            }
        }
        return false;
    }
    
    public Boolean cadastrarAnimal(Animal animal, Sistema sistema){
        if (this.animaisCadastrados.contains(animal)) {
            return false; 
        }else{
            this.animaisCadastrados.add(animal);
            sistema.getAnimaisCadastrados().add(animal);
            return true;
        }
    }
    
    public Boolean excluirAnimal(Animal animal, Sistema sistema){
        if (this.animaisCadastrados.contains(animal)) {
            this.animaisCadastrados.remove(animal);
            sistema.getAnimaisCadastrados().remove(animal);
            return true;
        }else{
            return false;
        }
    }
    
    public void adicionarComentario(Comentario comentario){
        this.comentarios.add(comentario);
    }
    
    public void removerComentario(Comentario comentario) {
        this.comentarios.remove(comentario);
    }
    
    public void avaliacao(float avaliacao){
        float avaliacaoOng = this.getAvaliacao();
        float numAvaliacoes = this.numeroAvaliacoes;
       
        float media = ((avaliacaoOng*numAvaliacoes)+ avaliacao)/ (numAvaliacoes + 1);
        
        this.setAvaliacao(media);
        this.numeroAvaliacoes+=1;
    }

        
    public void receberNotificacaoAdocao(Usuario usuario, Animal animal) {
        String mensagem = "Recebida notificação de início de adoção por " + usuario.getNomeCompleto()+ " para adoção de: " + animal.getNome();
        Notificacao notificacao = new Notificacao(mensagem, new Date(), this);
        notificacoesRecebidas.add(notificacao);
        System.out.println(mensagem);
    }

    public ArrayList<Notificacao> getNotificacoesRecebidas() {
        return notificacoesRecebidas;
    }

    public void setNotificacoesRecebidas(ArrayList<Notificacao> notificacoesRecebidas) {
        this.notificacoesRecebidas = notificacoesRecebidas;
    }
   
    public void setIdOng(int IdOng) {
        this.IdOng = IdOng;
    }

    public void setNome(String nome) {
        this.nome = nome;
    }

    public void setCNPJ(String CNPJ) {
        this.CNPJ = CNPJ;
    }

    public void setEmail(String email) {
        this.email = email;
    }

    public void setTelefone(String telefone) {
        this.telefone = telefone;
    }

    public void setEndereco(Endereco endereco) {
        this.endereco = endereco;
    }

    public void setSenha(String senha) {
        this.senha = senha;
    }

    public void setFotoPerfil(String fotoPerfil) {
        this.fotoPerfil = fotoPerfil;
    }

    public void setAnimaisCadastrados(ArrayList<Animal> animaisCadastrados) {
        this.animaisCadastrados = animaisCadastrados;
    }

    public void setAvaliacao(float avaliacao) {
        this.avaliacao = avaliacao;
    }

    public void setComentarios(ArrayList<Comentario> comentarios) {
        this.comentarios = comentarios;
    }

    public void setHistoricoAdocao(ArrayList<Adocao> historicoAdocao) {
        this.historicoAdocao = historicoAdocao;
    }
    
    public int getIdOng() {
        return IdOng;
    }

    public String getNome() {
        return nome;
    }

    public String getCNPJ() {
        return CNPJ;
    }

    public String getEmail() {
        return email;
    }

    public String getTelefone() {
        return telefone;
    }

    public Endereco getEndereco() {
        return endereco;
    }

    public String getSenha() {
        return senha;
    }

    public String getFotoPerfil() {
        return fotoPerfil;
    }

    public ArrayList<Animal> getAnimaisCadastrados() {
        return animaisCadastrados;
    }

    public float getAvaliacao() {
        return avaliacao;
    }

    public ArrayList<Comentario> getComentarios() {
        return comentarios;
    }

    public ArrayList<Adocao> getHistoricoAdocao() {
        return historicoAdocao;
    }

    public int getNumeroAvaliacoes() {
        return numeroAvaliacoes;
    }

    public void setNumeroAvaliacoes(int numeroAvaliacoes) {
        this.numeroAvaliacoes = numeroAvaliacoes;
    }
    
}

