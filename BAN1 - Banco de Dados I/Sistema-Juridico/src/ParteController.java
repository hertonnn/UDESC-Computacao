import java.sql.Connection;
import java.sql.SQLException;
import java.util.HashSet;
import java.util.Scanner;

public class ParteController {

    public void createParte(Connection con) throws SQLException {
        Scanner input = new Scanner(System.in);
        System.out.println("Insira os seguintes dados para criar uma nova Parte:");
        System.out.print("ID da Pessoa (fk_id_pessoa): ");
        int fkIdPessoa = Integer.parseInt(input.nextLine());
        System.out.print("ID do Processo (fk_id_processo): ");
        int fkIdProcesso = Integer.parseInt(input.nextLine());
        System.out.print("Tipo da parte (Autor, Réu, Testemunha): ");
        String parteTipo = input.nextLine();

        ParteBean pb = new ParteBean(fkIdPessoa, fkIdProcesso, parteTipo);
        ParteModel.create(pb, con);
        System.out.println("Parte criada com sucesso!!");
    }

    void listarPartes(Connection con) throws SQLException {
        HashSet<ParteBean> all = ParteModel.listAll(con);
        for (ParteBean pb : all) {
            System.out.println(pb.toString());
        }
    }

    public void removerParte(Connection con) throws SQLException {
        Scanner input = new Scanner(System.in);
        System.out.print("Informe o ID da Pessoa (fk_id_pessoa) da Parte que deseja remover: ");
        int fkIdPessoa = input.nextInt();
        System.out.print("Informe o ID do Processo (fk_id_processo) da Parte que deseja remover: ");
        int fkIdProcesso = input.nextInt();
        ParteModel.removeById(fkIdPessoa, fkIdProcesso, con);
        System.out.println("Parte removida com sucesso!");
    }

    public void listarPartesComDetalhes(Connection con) throws SQLException {
        HashSet<ParteComDetalhesBean> partes = ParteModel.listarPartesComDetalhes(con);
        System.out.println("=== TODAS AS PARTES COM DETALHES ===");
        for (ParteComDetalhesBean p : partes) {
            System.out.println(p.toString());
        }
    }

    public void listarPartesPorProcesso(Connection con) throws SQLException {
        Scanner input = new Scanner(System.in);
        System.out.print("Informe o ID do Processo para listar suas partes: ");
        int idProcesso = input.nextInt();
        
        HashSet<ParteComDetalhesBean> partes = ParteModel.listarPartesPorProcesso(idProcesso, con);
        if (partes.isEmpty()) {
            System.out.println("Nenhuma parte encontrada para este processo.");
        } else {
            System.out.println("=== PARTES DO PROCESSO " + idProcesso + " ===");
            for (ParteComDetalhesBean p : partes) {
                System.out.println(p.toString());
            }
        }
    }
} 