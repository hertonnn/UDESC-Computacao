import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Statement;
import java.util.HashSet;

public class TramiteModel {

    public static void create(TramiteBean t, Connection con) throws SQLException {
        PreparedStatement st = con.prepareStatement(
            "INSERT INTO Tramite (fk_id_processo, data_hora, tipo, descricao) VALUES (?, ?, ?, ?)"
        );
        st.setInt(1, t.getFkIdProcesso());
        st.setTimestamp(2, t.getDataHora());
        st.setString(3, t.getTipo());
        st.setString(4, t.getDescricao());
        st.execute();
        st.close();
    }

    static HashSet<TramiteBean> listAll(Connection con) throws SQLException {
        Statement st = con.createStatement();
        HashSet<TramiteBean> list = new HashSet<>();
        String sql = "SELECT id_tramite, fk_id_processo, data_hora, tipo, descricao FROM Tramite";
        ResultSet result = st.executeQuery(sql);
        while(result.next()) {
            list.add(new TramiteBean(
                result.getInt("id_tramite"),
                result.getInt("fk_id_processo"),
                result.getTimestamp("data_hora"),
                result.getString("tipo"),
                result.getString("descricao")
            ));
        }
        result.close();
        st.close();
        return list;
    }

    public static void removeById(int idTramite, Connection con) throws SQLException {
        PreparedStatement st = con.prepareStatement("DELETE FROM Tramite WHERE id_tramite = ?");
        st.setInt(1, idTramite);
        st.executeUpdate();
        st.close();
    }
} 