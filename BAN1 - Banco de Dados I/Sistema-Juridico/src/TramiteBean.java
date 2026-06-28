public class TramiteBean {
    private int idTramite;
    private int fkIdProcesso;
    private java.sql.Timestamp dataHora;
    private String tipo;
    private String descricao;

    public TramiteBean(int idTramite, int fkIdProcesso, java.sql.Timestamp dataHora, String tipo, String descricao) {
        this.idTramite = idTramite;
        this.fkIdProcesso = fkIdProcesso;
        this.dataHora = dataHora;
        this.tipo = tipo;
        this.descricao = descricao;
    }

    public TramiteBean(int fkIdProcesso, java.sql.Timestamp dataHora, String tipo, String descricao) {
        this.fkIdProcesso = fkIdProcesso;
        this.dataHora = dataHora;
        this.tipo = tipo;
        this.descricao = descricao;
    }

    public int getIdTramite() {
        return idTramite;
    }

    public void setIdTramite(int idTramite) {
        this.idTramite = idTramite;
    }

    public int getFkIdProcesso() {
        return fkIdProcesso;
    }

    public void setFkIdProcesso(int fkIdProcesso) {
        this.fkIdProcesso = fkIdProcesso;
    }

    public java.sql.Timestamp getDataHora() {
        return dataHora;
    }

    public void setDataHora(java.sql.Timestamp dataHora) {
        this.dataHora = dataHora;
    }

    public String getTipo() {
        return tipo;
    }

    public void setTipo(String tipo) {
        this.tipo = tipo;
    }

    public String getDescricao() {
        return descricao;
    }

    public void setDescricao(String descricao) {
        this.descricao = descricao;
    }

    @Override
    public String toString() {
        return "id_tramite: " + idTramite +
               ", fk_id_processo: " + fkIdProcesso +
               ", data_hora: " + dataHora +
               ", tipo: " + tipo +
               ", descricao: " + descricao;
    }
} 