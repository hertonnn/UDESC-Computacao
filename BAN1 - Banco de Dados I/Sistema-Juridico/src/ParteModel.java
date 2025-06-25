import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Statement;
import java.util.HashSet;

public class ParteModel {

    public static void create(ParteBean p, Connection con) throws SQLException {
        PreparedStatement st = con.prepareStatement(
            "INSERT INTO Parte (fk_id_pessoa, fk_id_processo, parte_tipo) VALUES (?, ?, ?)"
        );
        st.setInt(1, p.getFkIdPessoa());
        st.setInt(2, p.getFkIdProcesso());
        st.setString(3, p.getParteTipo());
        st.execute();
        st.close();
    }

    static HashSet<ParteBean> listAll(Connection con) throws SQLException {
        Statement st = con.createStatement();
        HashSet<ParteBean> list = new HashSet<>();
        String sql = "SELECT fk_id_pessoa, fk_id_processo, parte_tipo FROM Parte";
        ResultSet result = st.executeQuery(sql);
        while(result.next()) {
            list.add(new ParteBean(
                result.getInt("fk_id_pessoa"),
                result.getInt("fk_id_processo"),
                result.getString("parte_tipo")
            ));
        }
        result.close();
        st.close();
        return list;
    }

    public static void removeById(int fkIdPessoa, int fkIdProcesso, Connection con) throws SQLException {
        PreparedStatement st = con.prepareStatement("DELETE FROM Parte WHERE fk_id_pessoa = ? AND fk_id_processo = ?");
        st.setInt(1, fkIdPessoa);
        st.setInt(2, fkIdProcesso);
        st.executeUpdate();
        st.close();
    }

    public static HashSet<ParteComDetalhesBean> listarPartesComDetalhes(Connection con) throws SQLException {
        Statement st = con.createStatement();
        HashSet<ParteComDetalhesBean> list = new HashSet<>();
        String sql = "SELECT p.fk_id_processo, pr.numero_processo, pr.assunto, " +
                     "p.fk_id_pessoa, CONCAT(pe.primeiro_nome, ' ', pe.ultimo_nome) as nome_pessoa, " +
                     "p.parte_tipo " +
                     "FROM Parte p " +
                     "JOIN Processo pr ON p.fk_id_processo = pr.id_processo " +
                     "JOIN Pessoa pe ON p.fk_id_pessoa = pe.id_pessoa " +
                     "ORDER BY pr.numero_processo, p.parte_tipo";
        ResultSet result = st.executeQuery(sql);
        while(result.next()) {
            list.add(new ParteComDetalhesBean(
                result.getInt("fk_id_processo"),
                result.getString("numero_processo"),
                result.getString("assunto"),
                result.getInt("fk_id_pessoa"),
                result.getString("nome_pessoa"),
                result.getString("parte_tipo")
            ));
        }
        result.close();
        st.close();
        return list;
    }

    public static HashSet<ParteComDetalhesBean> listarPartesPorProcesso(int idProcesso, Connection con) throws SQLException {
        PreparedStatement st = con.prepareStatement(
            "SELECT p.fk_id_processo, pr.numero_processo, pr.assunto, " +
            "p.fk_id_pessoa, CONCAT(pe.primeiro_nome, ' ', pe.ultimo_nome) as nome_pessoa, " +
            "p.parte_tipo " +
            "FROM Parte p " +
            "JOIN Processo pr ON p.fk_id_processo = pr.id_processo " +
            "JOIN Pessoa pe ON p.fk_id_pessoa = pe.id_pessoa " +
            "WHERE p.fk_id_processo = ? " +
            "ORDER BY p.parte_tipo"
        );
        st.setInt(1, idProcesso);
        ResultSet result = st.executeQuery();
        HashSet<ParteComDetalhesBean> list = new HashSet<>();
        while(result.next()) {
            list.add(new ParteComDetalhesBean(
                result.getInt("fk_id_processo"),
                result.getString("numero_processo"),
                result.getString("assunto"),
                result.getInt("fk_id_pessoa"),
                result.getString("nome_pessoa"),
                result.getString("parte_tipo")
            ));
        }
        result.close();
        st.close();
        return list;
    }
} 