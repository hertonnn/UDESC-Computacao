/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/UnitTests/JUnit5TestClass.java to edit this template
 */
package negocio;

import dados.*;
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
public class SistemaTest {
    
    public SistemaTest() {
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
    public void testBuscaPorRaca() {
        Sistema sistema = new Sistema();
        
        Endereco endereco = new Endereco("Iririú", "Joinville", "Santa Catarina");
        ONG ong = new ONG(1, "ONG 1", "123456789", "ong@teste.com", "47912345678", endereco, "senhaONG");
        Animal animal1 = new Animal(1, "Joca", "Labrador", "Grande", 5, "Macho", "Cachorro", "Nenhuma", ong);
        Animal animal2 = new Animal(2, "Zed", "Poodle", "Pequeno", 3, "Macho", "Cachorro", "Nenhuma", ong);
        
        sistema.getAnimaisCadastrados().add(animal1);
        sistema.getAnimaisCadastrados().add(animal2);
        
        ArrayList<Animal> resultado = sistema.busca(Filtro.RACA, "Labrador");
        
        assertEquals(1, resultado.size());
        assertEquals(animal1, resultado.get(0));
    }
    
    @Test
    public void testBuscaPorPorte() {
        Sistema sistema = new Sistema();
        
        Endereco endereco = new Endereco("Iririú", "Joinville", "Santa Catarina");
        ONG ong = new ONG(1, "ONG 1", "123456789", "ong@teste.com", "47912345678", endereco, "senhaONG");
        Animal animal1 = new Animal(1, "Joca", "Labrador", "Grande", 5, "Macho", "Cachorro", "Nenhuma", ong);
        Animal animal2 = new Animal(2, "Zed", "Poodle", "Pequeno", 3, "Macho", "Cachorro", "Nenhuma", ong);
        
        sistema.getAnimaisCadastrados().add(animal1);
        sistema.getAnimaisCadastrados().add(animal2);
        
        ArrayList<Animal> resultado = sistema.busca(Filtro.PORTE, "Pequeno");
        
        assertEquals(1, resultado.size());
        assertEquals(animal2, resultado.get(0));
    }
    
    @Test
    public void testBuscaPorSexo() {
        Sistema sistema = new Sistema();
        
        Endereco endereco = new Endereco("Iririú", "Joinville", "Santa Catarina");
        ONG ong = new ONG(1, "ONG 1", "123456789", "ong@teste.com", "47912345678", endereco, "senhaONG");
        Animal animal1 = new Animal(1, "Joca", "Labrador", "Grande", 5, "Macho", "Cachorro", "Nenhuma", ong);
        Animal animal2 = new Animal(2, "Zed", "Poodle", "Pequeno", 3, "Macho", "Cachorro", "Nenhuma", ong);
        
        sistema.getAnimaisCadastrados().add(animal1);
        sistema.getAnimaisCadastrados().add(animal2);
        
        ArrayList<Animal> resultado = sistema.busca(Filtro.SEXO, "Macho");
        
        assertEquals(2, resultado.size());
        assertEquals(animal1, resultado.get(0));
        assertEquals(animal2, resultado.get(1));
    }
    
    @Test
    public void testBuscaPorIdade() {
        Sistema sistema = new Sistema();
        
        Endereco endereco = new Endereco("Iririú", "Joinville", "Santa Catarina");
        ONG ong = new ONG(1, "ONG 1", "123456789", "ong@teste.com", "47912345678", endereco, "senhaONG");
        Animal animal1 = new Animal(1, "Joca", "Labrador", "Grande", 5, "Macho", "Cachorro", "Nenhuma", ong);
        Animal animal2 = new Animal(2, "Zed", "Poodle", "Pequeno", 3, "Macho", "Cachorro", "Nenhuma", ong);
        
        sistema.getAnimaisCadastrados().add(animal1);
        sistema.getAnimaisCadastrados().add(animal2);
        
        ArrayList<Animal> resultado = sistema.busca(Filtro.IDADE, "5");
        
        assertEquals(1, resultado.size());
        assertEquals(animal1, resultado.get(0));
    }
    
    @Test
    public void testBuscaPorCidade() {
        Sistema sistema = new Sistema();
        
        Endereco endereco = new Endereco("Iririú", "Joinville", "Santa Catarina");
        ONG ong1 = new ONG(1, "ONG 1", "123456789", "ong1@teste.com", "47912345678", endereco, "senhaONG1");
        ONG ong2 = new ONG(2, "ONG 2", "987654321", "ong2@teste.com", "47987654321", endereco, "senhaONG2");
        Animal animal1 = new Animal(1, "Joca", "Labrador", "Grande", 5, "Macho", "Cachorro", "Nenhuma", ong1);
        Animal animal2 = new Animal(2, "Zed", "Poodle", "Pequeno", 3, "Macho", "Cachorro", "Nenhuma", ong2);
        
        sistema.getAnimaisCadastrados().add(animal1);
        sistema.getAnimaisCadastrados().add(animal2);
        
        ArrayList<Animal> resultado = sistema.busca(Filtro.CIDADE, "Joinville");
        
        assertEquals(2, resultado.size());
        assertEquals(animal1, resultado.get(0));
        assertEquals(animal2, resultado.get(1));  
    }
    
    @Test
    public void testBuscaPorEstado() {
        Sistema sistema = new Sistema();
        
        Endereco endereco = new Endereco("Iririú", "Joinville", "Santa Catarina");
        ONG ong1 = new ONG(1, "ONG 1", "123456789", "ong1@teste.com", "47912345678", endereco, "senhaONG1");
        ONG ong2 = new ONG(2, "ONG 2", "987654321", "ong2@teste.com", "47987654321", endereco, "senhaONG2");
        Animal animal1 = new Animal(1, "Joca", "Labrador", "Grande", 5, "Macho", "Cachorro", "Nenhuma", ong1);
        Animal animal2 = new Animal(2, "Zed", "Poodle", "Pequeno", 3, "Macho", "Cachorro", "Nenhuma", ong2);
        
        sistema.getAnimaisCadastrados().add(animal1);
        sistema.getAnimaisCadastrados().add(animal2);
        
        ArrayList<Animal> resultado = sistema.busca(Filtro.ESTADO, "Santa Catarina");
        
        assertEquals(2, resultado.size());
        assertEquals(animal1, resultado.get(0));
        assertEquals(animal2, resultado.get(1));  
    }
    
    @Test
    public void testBuscaPorBairro() {
        Sistema sistema = new Sistema();
        
        Endereco endereco = new Endereco("Iririú", "Joinville", "Santa Catarina");
        ONG ong1 = new ONG(1, "ONG 1", "123456789", "ong1@teste.com", "47912345678", endereco, "senhaONG1");
        ONG ong2 = new ONG(2, "ONG 2", "987654321", "ong2@teste.com", "47987654321", endereco, "senhaONG2");
        Animal animal1 = new Animal(1, "Joca", "Labrador", "Grande", 5, "Macho", "Cachorro", "Nenhuma", ong1);
        Animal animal2 = new Animal(2, "Zed", "Poodle", "Pequeno", 3, "Macho", "Cachorro", "Nenhuma", ong2);
        
        sistema.getAnimaisCadastrados().add(animal1);
        sistema.getAnimaisCadastrados().add(animal2);
        
        ArrayList<Animal> resultado = sistema.busca(Filtro.BAIRRO, "Iririú");
        
        assertEquals(2, resultado.size());
        assertEquals(animal1, resultado.get(0));
        assertEquals(animal2, resultado.get(1));  
    }
    
    @Test
    public void testBuscaPorNecessidadesEspeciais() {
        Sistema sistema = new Sistema();
    
        Endereco endereco = new Endereco("Iririú", "Joinville", "Santa Catarina");
        ONG ong = new ONG(1, "ONG 1", "123456789", "ong@teste.com", "47912345678", endereco, "senhaONG");
        Animal animal1 = new Animal(1, "Joca", "Labrador", "Grande", 5, "Macho", "Cachorro", "Cego", ong);
        Animal animal2 = new Animal(2, "Zed", "Poodle", "Pequeno", 3, "Macho", "Cachorro", "Nenhuma", ong);
    
        sistema.getAnimaisCadastrados().add(animal1);
        sistema.getAnimaisCadastrados().add(animal2);
    
        ArrayList<Animal> resultado = sistema.busca(Filtro.NECESSIDADESESPECIAIS, "Cego");
    
        assertEquals(1, resultado.size());
        assertEquals(animal1, resultado.get(0));
    }
    
    @Test
    public void testBuscaPorONG() {
        Sistema sistema = new Sistema();
    
        Endereco endereco = new Endereco("Iririú", "Joinville", "Santa Catarina");
        ONG ong = new ONG(1, "ONG 1", "123456789", "ong@teste.com", "47912345678", endereco, "senhaONG");
        Animal animal1 = new Animal(1, "Joca", "Labrador", "Grande", 5, "Macho", "Cachorro", "Cego", ong);
        Animal animal2 = new Animal(2, "Zed", "Poodle", "Pequeno", 3, "Macho", "Cachorro", "Nenhuma", ong);
    
        sistema.getAnimaisCadastrados().add(animal1);
        sistema.getAnimaisCadastrados().add(animal2);
    
        ArrayList<Animal> resultado = sistema.busca(Filtro.ONG, "ONG 1");
    
        assertEquals(2, resultado.size());
        assertEquals(animal1, resultado.get(0));
        assertEquals(animal2, resultado.get(1));
    }
    
    @Test
    public void testBuscaPorComportamente() {
        Sistema sistema = new Sistema();
    
        Endereco endereco = new Endereco("Iririú", "Joinville", "Santa Catarina");
        ONG ong = new ONG(1, "ONG 1", "123456789", "ong@teste.com", "47912345678", endereco, "senhaONG");
        Animal animal1 = new Animal(1, "Joca", "Labrador", "Grande", 5, "Macho", "Cachorro", "Cego", ong);
        animal1.setPersonalide("Agressivo");
        Animal animal2 = new Animal(2, "Zed", "Poodle", "Pequeno", 3, "Macho", "Cachorro", "Nenhuma", ong);
        animal2.setPersonalide("Calmo");
    
        sistema.getAnimaisCadastrados().add(animal1);
        sistema.getAnimaisCadastrados().add(animal2);
    
        ArrayList<Animal> resultado = sistema.busca(Filtro.COMPORTAMENTO, "Calmo");
    
        assertEquals(1, resultado.size());
        assertEquals(animal2, resultado.get(0));
    }
    
    @Test
    public void testBuscaPorEspecie() {
        Sistema sistema = new Sistema();
    
        Endereco endereco = new Endereco("Iririú", "Joinville", "Santa Catarina");
        ONG ong = new ONG(1, "ONG 1", "123456789", "ong@teste.com", "47912345678", endereco, "senhaONG");
        Animal animal1 = new Animal(1, "Joca", "Labrador", "Grande", 5, "Macho", "Cachorro", "Cego", ong);
        animal1.setPersonalide("Agressivo");
        Animal animal2 = new Animal(2, "Zed", "Poodle", "Pequeno", 3, "Macho", "Gato", "Nenhuma", ong);
        animal2.setPersonalide("Calmo");
    
        sistema.getAnimaisCadastrados().add(animal1);
        sistema.getAnimaisCadastrados().add(animal2);
    
        ArrayList<Animal> resultado = sistema.busca(Filtro.ESPECIE, "Gato");
    
        assertEquals(1, resultado.size());
        assertEquals(animal2, resultado.get(0));
    }
    
    @Test
    public void testGettersAndSetters() {
        Sistema sistema = new Sistema();
        
        ArrayList<Animal> animais = new ArrayList<>();
        ArrayList<ONG> ongs = new ArrayList<>();
        ArrayList<Usuario> usuarios = new ArrayList<>();
        
        sistema.setAnimaisCadastrados(animais);
        sistema.setOngsCadastradas(ongs);
        sistema.setUsuariosCadastrados(usuarios);
        
        assertEquals(animais, sistema.getAnimaisCadastrados());
        assertEquals(ongs, sistema.getOngsCadastradas());
        assertEquals(usuarios, sistema.getUsuariosCadastrados());
    } 
}
