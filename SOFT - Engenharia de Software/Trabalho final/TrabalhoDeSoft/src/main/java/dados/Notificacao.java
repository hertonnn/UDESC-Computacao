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
public class Notificacao {
    private String mensagem;
    private Date data;
    private ONG ong;

    public Notificacao(String mensagem, Date data, ONG ong) {
        this.mensagem = mensagem;
        this.data = data;
        this.ong = ong;
    }
    
    public void setMensagem(String mensagem) {
        this.mensagem = mensagem;
    }

    public void setData(Date data) {
        this.data = data;
    }

    public void setOng(ONG ong) {
        this.ong = ong;
    }

    public String getMensagem() {
        return mensagem;
    }

    public Date getData() {
        return data;
    }

    public ONG getOng() {
        return ong;
    }
}
