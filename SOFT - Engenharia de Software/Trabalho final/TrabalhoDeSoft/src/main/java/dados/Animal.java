/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package dados;
import java.util.ArrayList;
import java.util.Objects;

/**
 *
 * @author Mariana dos Santos
 */
public class Animal {
    private int idAnimal;
    private String nome;
    private String raca;
    private String porte;
    private int idade;
    private String sexo;
    private String especie;
    private ArrayList<Vacina> vacinas;
    private String personalide;
    private String historia;
    private String necessidadesEspeciais;
    private StatusAdocao statusAdocao;
    private ONG ong;
    private String fotoPerfil;
    private ArrayList<String> imagensDoPerfil;

    public Animal(int idAnimal, String nome, String raca, String porte, int idade, String sexo, String especie, String necessidadesEspeciais, ONG ong) {
        this.idAnimal = idAnimal;
        this.nome = nome;
        this.raca = raca;
        this.porte = porte;
        this.idade = idade;
        this.sexo = sexo;
        this.especie= especie;
        this.vacinas = new ArrayList<>();
        this.necessidadesEspeciais = necessidadesEspeciais;
        this.statusAdocao = StatusAdocao.DISPONIVEL;
        this.ong = ong;
        this.fotoPerfil= "";
        this.imagensDoPerfil= new ArrayList<>();
    }
    
    public String buscaCidade(){
        return this.getOng().getEndereco().getCidade();
    }
    
    public String buscaEstado(){
        return this.getOng().getEndereco().getEstado();
    }
    
    public String buscaBairro(){
        return this.getOng().getEndereco().getBairro();
    }
    
    public String buscaNomeONG(){
        return this.getOng().getNome();
    }
   
    public void setIdAnimal(int idAnimal) {
        this.idAnimal = idAnimal;
    }

    public void setNome(String nome) {
        this.nome = nome;
    }

    public void setRaca(String raca) {
        this.raca = raca;
    }

    public void setPorte(String porte) {
        this.porte = porte;
    }

    public void setIdade(int idade) {
        this.idade = idade;
    }

    public void setSexo(String sexo) {
        this.sexo = sexo;
    }

    public void setVacinas(ArrayList<Vacina> vacinas) {
        this.vacinas = vacinas;
    }

    public void setPersonalide(String personalide) {
        this.personalide = personalide;
    }

    public void setHistoria(String historia) {
        this.historia = historia;
    }

    public void setNecessidadesEspeciais(String necessidadesEspeciais) {
        this.necessidadesEspeciais = necessidadesEspeciais;
    }

    public void setStatusAdocao(StatusAdocao statusAdocao) {
        this.statusAdocao = statusAdocao;
    }

    public void setOng(ONG ong) {
        this.ong = ong;
    }

    public void setFotoPerfil(String fotoPerfil) {
        this.fotoPerfil = fotoPerfil;
    }

    public void setImagensDoPerfil(ArrayList<String> imagensDoPerfil) {
        this.imagensDoPerfil = imagensDoPerfil;
    }

    public int getIdAnimal() {
        return idAnimal;
    }

    public String getNome() {
        return nome;
    }

    public String getRaca() {
        return raca;
    }

    public String getPorte() {
        return porte;
    }

    public int getIdade() {
        return idade;
    }

    public String getSexo() {
        return sexo;
    }

    public ArrayList<Vacina> getVacinas() {
        return vacinas;
    }

    public String getPersonalide() {
        return personalide;
    }

    public String getHistoria() {
        return historia;
    }

    public String getNecessidadesEspeciais() {
        return necessidadesEspeciais;
    }

    public StatusAdocao getStatusAdocao() {
        return statusAdocao;
    }

    public ONG getOng() {
        return ong;
    }

    public String getFotoPerfil() {
        return fotoPerfil;
    }

    public ArrayList<String> getImagensDoPerfil() {
        return imagensDoPerfil;
    }   

    public String getEspecie() {
        return especie;
    }

    public void setEspecie(String especie) {
        this.especie = especie;
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
        final Animal other = (Animal) obj;
        if (this.idAnimal != other.idAnimal) {
            return false;
        }
        if (this.idade != other.idade) {
            return false;
        }
        if (!Objects.equals(this.nome, other.nome)) {
            return false;
        }
        if (!Objects.equals(this.raca, other.raca)) {
            return false;
        }
        if (!Objects.equals(this.porte, other.porte)) {
            return false;
        }
        if (!Objects.equals(this.sexo, other.sexo)) {
            return false;
        }
        if (!Objects.equals(this.especie, other.especie)) {
            return false;
        }
        if (!Objects.equals(this.personalide, other.personalide)) {
            return false;
        }
        if (!Objects.equals(this.historia, other.historia)) {
            return false;
        }
        if (!Objects.equals(this.necessidadesEspeciais, other.necessidadesEspeciais)) {
            return false;
        }
        if (!Objects.equals(this.fotoPerfil, other.fotoPerfil)) {
            return false;
        }
        if (!Objects.equals(this.vacinas, other.vacinas)) {
            return false;
        }
        if (this.statusAdocao != other.statusAdocao) {
            return false;
        }
        if (!Objects.equals(this.ong, other.ong)) {
            return false;
        }
        return Objects.equals(this.imagensDoPerfil, other.imagensDoPerfil);
    }
}
