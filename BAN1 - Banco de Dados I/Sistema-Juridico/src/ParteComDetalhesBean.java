public class ParteComDetalhesBean {
    private int idProcesso;
    private String numeroProcesso;
    private String assunto;
    private int idPessoa;
    private String nomePessoa;
    private String parteTipo;

    public ParteComDetalhesBean(int idProcesso, String numeroProcesso, String assunto, 
                               int idPessoa, String nomePessoa, String parteTipo) {
        this.idProcesso = idProcesso;
        this.numeroProcesso = numeroProcesso;
        this.assunto = assunto;
        this.idPessoa = idPessoa;
        this.nomePessoa = nomePessoa;
        this.parteTipo = parteTipo;
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

    public String getAssunto() {
        return assunto;
    }

    public void setAssunto(String assunto) {
        this.assunto = assunto;
    }

    public int getIdPessoa() {
        return idPessoa;
    }

    public void setIdPessoa(int idPessoa) {
        this.idPessoa = idPessoa;
    }

    public String getNomePessoa() {
        return nomePessoa;
    }

    public void setNomePessoa(String nomePessoa) {
        this.nomePessoa = nomePessoa;
    }

    public String getParteTipo() {
        return parteTipo;
    }

    public void setParteTipo(String parteTipo) {
        this.parteTipo = parteTipo;
    }

    @Override
    public String toString() {
        return "Processo: " + numeroProcesso + 
               " | Assunto: " + assunto + 
               " | Pessoa: " + nomePessoa + 
               " | Tipo: " + parteTipo;
    }
} 