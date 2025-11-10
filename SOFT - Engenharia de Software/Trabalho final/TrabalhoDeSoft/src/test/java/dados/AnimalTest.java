/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/UnitTests/JUnit5TestClass.java to edit this template
 */
package dados;
import java.util.Date;
import java.util.ArrayList;
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
public class AnimalTest {
    
    public AnimalTest() {
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
    public void testBuscaCidadeEstadoBairroOng() {
        Endereco endereco = new Endereco("Iririú", "Joinville", "Santa Catarina");
        ONG ong = new ONG(1, "ONG 1", "1264838", "Ong1@gmail.com", "47991659022", endereco, "123456"); 
        Animal animal = new Animal(1, "Jujuba", "Vira-Lata", "Médio", 3, "Macho", "Cachorro", "Nenhuma", ong);
        
        assertEquals("Iririú", animal.buscaBairro());
        assertEquals("Joinville", animal.buscaCidade());
        assertEquals("Santa Catarina", animal.buscaEstado()); 
        assertEquals("ONG 1", animal.buscaNomeONG());
    }
    
    @Test
    public void testSettersGetters() {
        Endereco endereco = new Endereco("Iririú", "Joinville", "Santa Catarina");
        ONG ong = new ONG(1, "ONG 1", "1264838", "Ong1@gmail.com", "47991659022", endereco, "123456");
        Animal animal = new Animal(1, "Jujuba", "Vira-Lata", "Médio", 3, "Macho", "Cachorro", "Nenhuma", ong);
        
        animal.setIdAnimal(2);
        assertEquals(2, animal.getIdAnimal());
        
        animal.setNome("Ju");
        assertEquals("Ju", animal.getNome());
        
        animal.setRaca("Labrador");
        assertEquals("Labrador", animal.getRaca());
        
        animal.setPorte("Grande");
        assertEquals("Grande", animal.getPorte());
        
        animal.setIdade(6);
        assertEquals(6, animal.getIdade());
        
        animal.setSexo("Fêmea");
        assertEquals("Fêmea", animal.getSexo());
        
        ArrayList<Vacina> vacinas = new ArrayList<>();
        vacinas.add(new Vacina("Raiva", new Date()));
        animal.setVacinas(vacinas);
        assertEquals(vacinas, animal.getVacinas());
        
        animal.setPersonalide("Alegre");
        assertEquals("Alegre", animal.getPersonalide());
        
        animal.setHistoria("história");
        assertEquals("história", animal.getHistoria());
        
        animal.setNecessidadesEspeciais("Necessidade Especial");
        assertEquals("Necessidade Especial", animal.getNecessidadesEspeciais());
        
        animal.setStatusAdocao(StatusAdocao.ADOTADO);
        assertEquals(StatusAdocao.ADOTADO, animal.getStatusAdocao());
        
        ONG ong2 = new ONG(2, "ONG 2", "1264838", "Ong2@gmail.com", "47991659022", endereco, "123456");
        animal.setOng(ong);
        assertEquals(ong, animal.getOng());
        
        animal.setEspecie("Gato");
        assertEquals("Gato", animal.getEspecie());
        
        animal.setFotoPerfil("fotoPerfil.jpg");
        assertEquals("fotoPerfil.jpg", animal.getFotoPerfil());
        
        ArrayList<String> imagens = new ArrayList<>();
        imagens.add("imagem1.jpg");
        imagens.add("imagem2.jpg");
        animal.setImagensDoPerfil(imagens);
        assertEquals(imagens, animal.getImagensDoPerfil());
    }
    
}
