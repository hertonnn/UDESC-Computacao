public class ProcessoBean {
    private int idProcesso;
    private String numeroProcesso;
    private String tipoProcesso;
    private String assunto;
    private String status;
    private java.sql.Date dataInicio;
    private java.sql.Date dataEncerramento;
    private int fkIdVara;

    public ProcessoBean(int idProcesso, String numeroProcesso, String tipoProcesso, String assunto, String status, java.sql.Date dataInicio, java.sql.Date dataEncerramento, int fkIdVara) {
        this.idProcesso = idProcesso;
        this.numeroProcesso = numeroProcesso;
        this.tipoProcesso = tipoProcesso;
        this.assunto = assunto;
        this.status = status;
        this.dataInicio = dataInicio;
        this.dataEncerramento = dataEncerramento;
        this.fkIdVara = fkIdVara;
    }

    public ProcessoBean(String numeroProcesso, String tipoProcesso, String assunto, String status, java.sql.Date dataInicio, java.sql.Date dataEncerramento, int fkIdVara) {
        this.numeroProcesso = numeroProcesso;
        this.tipoProcesso = tipoProcesso;
        this.assunto = assunto;
        this.status = status;
        this.dataInicio = dataInicio;
        this.dataEncerramento = dataEncerramento;
        this.fkIdVara = fkIdVara;
    }

    public int getIdProcesso() {
        return idProcesso;
    }

    public void setIdProcesso(int idProcesso) {
        this.idProcesso = idProcesso;
    }

    public String getNumeroProcesso() {
        return numeroProcesso;
    }

    public void setNumeroProcesso(String numeroProcesso) {
        this.numeroProcesso = numeroProcesso;
    }

    public String getTipoProcesso() {
        return tipoProcesso;
    }

    public void setTipoProcesso(String tipoProcesso) {
        this.tipoProcesso = tipoProcesso;
    }

    public String getAssunto() {
        return assunto;
    }

    public void setAssunto(String assunto) {
        this.assunto = assunto;
    }

    public String getStatus() {
        return status;
    }

    public void setStatus(String status) {
        this.status = status;
    }

    public java.sql.Date getDataInicio() {
        return dataInicio;
    }

    public void setDataInicio(java.sql.Date dataInicio) {
        this.dataInicio = dataInicio;
    }

    public java.sql.Date getDataEncerramento() {
        return dataEncerramento;
    }

    public void setDataEncerramento(java.sql.Date dataEncerramento) {
        this.dataEncerramento = dataEncerramento;
    }

    public int getFkIdVara() {
        return fkIdVara;
    }

    public void setFkIdVara(int fkIdVara) {
        this.fkIdVara = fkIdVara;
    }

    @Override
    public String toString() {
        return "id_processo: " + idProcesso +
               ", numero_processo: " + numeroProcesso +
               ", tipo_processo: " + tipoProcesso +
               ", assunto: " + assunto +
               ", status: " + status +
               ", data_inicio: " + dataInicio +
               ", data_encerramento: " + dataEncerramento +
               ", fk_id_vara: " + fkIdVara;
    }
} 