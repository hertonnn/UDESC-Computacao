/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/UnitTests/JUnit5TestClass.java to edit this template
 */
package dados;

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
public class EnderecoTest {
    
    public EnderecoTest() {
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
     * Teste do método setBairro e getBairro.
     */
    @Test
    public void testSetGetBairro() {
        Endereco endereco = new Endereco("Iririú", "Joinville", "Santa Catarina");
        assertEquals("Iririú", endereco.getBairro());
        endereco.setBairro("Jardim Sofia");
        assertEquals("Jardim Sofia", endereco.getBairro());  
    }  
    
    /**
     * Teste do método setCidade e getCidade.
     */
    @Test
    public void testSetGetCidade() {
        Endereco endereco = new Endereco("Iririú", "Joinville", "Santa Catarina");
        assertEquals("Joinville", endereco.getCidade());
        endereco.setCidade("Tubarão");
        assertEquals("Tubarão", endereco.getCidade());
    }
    
    /**
     * Test do método setEstado e getEstado.
     */
    @Test
    public void testSetGetEstado() {
        Endereco endereco = new Endereco("Iririú", "Joinville", "Santa Catarina");
        assertEquals("Santa Catarina", endereco.getEstado());
        endereco.setEstado("Rio Grande do Sul");
        assertEquals("Rio Grande do Sul", endereco.getEstado());
    }
    
    /**
     * Test do método equals.
     */
    @Test
    public void testEquals(){
        Endereco endereco1 = new Endereco("Iririú", "Joinville", "Santa Catarina");
        Endereco endereco2 = new Endereco("Iririú", "Joinville", "Santa Catarina");
        Endereco endereco3 = new Endereco("Vila Nova", "Joinville", "Santa Catarina");
        
        assertTrue(endereco1.equals(endereco2));
        assertFalse(endereco1.equals(endereco3));
    }
}
