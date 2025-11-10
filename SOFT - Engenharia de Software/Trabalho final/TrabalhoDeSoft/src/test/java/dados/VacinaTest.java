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
public class VacinaTest {
    
    public VacinaTest() {
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
     * Teste do método setNome e getNome
     */
    @Test
    public void testSetGetNome() {
        Vacina vacina = new Vacina("Gripe canina", new Date());
        assertEquals("Gripe canina", vacina.getNome());
        vacina.setNome("Antirrábica");
        assertEquals("Antirrábica", vacina.getNome());
    }
    
    /**
     * Teste do método setData e getData
     */
    @Test
    public void testSetGetData() {
        Vacina vacina = new Vacina("Antirrábica", new Date());
        Date data = new Date();
        vacina.setData(data);
        assertEquals(data, vacina.getData());  
    }
}
