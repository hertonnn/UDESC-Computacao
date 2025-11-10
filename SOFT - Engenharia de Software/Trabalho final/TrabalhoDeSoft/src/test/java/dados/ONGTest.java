/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/UnitTests/JUnit5TestClass.java to edit this template
 */
package dados;
import java.util.Date;
import java.util.ArrayList;
import negocio.Sistema;
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
public class ONGTest {
    
    public ONGTest() {
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
    
    @Test
    public void testCadastrarONG() {
        Endereco endereco = new Endereco("Iririú", "Joinville", "Santa Catarina");
        ONG ong1 = new ONG(1, "ONG 1", "1264838", "Ong1@gmail.com", "47991659022", endereco, "123456");
        ONG ong2 = new ONG(2, "ONG 2", "1264839", "Ong2@gmail.com", "47991659022", endereco, "123456");
        ONG ong3 = new ONG(3, "ONG 3", "1264840", "Ong1@gmail.com", "47991659022", endereco, "123456"); // Mesma email que ong1
        ONG ong4 = new ONG(4, "ONG 4", "1264838", "Ong4@gmail.com", "47991659022", endereco, "123456"); // Mesmo CNPJ que ong1
        Sistema sistema = new Sistema();

        
        assertTrue(ong1.cadastrarONG(ong1, sistema));
        assertEquals(1, sistema.getOngsCadastradas().size()); // = 1

        assertFalse(ong3.cadastrarONG(ong3, sistema)); // email ==
        assertEquals(1, sistema.getOngsCadastradas().size()); // = 1

        assertFalse(ong4.cadastrarONG(ong4, sistema)); // CNPJ ==
        assertEquals(1, sistema.getOngsCadastradas().size()); // 1

        assertTrue(ong2.cadastrarONG(ong2, sistema));
        assertEquals(2, sistema.getOngsCadastradas().size()); // 2
    }
    
    @Test
    public void testLoginONG() {
        Endereco endereco = new Endereco("Iririú", "Joinville", "Santa Catarina");
        ONG ong1 = new ONG(1, "ONG 1", "1264838", "Ong1@gmail.com", "47991659022", endereco, "123456");
        Sistema sistema = new Sistema();
    
        assertTrue(ong1.cadastrarONG(ong1, sistema));
        assertEquals(1, sistema.getOngsCadastradas().size());
        
        assertTrue(ong1.LoginONG("Ong1@gmail.com", "123456", sistema)); // Dados corretos
        assertFalse(ong1.LoginONG("Ong1@gmail.com", "127456", sistema)); // Senha incorreta
        assertFalse(ong1.LoginONG("Ong2@gmail.com", "123456", sistema)); // Email incorreto
    }
    
    @Test
    public void testCadastrarAnimal() {
        Endereco endereco = new Endereco("Iririú", "Joinville", "Santa Catarina");
        ONG ong = new ONG(1, "ONG 1", "1264838", "Ong1@gmail.com", "47991659022", endereco, "123456");
        Animal animal1 = new Animal(1,"Thor", "Labrador","Grande", 5, "Macho", "Cachorro", "Nenhuma", ong);
        Animal animal2 = new Animal(2, "Jujuba", "Vira-Lata", "Médio", 3, "Macho", "Cachorro", "Nenhuma", ong);
        Sistema sistema = new Sistema();
    
        assertTrue(ong.cadastrarAnimal(animal1, sistema));
        assertFalse(ong.cadastrarAnimal(animal1, sistema)); // Cadastrando o mesmo animal
        assertEquals(1, ong.getAnimaisCadastrados().size()); // = 1
        assertTrue(ong.cadastrarAnimal(animal2, sistema));
        assertEquals(2, ong.getAnimaisCadastrados().size()); // = 2
    }
    
    @Test
    public void testExcluirAnimal() {
        Endereco endereco = new Endereco("Iririú", "Joinville", "Santa Catarina");
        ONG ong = new ONG(1, "ONG 1", "1264838", "Ong1@gmail.com", "47991659022", endereco, "123456");
        Animal animal1 = new Animal(1,"Thor", "Labrador","Grande", 5, "Macho", "Cachorro", "Nenhuma", ong);
        Sistema sistema = new Sistema();
        
        ong.cadastrarAnimal(animal1, sistema);
        assertTrue(ong.excluirAnimal(animal1, sistema));
        assertFalse(ong.excluirAnimal(animal1, sistema));
        assertEquals(0, ong.getAnimaisCadastrados().size());
    }
    
    @Test
    public void testAvaliacao() {
        Endereco endereco = new Endereco("Iririú", "Joinville", "Santa Catarina");
        ONG ong = new ONG(1, "ONG 1", "1264838", "Ong1@gmail.com", "47991659022", endereco, "123456");
    
        ong.avaliacao(5);
        assertEquals(5, ong.getAvaliacao());
        assertEquals(1, ong.getNumeroAvaliacoes());

        ong.avaliacao(3);
        assertEquals(4, ong.getAvaliacao()); 
        assertEquals(2, ong.getNumeroAvaliacoes());
    }
    
    @Test
    public void testAdicionarComentario() {
        Endereco endereco = new Endereco("Iririú", "Joinville", "Santa Catarina");
        ONG ong = new ONG(1, "ONG 1", "1264838", "Ong1@gmail.com", "47991659022", endereco, "123456");
        Usuario usuario = new Usuario(1, "Rob", "Roberto",new Date(),"Rob@gmail.com", "47892827" , endereco, "123455");
        
        Comentario comentario = new Comentario("Ótima ONG!", new Date(), usuario);
    
        ong.adicionarComentario(comentario);
        assertEquals(1, ong.getComentarios().size());
        assertEquals("Ótima ONG!", ong.getComentarios().get(0).getTexto());
    }
    
    @Test
    public void testRemoverComentario() {
        Endereco endereco = new Endereco("Iririú", "Joinville", "Santa Catarina");
        ONG ong = new ONG(1, "ONG 1", "1264838", "Ong1@gmail.com", "47991659022", endereco, "123456");
        Usuario usuario = new Usuario(1, "Rob", "Roberto",new Date(),"Rob@gmail.com", "47892827" , endereco, "123455");
        Comentario comentario = new Comentario("Ótima ONG!", new Date(), usuario);
        
        ong.adicionarComentario(comentario);
        ong.removerComentario(comentario);
        assertEquals(0, ong.getComentarios().size());
    }
    
    @Test
    public void testReceberNotificacaoAdocao() {
        Endereco endereco = new Endereco("Iririú", "Joinville", "Santa Catarina");
        ONG ong = new ONG(1, "ONG 1", "1264838", "Ong1@gmail.com", "47991659022", endereco, "123456");
        Usuario usuario = new Usuario(1, "Rob", "Roberto",new Date(),"Rob@gmail.com", "47892827" , endereco, "123455");
        Animal animal = new Animal(1,"Thor", "Labrador","Grande", 5, "Macho", "Cachorro", "Nenhuma", ong);
        
    
        ong.receberNotificacaoAdocao(usuario, animal);
        assertEquals(1, ong.getNotificacoesRecebidas().size()); // = 1
        assertTrue(ong.getNotificacoesRecebidas().get(0).getMensagem().contains("Recebida notificação de início de adoção por Roberto para adoção de: Thor"));
    }   
}
