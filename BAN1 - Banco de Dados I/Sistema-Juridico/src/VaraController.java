import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Statement;
import java.util.HashSet;
import java.util.Iterator;
import java.util.List;
import java.util.Scanner;
import java.util.logging.Level;
import java.util.logging.Logger;

/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */

/**
 *
 * @author rebeca
 */
public class VaraController {
    
    public void createVara(Connection con) throws SQLException {
        Scanner input = new Scanner(System.in);
        System.out.println("Insira os seguintes dados para criar uma nova Vara: ");
        System.out.print("Nome: ");
        String nome = input.nextLine();
        System.out.print("Tipo: ");
        String tipo = input.nextLine();
        System.out.print("Entrância: ");
        String entrancia = input.nextLine();
        VaraBean vb = new VaraBean(nome, tipo, entrancia);
        VaraModel.create(vb, con);
        System.out.println("Vara criada com sucesso!!");
    }

    void listarVaras(Connection con) throws SQLException {
        HashSet<VaraBean> all = VaraModel.listAll(con);
        for (VaraBean vb : all) {
            System.out.println(vb.toString());
        }
    }

    public void removerVara(Connection con) throws SQLException {
        Scanner input = new Scanner(System.in);
        System.out.print("Informe o ID da Vara que deseja remover: ");
        int idVara = input.nextInt();
        VaraModel.removeById(idVara, con);
        System.out.println("Vara removida com sucesso!");
    }

    public void listarEstatisticasPorVara(Connection con) throws SQLException {
        HashSet<EstatisticasVaraBean> estatisticas = VaraModel.listarEstatisticasPorVara(con);
        System.out.println("\n=== ESTATÍSTICAS POR VARA ===");
        System.out.println("Vara                    | Total | Ativos | Encerrados | Média Trâmites");
        System.out.println("------------------------|-------|--------|------------|----------------");
        for (EstatisticasVaraBean e : estatisticas) {
            System.out.println(e.toString());
        }
    }

    public void listarEstatisticasGerais(Connection con) throws SQLException {
        HashSet<EstatisticasVaraBean> estatisticas = VaraModel.listarEstatisticasGerais(con);
        System.out.println("\n=== ESTATÍSTICAS GERAIS ===");
        System.out.println("Vara                    | Total | Ativos | Encerrados | Média Trâmites");
        System.out.println("------------------------|-------|--------|------------|----------------");
        for (EstatisticasVaraBean e : estatisticas) {
            System.out.println(e.toString());
        }
    }
}
