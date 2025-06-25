/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
import java.sql.Connection;
//import java.sql.DriverManager;
//import java.sql.ResultSet;
import java.sql.SQLException;
//import java.sql.Statement;
import java.util.Scanner;

/**
 *
 * @author rebeca
 */
public class Principal {

    public static void main(String[] args) throws SQLException {
        Conexao c = new Conexao();
        Connection con = c.getConnection();
        int op = 0;
        do{
            op = menu();
            try {
                switch (op) {
                    // VARA
                    case 1: new VaraController().createVara(con);
                            break;
                    case 2: new VaraController().listarVaras(con);
                            break;
                    case 3: new VaraController().removerVara(con);
                            break;
                    case 4: new VaraController().listarEstatisticasPorVara(con);
                            break;
                    case 5: new VaraController().listarEstatisticasGerais(con);
                            break;
                    // PESSOA
                    case 6: new PessoaController().createPessoa(con);
                            break;
                    case 7: new PessoaController().listarPessoas(con);
                            break;
                    case 8: new PessoaController().removerPessoa(con);
                            break;
                    // PROCESSO
                    case 9: new ProcessoController().createProcesso(con);
                            break;
                    case 10: new ProcessoController().listarProcessos(con);
                            break;
                    case 11: new ProcessoController().removerProcesso(con);
                            break;
                    // PARTE
                    case 12: new ParteController().createParte(con);
                            break;
                    case 13: new ParteController().listarPartes(con);
                            break;
                    case 14: new ParteController().removerParte(con);
                            break;
                    case 15: new ParteController().listarPartesComDetalhes(con);
                            break;
                    case 16: new ParteController().listarPartesPorProcesso(con);
                            break;
                    // TRÂMITE
                    case 17: new TramiteController().createTramite(con);
                            break;
                    case 18: new TramiteController().listarTramites(con);
                            break;
                    case 19: new TramiteController().removerTramite(con);
                            break;
                }
            }catch(SQLException ex) {
                //ex.printStackTrace();
                System.out.println(ex.getMessage());
                continue;
            }
        } while(op>0 && op<20);  
        con.close();
    }    
    
    private static int menu() {
        System.out.println("\n==================== MENU PRINCIPAL ====================");
        System.out.println(" VARA");
        System.out.println("  1  - Inserir uma nova vara");
        System.out.println("  2  - Exibir todas as varas");
        System.out.println("  3  - Remover uma vara");
        System.out.println("  4  - Estatísticas por vara");
        System.out.println("  5  - Estatísticas gerais");
        System.out.println("--------------------------------------------------------");
        System.out.println(" PESSOA");
        System.out.println("  6  - Inserir uma nova pessoa");
        System.out.println("  7  - Exibir todas as pessoas");
        System.out.println("  8  - Remover uma pessoa");
        System.out.println("--------------------------------------------------------");
        System.out.println(" PROCESSO");
        System.out.println("  9  - Inserir um novo processo");
        System.out.println(" 10  - Exibir todos os processos");
        System.out.println(" 11  - Remover um processo");
        System.out.println("--------------------------------------------------------");
        System.out.println(" PARTE");
        System.out.println(" 12  - Inserir uma nova parte");
        System.out.println(" 13  - Exibir todas as partes");
        System.out.println(" 14  - Remover uma parte");
        System.out.println(" 15  - Exibir todas as partes com detalhes");
        System.out.println(" 16  - Exibir partes de um processo específico");
        System.out.println("--------------------------------------------------------");
        System.out.println(" TRÂMITE");
        System.out.println(" 17  - Inserir um novo trâmite");
        System.out.println(" 18  - Exibir todos os trâmites");
        System.out.println(" 19  - Remover um trâmite");
        System.out.println("========================================================");
        System.out.println("Digite qualquer outro valor para sair");
        System.out.print("Sua opção: ");
        Scanner input = new Scanner(System.in);
        return input.nextInt();
    }
}
