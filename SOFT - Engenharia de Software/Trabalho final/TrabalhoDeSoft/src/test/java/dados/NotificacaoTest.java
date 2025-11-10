/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/UnitTests/JUnit5TestClass.java to edit this template
 */
package dados;

import java.util.Date;
import org.junit.jupiter.api.AfterEach;
import org.junit.jupiter.api.AfterAll;
import org.junit.jupiter.api.BeforeEach;
import org.junit.jupiter.api.BeforeAll;
import org.junit.jupiter.api.Test;
import static org.junit.jupiter.api.Assertions.*;

/**
 *
 * @author Mariana dos Santos
 */
public class NotificacaoTest {
    
    public NotificacaoTest() {
    }
    
    @BeforeAll
    public static void setUpClass() {
    }
    
    @AfterAll
    public static void tearDownClass() {
    }
    
    @BeforeEach
    public void setUp() {
    }
    
    @AfterEach
    public void tearDown() {
    }

    /**
     * Teste dos métodos Getters e construtor
     */
    @Test
    public void testConstructorGetters() {
        
        Endereco endereco = new Endereco("Iririú", "Joinville", "Santa Catarina");
        ONG ong = new ONG(1, "ONG 1", "1264838", "Ong1@gmail.com", "47991659022", endereco, "123456"); 
        Date data = new Date();
        Notificacao notificacao = new Notificacao("Processo de adoção solicitado", data, ong);
        
        System.out.printf("--Teste do construtor e getters--\n");
        System.out.printf("Mensagem: %s, Data: %s, ONG: %s%n", notificacao.getMensagem(), notificacao.getData(), notificacao.getOng().getNome());

        assertEquals("Processo de adoção solicitado", notificacao.getMensagem());
        assertEquals(data, notificacao.getData());
        assertEquals(ong, notificacao.getOng());
    }
    
    /**
    * Teste dos métodos setters
    */
    @Test
    public void testSetters(){
        Endereco endereco = new Endereco("Iririú", "Joinville", "Santa Catarina");
        ONG ong1 = new ONG(1, "ONG 1", "1264838", "Ong1@gmail.com", "47991659022", endereco, "123456"); 
        Date data = new Date();
        Notificacao notificacao = new Notificacao("Processo de adoção solicitado", data, ong1);
        
        ONG ong2 = new ONG(2, "ONG 2", "1264838", "Ong2@gmail.com", "47991659022", endereco, "123456");
        Date data2 = new Date();
        String mensagem2 = "Nova mensangem";
        
        System.out.printf("\n--Teste dos setters--\n");
        notificacao.setOng(ong2);
        notificacao.setData(data2);
        notificacao.setMensagem(mensagem2);
        System.out.printf("Mensagem: %s, Data: %s, ONG: %s%n", notificacao.getMensagem(), notificacao.getData(), notificacao.getOng().getNome());
    }
    
    
}
