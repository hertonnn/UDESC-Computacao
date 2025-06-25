import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Statement;
import java.util.HashSet;

public class ProcessoModel {

    public static void create(ProcessoBean p, Connection con) throws SQLException {
        PreparedStatement st = con.prepareStatement(
            "INSERT INTO Processo (numero_processo, tipo_processo, assunto, status, data_inicio, data_encerramento, fk_id_vara) VALUES (?, ?, ?, ?, ?, ?, ?)"
        );
        st.setString(1, p.getNumeroProcesso());
        st.setString(2, p.getTipoProcesso());
        st.setString(3, p.getAssunto());
        st.setString(4, p.getStatus());
        st.setDate(5, p.getDataInicio());
        st.setDate(6, p.getDataEncerramento());
        st.setInt(7, p.getFkIdVara());
        st.execute();
        st.close();
    }

    static HashSet<ProcessoBean> listAll(Connection con) throws SQLException {
        Statement st = con.createStatement();
        HashSet<ProcessoBean> list = new HashSet<>();
        String sql = "SELECT id_processo, numero_processo, tipo_processo, assunto, status, data_inicio, data_encerramento, fk_id_vara FROM Processo";
        ResultSet result = st.executeQuery(sql);
        while(result.next()) {
            list.add(new ProcessoBean(
                result.getInt("id_processo"),
                result.getString("numero_processo"),
                result.getString("tipo_processo"),
                result.getString("assunto"),
                result.getString("status"),
                result.getDate("data_inicio"),
                result.getDate("data_encerramento"),
                result.getInt("fk_id_vara")
            ));
        }
        result.close();
        st.close();
        return list;
    }

    public static void removeById(int idProcesso, Connection con) throws SQLException {
        PreparedStatement st = con.prepareStatement("DELETE FROM Processo WHERE id_processo = ?");
        st.setInt(1, idProcesso);
        st.executeUpdate();
        st.close();
    }
} 