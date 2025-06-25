import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Statement;
import java.util.HashSet;
import java.util.List;
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
public class VaraModel {

    public static void create(VaraBean v, Connection con) throws SQLException {
        PreparedStatement st = con.prepareStatement(
            "INSERT INTO Vara (nome, tipo, entrancia) VALUES (?, ?, ?)"
        );
        st.setString(1, v.getNome());
        st.setString(2, v.getTipo());
        st.setString(3, v.getEntrancia());
        st.execute();
        st.close();
    }

    static HashSet<VaraBean> listAll(Connection con) throws SQLException {
        Statement st = con.createStatement();
        HashSet<VaraBean> list = new HashSet<>();
        String sql = "SELECT id_vara, nome, tipo, entrancia FROM Vara";
        ResultSet result = st.executeQuery(sql);
        while(result.next()) {
            list.add(new VaraBean(
                result.getInt("id_vara"),
                result.getString("nome"),
                result.getString("tipo"),
                result.getString("entrancia")
            ));
        }
        result.close();
        st.close();
        return list;
    }

    public static void removeById(int idVara, Connection con) throws SQLException {
        PreparedStatement st = con.prepareStatement("DELETE FROM Vara WHERE id_vara = ?");
        st.setInt(1, idVara);
        st.executeUpdate();
        st.close();
    }

    public static HashSet<EstatisticasVaraBean> listarEstatisticasPorVara(Connection con) throws SQLException {
        Statement st = con.createStatement();
        HashSet<EstatisticasVaraBean> list = new HashSet<>();
        
        String sql = "SELECT " +
                     "    v.nome as nome_vara, " +
                     "    COUNT(p.id_processo) as total_processos, " +
                     "    SUM(CASE WHEN p.status = 'Em Andamento' THEN 1 ELSE 0 END) as processos_ativos, " +
                     "    SUM(CASE WHEN p.status = 'Concluído' THEN 1 ELSE 0 END) as processos_encerrados, " +
                     "    COALESCE(AVG((SELECT COUNT(t.id_tramite) FROM Tramite t WHERE t.fk_id_processo = p.id_processo)), 0) as media_tramites " +
                     "FROM Vara v " +
                     "LEFT JOIN Processo p ON v.id_vara = p.fk_id_vara " +
                     "GROUP BY v.id_vara, v.nome " +
                     "ORDER BY total_processos DESC, v.nome";
        
        ResultSet result = st.executeQuery(sql);
        while(result.next()) {
            list.add(new EstatisticasVaraBean(
                result.getString("nome_vara"),
                result.getInt("total_processos"),
                result.getInt("processos_ativos"),
                result.getInt("processos_encerrados"),
                result.getDouble("media_tramites")
            ));
        }
        result.close();
        st.close();
        return list;
    }

    public static HashSet<EstatisticasVaraBean> listarEstatisticasGerais(Connection con) throws SQLException {
        Statement st = con.createStatement();
        HashSet<EstatisticasVaraBean> list = new HashSet<>();
        
        String sql = "SELECT " +
                     "    'TOTAL GERAL' as nome_vara, " +
                     "    COUNT(p.id_processo) as total_processos, " +
                     "    SUM(CASE WHEN p.status = 'Em Andamento' THEN 1 ELSE 0 END) as processos_ativos, " +
                     "    SUM(CASE WHEN p.status = 'Concluído' THEN 1 ELSE 0 END) as processos_encerrados, " +
                     "    COALESCE(AVG((SELECT COUNT(t.id_tramite) FROM Tramite t WHERE t.fk_id_processo = p.id_processo)), 0) as media_tramites " +
                     "FROM Processo p";
        
        ResultSet result = st.executeQuery(sql);
        while(result.next()) {
            list.add(new EstatisticasVaraBean(
                result.getString("nome_vara"),
                result.getInt("total_processos"),
                result.getInt("processos_ativos"),
                result.getInt("processos_encerrados"),
                result.getDouble("media_tramites")
            ));
        }
        result.close();
        st.close();
        return list;
    }
}
