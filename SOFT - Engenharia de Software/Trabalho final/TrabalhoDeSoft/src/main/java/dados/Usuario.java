/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package dados;
import java.util.ArrayList;
import java.util.Date;
import java.util.Objects;
import negocio.Sistema;

/**
 *
 * @author Mariana dos Santos
 */
public class Usuario {
    private int idUsuario;
    private String nomeUsuario;
    private String nomeCompleto;
    private Date dataNascimento;
    private String email;
    private String celular;
    private Endereco endereco;
    private String senha;
    private String fotoPerfil;
    private ArrayList<Animal> animaisFavoritos;
    private ArrayList<Adocao> historicoAdocao;
    private String estiloDeVida;
    private String experienciaComAnimais;
    private String motivacaoParaAdocao;
    
    public Usuario(int idUsuario, String nomeUsuario, String nomeCompleto, Date dataNascimento, String email, String celular, Endereco endereco, String senha) {
        this.idUsuario = idUsuario;
        this.nomeUsuario = nomeUsuario;
        this.nomeCompleto = nomeCompleto;
        this.dataNascimento = dataNascimento;
        this.email = email;
        this.celular = celular;
        this.endereco = endereco;
        this.senha = senha;
        this.fotoPerfil = "";
        this.animaisFavoritos = new ArrayList<>();
        this.historicoAdocao = new ArrayList<>();
        this.estiloDeVida = "";
        this.experienciaComAnimais = "";
        this.motivacaoParaAdocao = "";
    }
    
    public Boolean cadastrarUsuario(Usuario usuario, Sistema sistema){
        for(Usuario user: sistema.getUsuariosCadastrados()){
            if(user.getEmail().equals(usuario.getEmail())){
                return false;
            } 
            if(user.getNomeUsuario().equals(usuario.getNomeUsuario())){
                return false;
            }
        }
        
        sistema.getUsuariosCadastrados().add(usuario);
        return true;
    }
    
    public Boolean LoginUsuario(String email, String senha, Sistema sistema){
        for(Usuario user: sistema.getUsuariosCadastrados()){
            if((user.getEmail().equals(email))&& user.getSenha().equals(senha)){
                return true;
            }
        }
        return false;
    }
    
    public void favoritarAnimal(Animal animal){
        if(!this.getAnimaisFavoritos().contains(animal)){
            this.animaisFavoritos.add(animal);
        }
    }
    
    public void desfavoritarAnimal(Animal animal){
        this.animaisFavoritos.remove(animal);
    }
    
    public void fazerComentario(String mensagem, ONG ong){
        Date dataAtual = new Date();
        Comentario comentario = new Comentario(mensagem, dataAtual,this);
        ong.adicionarComentario(comentario);
    }
    
    public void apagarComentario(Comentario comentario, ONG ong){
        ong.removerComentario(comentario);
    }
    
    public Boolean avaliarONG(float avaliacao, ONG ong){
        if(avaliacao >= 0 && avaliacao <= 5){
            ong.avaliacao(avaliacao);
            return true;
        }
        return false;
    }
   
    public void setIdUsuario(int idUsuario) {
        this.idUsuario = idUsuario;
    }

    public void setNomeUsuario(String nomeUsuario) {
        this.nomeUsuario = nomeUsuario;
    }

    public void setNomeCompleto(String nomeCompleto) {
        this.nomeCompleto = nomeCompleto;
    }

    public void setDataNascimento(Date dataNascimento) {
        this.dataNascimento = dataNascimento;
    }

    public void setEmail(String email) {
        this.email = email;
    }

    public void setCelular(String celular) {
        this.celular = celular;
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

    public void setAnimaisFavoritos(ArrayList<Animal> animaisFavoritos) {
        this.animaisFavoritos = animaisFavoritos;
    }

    public void setHistoricoAdocao(ArrayList<Adocao> historicoAdocao) {
        this.historicoAdocao = historicoAdocao;
    }

    public void setEstiloDeVida(String estiloDeVida) {
        this.estiloDeVida = estiloDeVida;
    }

    public void setExperienciaComAnimais(String experienciaComAnimais) {
        this.experienciaComAnimais = experienciaComAnimais;
    }

    public void setMotivacaoParaAdocao(String motivacaoParaAdocao) {
        this.motivacaoParaAdocao = motivacaoParaAdocao;
    }

    public int getIdUsuario() {
        return idUsuario;
    }

    public String getNomeUsuario() {
        return nomeUsuario;
    }

    public String getNomeCompleto() {
        return nomeCompleto;
    }

    public Date getDataNascimento() {
        return dataNascimento;
    }

    public String getEmail() {
        return email;
    }

    public String getCelular() {
        return celular;
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

    public ArrayList<Animal> getAnimaisFavoritos() {
        return animaisFavoritos;
    }

    public ArrayList<Adocao> getHistoricoAdocao() {
        return historicoAdocao;
    }

    public String getEstiloDeVida() {
        return estiloDeVida;
    }

    public String getExperienciaComAnimais() {
        return experienciaComAnimais;
    }

    public String getMotivacaoParaAdocao() {
        return motivacaoParaAdocao;
    }

    @Override
    public int hashCode() {
        int hash = 7;
        return hash;
    }

    @Override
    public boolean equals(Object obj) {
        if (this == obj) {
            return true;
        }
        if (obj == null) {
            return false;
        }
        if (getClass() != obj.getClass()) {
            return false;
        }
        final Usuario other = (Usuario) obj;
        if (this.idUsuario != other.idUsuario) {
            return false;
        }
        if (!Objects.equals(this.nomeUsuario, other.nomeUsuario)) {
            return false;
        }
        if (!Objects.equals(this.nomeCompleto, other.nomeCompleto)) {
            return false;
        }
        if (!Objects.equals(this.email, other.email)) {
            return false;
        }
        if (!Objects.equals(this.celular, other.celular)) {
            return false;
        }
        if (!Objects.equals(this.senha, other.senha)) {
            return false;
        }
        if (!Objects.equals(this.fotoPerfil, other.fotoPerfil)) {
            return false;
        }
        if (!Objects.equals(this.estiloDeVida, other.estiloDeVida)) {
            return false;
        }
        if (!Objects.equals(this.experienciaComAnimais, other.experienciaComAnimais)) {
            return false;
        }
        if (!Objects.equals(this.motivacaoParaAdocao, other.motivacaoParaAdocao)) {
            return false;
        }
        if (!Objects.equals(this.dataNascimento, other.dataNascimento)) {
            return false;
        }
        if (!Objects.equals(this.endereco, other.endereco)) {
            return false;
        }
        if (!Objects.equals(this.animaisFavoritos, other.animaisFavoritos)) {
            return false;
        }
        return Objects.equals(this.historicoAdocao, other.historicoAdocao);
    }
}