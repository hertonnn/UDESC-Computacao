public class ParteBean {
    private int fkIdPessoa;
    private int fkIdProcesso;
    private String parteTipo;

    public ParteBean(int fkIdPessoa, int fkIdProcesso, String parteTipo) {
        this.fkIdPessoa = fkIdPessoa;
        this.fkIdProcesso = fkIdProcesso;
        this.parteTipo = parteTipo;
    }

    public int getFkIdPessoa() {
        return fkIdPessoa;
    }

    public void setFkIdPessoa(int fkIdPessoa) {
        this.fkIdPessoa = fkIdPessoa;
    }

    public int getFkIdProcesso() {
        return fkIdProcesso;
    }

    public void setFkIdProcesso(int fkIdProcesso) {
        this.fkIdProcesso = fkIdProcesso;
    }

    public String getParteTipo() {
        return parteTipo;
    }

    public void setParteTipo(String parteTipo) {
        this.parteTipo = parteTipo;
    }

    @Override
    public String toString() {
        return "fk_id_pessoa: " + fkIdPessoa +
               ", fk_id_processo: " + fkIdProcesso +
               ", parte_tipo: " + parteTipo;
    }
} 