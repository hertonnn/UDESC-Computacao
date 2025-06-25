import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Statement;
import java.util.HashSet;

public class PessoaModel {

    public static void create(PessoaBean p, Connection con) throws SQLException {
        PreparedStatement st = con.prepareStatement(
            "INSERT INTO Pessoa (primeiro_nome, ultimo_nome, cpf_cnpj, tipo_pessoa, sexo, data_nascimento) VALUES (?, ?, ?, ?, ?, ?)"
        );
        st.setString(1, p.getPrimeiroNome());
        st.setString(2, p.getUltimoNome());
        st.setString(3, p.getCpfCnpj());
        st.setString(4, p.getTipoPessoa());
        st.setString(5, p.getSexo());
        st.setDate(6, p.getDataNascimento());
        st.execute();
        st.close();
    }

    static HashSet<PessoaBean> listAll(Connection con) throws SQLException {
        Statement st = con.createStatement();
        HashSet<PessoaBean> list = new HashSet<>();
        String sql = "SELECT id_pessoa, primeiro_nome, ultimo_nome, cpf_cnpj, tipo_pessoa, sexo, data_nascimento FROM Pessoa";
        ResultSet result = st.executeQuery(sql);
        while(result.next()) {
            list.add(new PessoaBean(
                result.getInt("id_pessoa"),
                result.getString("primeiro_nome"),
                result.getString("ultimo_nome"),
                result.getString("cpf_cnpj"),
                result.getString("tipo_pessoa"),
                result.getString("sexo"),
                result.getDate("data_nascimento")
            ));
        }
        result.close();
        st.close();
        return list;
    }

    public static void removeById(int idPessoa, Connection con) throws SQLException {
        PreparedStatement st = con.prepareStatement("DELETE FROM Pessoa WHERE id_pessoa = ?");
        st.setInt(1, idPessoa);
        st.executeUpdate();
        st.close();
    }
} 