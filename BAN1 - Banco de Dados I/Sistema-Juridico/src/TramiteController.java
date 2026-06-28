import java.sql.Connection;
import java.sql.SQLException;
import java.util.HashSet;
import java.util.Scanner;

public class TramiteController {

    public void createTramite(Connection con) throws SQLException {
        Scanner input = new Scanner(System.in);
        System.out.println("Insira os seguintes dados para criar um novo Trâmite:");
        System.out.print("ID do Processo (fk_id_processo): ");
        int fkIdProcesso = Integer.parseInt(input.nextLine());
        System.out.print("Data e hora (YYYY-MM-DD HH:MM:SS): ");
        String dataHoraStr = input.nextLine();
        java.sql.Timestamp dataHora = java.sql.Timestamp.valueOf(dataHoraStr);
        System.out.print("Tipo: ");
        String tipo = input.nextLine();
        System.out.print("Descrição: ");
        String descricao = input.nextLine();

        TramiteBean tb = new TramiteBean(fkIdProcesso, dataHora, tipo, descricao);
        TramiteModel.create(tb, con);
        System.out.println("Trâmite criado com sucesso!!");
    }

    void listarTramites(Connection con) throws SQLException {
        HashSet<TramiteBean> all = TramiteModel.listAll(con);
        for (TramiteBean tb : all) {
            System.out.println(tb.toString());
        }
    }

    public void removerTramite(Connection con) throws SQLException {
        Scanner input = new Scanner(System.in);
        System.out.print("Informe o ID do Trâmite que deseja remover: ");
        int idTramite = input.nextInt();
        TramiteModel.removeById(idTramite, con);
        System.out.println("Trâmite removido com sucesso!");
    }
} 