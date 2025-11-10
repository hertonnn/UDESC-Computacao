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
public class ComentarioTest {
    
    public ComentarioTest() {
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
     * Testa dos métodos Getters e Construtor
     * (String email, String celular, Endereco endereco, String senha)
     */
    @Test
    public void TestConstrutorGetters(){
        Date dataNascimento= new Date();
        Endereco endereco = new Endereco("Iririú", "Joinville", "Santa Catarina");
        Usuario usuario = new Usuario(1, "Rob", "Roberto",dataNascimento,"Roberto@gmai.com", "47892827" , endereco, "123455" );
        Date data= new Date();
        
        Comentario comentario = new Comentario("Comentário 1", data, usuario);
        System.out.printf("--Teste do construtor e getters--\n");
        System.out.printf("Comentário: %s, Data: %s, Usuario: %s%n", comentario.getTexto(), comentario.getData(), comentario.getUsuario().getNomeCompleto());
        
        assertEquals("Comentário 1", comentario.getTexto());
        assertEquals(data, comentario.getData());
        assertEquals(usuario, comentario.getUsuario());
    }
  
    /**
    * Teste dos métodos setters
    */
    @Test
    public void testSetters(){
        Date dataNascimento= new Date();
        Endereco endereco = new Endereco("Iririú", "Joinville", "Santa Catarina");
        Usuario usuario = new Usuario(1, "Rob", "Roberto",dataNascimento,"Roberto@gmai.com", "47892827" , endereco, "123455" );
        Date data= new Date();
        
        Comentario comentario = new Comentario("Comentário 1", data, usuario);
        
        Date dataNascimento2= new Date();
        Endereco endereco2 = new Endereco("Comasa", "Joinville", "Santa Catarina");
        Usuario usuario2 = new Usuario(2, "Ju", "Julia",dataNascimento2,"julia@gmai.com", "47892827" , endereco2, "123455" );
        Date data2= new Date();
        
        System.out.printf("\n--Teste dos setters--\n");
        comentario.setTexto("Comentário 2");
        comentario.setData(data2);
        comentario.setUsuario(usuario2);
        System.out.printf("Comentário: %s, Data: %s, Usuario: %s%n", comentario.getTexto(), comentario.getData(), comentario.getUsuario().getNomeCompleto());
    }
}
