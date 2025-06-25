import java.sql.Connection;
import java.sql.SQLException;
import java.util.HashSet;
import java.util.Scanner;

public class ProcessoController {

    public void createProcesso(Connection con) throws SQLException {
        Scanner input = new Scanner(System.in);
        System.out.println("Insira os seguintes dados para criar um novo Processo: ");
        System.out.print("Número do processo: ");
        String numeroProcesso = input.nextLine();
        System.out.print("Tipo do processo: ");
        String tipoProcesso = input.nextLine();
        System.out.print("Assunto: ");
        String assunto = input.nextLine();
        System.out.print("Status: ");
        String status = input.nextLine();
        System.out.print("Data de início (YYYY-MM-DD): ");
        String dataInicioStr = input.nextLine();
        java.sql.Date dataInicio = java.sql.Date.valueOf(dataInicioStr);
        System.out.print("Data de encerramento (YYYY-MM-DD, deixe vazio se não houver): ");
        String dataEncStr = input.nextLine();
        java.sql.Date dataEncerramento = null;
        if (!dataEncStr.isEmpty()) {
            dataEncerramento = java.sql.Date.valueOf(dataEncStr);
        }
        System.out.print("ID da Vara (fk_id_vara): ");
        int fkIdVara = Integer.parseInt(input.nextLine());

        ProcessoBean pb = new ProcessoBean(numeroProcesso, tipoProcesso, assunto, status, dataInicio, dataEncerramento, fkIdVara);
        ProcessoModel.create(pb, con);
        System.out.println("Processo criado com sucesso!!");
    }

    void listarProcessos(Connection con) throws SQLException {
        HashSet<ProcessoBean> all = ProcessoModel.listAll(con);
        for (ProcessoBean pb : all) {
            System.out.println(pb.toString());
        }
    }

    public void removerProcesso(Connection con) throws SQLException {
        Scanner input = new Scanner(System.in);
        System.out.print("Informe o ID do Processo que deseja remover: ");
        int idProcesso = input.nextInt();
        ProcessoModel.removeById(idProcesso, con);
        System.out.println("Processo removido com sucesso!");
    }
} 