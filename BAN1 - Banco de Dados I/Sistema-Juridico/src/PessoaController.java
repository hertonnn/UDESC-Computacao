import java.sql.Connection;
import java.sql.SQLException;
import java.util.HashSet;
import java.util.Scanner;

public class PessoaController {

    public void createPessoa(Connection con) throws SQLException {
        Scanner input = new Scanner(System.in);
        System.out.println("Insira os seguintes dados para criar uma nova Pessoa: ");
        System.out.print("Primeiro nome: ");
        String primeiroNome = input.nextLine();
        System.out.print("Último nome: ");
        String ultimoNome = input.nextLine();
        System.out.print("CPF/CNPJ: ");
        String cpfCnpj = input.nextLine();
        System.out.print("Tipo de pessoa: ");
        String tipoPessoa = input.nextLine();
        System.out.print("Sexo (M/F): ");
        String sexo = input.nextLine();
        if(sexo.isEmpty()){
            sexo = null;
        }
        System.out.print("Data de nascimento (YYYY-MM-DD): ");
        String dataNascStr = input.nextLine();
        java.sql.Date dataNascimento = null;
        if (!dataNascStr.isEmpty()) {
            dataNascimento = java.sql.Date.valueOf(dataNascStr);
        }
        PessoaBean pb = new PessoaBean(primeiroNome, ultimoNome, cpfCnpj, tipoPessoa, sexo, dataNascimento);
        PessoaModel.create(pb, con);
        System.out.println("Pessoa criada com sucesso!!");
    }

    void listarPessoas(Connection con) throws SQLException {
        HashSet<PessoaBean> all = PessoaModel.listAll(con);
        for (PessoaBean pb : all) {
            System.out.println(pb.toString());
        }
    }

    public void removerPessoa(Connection con) throws SQLException {
        Scanner input = new Scanner(System.in);
        System.out.print("Informe o ID da Pessoa que deseja remover: ");
        int idPessoa = input.nextInt();
        PessoaModel.removeById(idPessoa, con);
        System.out.println("Pessoa removida com sucesso!");
    }
} 