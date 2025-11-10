/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/UnitTests/JUnit5TestClass.java to edit this template
 */
package dados;

import java.util.Date;
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
public class UsuarioTest {
    
    public UsuarioTest() {
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
    public void testCadastrarUsuario() {
       Endereco endereco = new Endereco("Iririú", "Joinville", "Santa Catarina");
       Usuario usuario = new Usuario(1, "Rob", "Roberto",new Date(),"Rob@gmail.com", "47892827" , endereco, "123455");
       Sistema sistema = new Sistema();
       
       assertTrue(usuario.cadastrarUsuario(usuario, sistema));
       assertEquals(1, sistema.getUsuariosCadastrados().size());
       assertFalse(usuario.cadastrarUsuario(usuario, sistema)); // Tentando cadastrar novamente o usuario
    }
    
    @Test
    public void testLoginUsuario() {
       Endereco endereco = new Endereco("Iririú", "Joinville", "Santa Catarina");
       Usuario usuario = new Usuario(1, "Rob", "Roberto",new Date(),"Roberto@gmail.com", "47892827" , endereco, "123455");
       Sistema sistema = new Sistema();
       
       assertTrue(usuario.cadastrarUsuario(usuario, sistema));
       assertEquals(1, sistema.getUsuariosCadastrados().size());
       
       assertTrue(usuario.LoginUsuario("Roberto@gmail.com","123455",sistema)); // Dados corretos
       assertFalse(usuario.LoginUsuario("Roberto@gmail.com","455",sistema)); // Senha incorreta
       assertFalse(usuario.LoginUsuario("Roberto@","455",sistema)); // Email incorreto
    }
    
    @Test
    public void testFavoritarAnimal() {
        Endereco endereco = new Endereco("Iririú", "Joinville", "Santa Catarina");
        Usuario usuario = new Usuario(1, "Rob", "Roberto",new Date(),"Roberto@gmail.com", "47892827" , endereco, "123455");
        
        ONG ong = new ONG(1, "ONG 1", "1264838", "Ong1@gmail.com", "47991659022", endereco, "123456"); 
        Animal animal1 = new Animal(1, "Cachorro 1", "Nenhuma definida", "Médio", 3, "Macho", "Cachorro", "Nenhuma", ong);
        Animal animal2 = new Animal(2, "Cachorro 2", "Nenhuma definida", "Médio", 3, "Macho", "Cachorro", "Nenhuma", ong);
       
        assertTrue(usuario.getAnimaisFavoritos().isEmpty()); 
        
        usuario.favoritarAnimal(animal1);
        assertEquals(1, usuario.getAnimaisFavoritos().size()); // = 1
        assertTrue(usuario.getAnimaisFavoritos().contains(animal1));
        
        usuario.favoritarAnimal(animal1);
        assertEquals(1, usuario.getAnimaisFavoritos().size()); // = 1 (não deve mudar)
        assertTrue(usuario.getAnimaisFavoritos().contains(animal1));
        
        usuario.favoritarAnimal(animal2);
        assertEquals(2, usuario.getAnimaisFavoritos().size()); // = 2
        assertTrue(usuario.getAnimaisFavoritos().contains(animal1));
    }
    
    @Test
    public void testDesfavoritarAnimal() {
        Endereco endereco = new Endereco("Iririú", "Joinville", "Santa Catarina");
        Usuario usuario = new Usuario(1, "Rob", "Roberto",new Date(),"Roberto@gmail.com", "47892827" , endereco, "123455");
        ONG ong = new ONG(1, "ONG 1", "1264838", "Ong1@gmail.com", "47991659022", endereco, "123456"); 
        Animal animal1 = new Animal(1, "Cachorro 1", "Nenhuma definida", "Médio", 3, "Macho", "Cachorro", "Nenhuma", ong);
        
        usuario.favoritarAnimal(animal1);
        assertEquals(1, usuario.getAnimaisFavoritos().size()); // = 1
        usuario.desfavoritarAnimal(animal1);
        assertFalse(usuario.getAnimaisFavoritos().contains(animal1));
        assertEquals(0, usuario.getAnimaisFavoritos().size()); // = 0
    }
    
    @Test
    public void testFazerComentario() {
        Endereco endereco = new Endereco("Iririú", "Joinville", "Santa Catarina");
        Usuario usuario = new Usuario(1, "Rob", "Roberto",new Date(),"Roberto@gmail.com", "47892827" , endereco, "123455");
        ONG ong = new ONG(1, "ONG 1", "1264838", "Ong1@gmail.com", "47991659022", endereco, "123456"); 
        
        
        usuario.fazerComentario("Comentário1", ong);
        assertEquals(1, ong.getComentarios().size()); // = 1
        usuario.fazerComentario("Comentário2", ong);  
        assertEquals(2, ong.getComentarios().size()); // = 2
    }
    
    @Test
    public void testApagarComentario() {
        Endereco endereco = new Endereco("Iririú", "Joinville", "Santa Catarina");
        Usuario usuario = new Usuario(1, "Rob", "Roberto",new Date(),"Roberto@gmail.com", "47892827" , endereco, "123455");
        ONG ong = new ONG(1, "ONG 1", "1264838", "Ong1@gmail.com", "47991659022", endereco, "123456"); 
        
        Comentario comentario = new Comentario("Comentário 1", new Date(), usuario);
        ong.adicionarComentario(comentario);
        assertEquals(1, ong.getComentarios().size()); // = 1
        
        usuario.apagarComentario(comentario, ong);
        assertEquals(0, ong.getComentarios().size()); // = 0
        
    }
    
    @Test
    public void testAvaliarONG() {
        Endereco endereco = new Endereco("Iririú", "Joinville", "Santa Catarina");
        Usuario usuario = new Usuario(1, "Rob", "Roberto",new Date(),"Roberto@gmail.com", "47892827" , endereco, "123455");
        ONG ong = new ONG(1, "ONG 1", "1264838", "Ong1@gmail.com", "47991659022", endereco, "123456"); 
        
        assertEquals(0, ong.getAvaliacao(), 0.001); // = 0
        usuario.avaliarONG(5, ong);
        assertEquals(5, ong.getAvaliacao(), 0.001); // = 5
        usuario.avaliarONG(3, ong);
        assertEquals(4, ong.getAvaliacao(), 0.001); // = 4
        
        assertFalse(usuario.avaliarONG(7, ong)); // avaliação fora do padrão
        assertFalse(usuario.avaliarONG(-1, ong)); // avaliação fora do padrão
    }
}

    
