/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package dados;
import java.util.Date;
/**
 *
 * @author Mariana dos Santos
 */
public class Adocao {
    private Date data;
    private String status;
    private ONG ong;
    private Usuario usuario;
    private Animal animal;

    public Adocao(Date data, ONG ong, Usuario usuario, Animal animal) {
        this.data = data;
        this.status = "Em processo";
        this.ong = ong;
        this.usuario = usuario;
        this.animal = animal;
    }
    
    public Boolean iniciarProcessoAdocao(Usuario usuario, Animal animal, ONG ong, Date data){
        if(animal.getStatusAdocao() == StatusAdocao.DISPONIVEL){
            this.usuario = usuario;
            this.animal = animal;
            this.ong = ong;
            this.data = data;
            this.status= "Em processo";
            usuario.getHistoricoAdocao().add(this);
            animal.setStatusAdocao(StatusAdocao.EMPROCESSO);
            ong.getHistoricoAdocao().add(this);
            ong.receberNotificacaoAdocao(usuario, animal);
            return true;
        } else{
            System.out.println("O animal não está disponível para adoção.");
            return false;
        }   
    }

    public Date getData() {
        return data;
    }

    public void setData(Date data) {
        this.data = data;
    }

    public String getStatus() {
        return status;
    }

    public void setStatus(String status) {
        this.status = status;
    }

    public ONG getOng() {
        return ong;
    }

    public void setOng(ONG ong) {
        this.ong = ong;
    }

    public Usuario getUsuario() {
        return usuario;
    }

    public void setUsuario(Usuario usuario) {
        this.usuario = usuario;
    }

    public Animal getAnimal() {
        return animal;
    }

    public void setAnimal(Animal animal) {
        this.animal = animal;
    }
}

