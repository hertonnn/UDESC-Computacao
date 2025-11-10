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
public class AdocaoTest {
    
    public AdocaoTest() {
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
    public void testIniciarProcessoAdocao() {
        Endereco endereco = new Endereco("Iririú", "Joinville", "Santa Catarina");
        Usuario usuario = new Usuario(1, "Rob", "Roberto", new Date(), "Rob@gmail.com", "47892827", endereco, "123455");
        ONG ong = new ONG(1, "ONG 1", "1264838", "Ong1@gmail.com", "47991659022", endereco, "123456");
        Animal animal = new Animal(1, "Thor", "Labrador", "Grande", 5, "Macho", "Cachorro", "Nenhuma", ong);
        Date data = new Date();
        Adocao adocao = new Adocao(data, ong, usuario, animal);
        
        assertTrue(adocao.iniciarProcessoAdocao(usuario, animal, ong, data));
        
        assertEquals(usuario, adocao.getUsuario());
        assertEquals(animal, adocao.getAnimal());
        assertEquals(ong, adocao.getOng());
        assertEquals(data, adocao.getData());
        assertEquals("Em processo", adocao.getStatus());
        assertEquals(StatusAdocao.EMPROCESSO, animal.getStatusAdocao());
        assertTrue(usuario.getHistoricoAdocao().contains(adocao));
        assertTrue(ong.getHistoricoAdocao().contains(adocao));
        assertEquals(1,ong.getNotificacoesRecebidas().size());
        
        assertFalse(adocao.iniciarProcessoAdocao(usuario, animal, ong, data));
    }
    
     @Test
        public void testGettersAndSetters() {
            Date data = new Date();
            ONG ong = new ONG(1, "ONG 1", "1264838", "Ong1@gmail.com", "47991659022", new Endereco("Iririú", "Joinville", "Santa Catarina"), "123456");
            Usuario usuario = new Usuario(1, "Rob", "Roberto", new Date(), "Rob@gmail.com", "47892827", new Endereco("Iririú", "Joinville", "Santa Catarina"), "123455");
            Animal animal = new Animal(1, "Thor", "Labrador", "Grande", 5, "Macho", "Cachorro", "Nenhuma", ong);
        
            Adocao adocao = new Adocao(data, ong, usuario, animal);
        
            // Test getters
            assertEquals(data, adocao.getData());
            assertEquals("Em processo", adocao.getStatus());
            assertEquals(ong, adocao.getOng());
            assertEquals(usuario, adocao.getUsuario());
            assertEquals(animal, adocao.getAnimal());
        
            // Test setters
            Date newData = new Date(data.getTime() + 100); 
            adocao.setData(newData);
            assertEquals(newData, adocao.getData());
        
            String newStatus = "Concluído";
            adocao.setStatus(newStatus);
            assertEquals(newStatus, adocao.getStatus());
        
            ONG newOng = new ONG(2, "ONG 2", "123456", "Ong2@gmail.com", "47999999999", new Endereco("Centro", "São Paulo", "São Paulo"), "654321");
            adocao.setOng(newOng);
            assertEquals(newOng, adocao.getOng());
        
            Usuario newUsuario = new Usuario(2, "Ana", "Ana Paula", new Date(), "ana@gmail.com", "47999999998", new Endereco("Centro", "São Paulo", "São Paulo"), "123456");
            adocao.setUsuario(newUsuario);
            assertEquals(newUsuario, adocao.getUsuario());
        
            Animal newAnimal = new Animal(2, "Zeus", "Pitbull", "Grande", 4, "Macho", "Cachorro", "Nenhuma", newOng);
            adocao.setAnimal(newAnimal);
            assertEquals(newAnimal, adocao.getAnimal());
    }
}
