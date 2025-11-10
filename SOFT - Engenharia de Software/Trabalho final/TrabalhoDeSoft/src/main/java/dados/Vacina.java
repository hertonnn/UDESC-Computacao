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
public class Vacina {
    private String nome;
    private Date data;

    public Vacina(String nome, Date data) {
        this.nome = nome;
        this.data = data;
    }

    public void setNome(String nome) {
        this.nome = nome;
    }

    public void setData(Date data) {
        this.data = data;
    }

    public String getNome() {
        return nome;
    }

    public Date getData() {
        return data;
    }  
}