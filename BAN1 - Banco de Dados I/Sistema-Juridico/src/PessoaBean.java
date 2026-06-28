public class PessoaBean {
    private int idPessoa;
    private String primeiroNome;
    private String ultimoNome;
    private String cpfCnpj;
    private String tipoPessoa;
    private String sexo;
    private java.sql.Date dataNascimento;

    public PessoaBean(int idPessoa, String primeiroNome, String ultimoNome, String cpfCnpj, String tipoPessoa, String sexo, java.sql.Date dataNascimento) {
        this.idPessoa = idPessoa;
        this.primeiroNome = primeiroNome;
        this.ultimoNome = ultimoNome;
        this.cpfCnpj = cpfCnpj;
        this.tipoPessoa = tipoPessoa;
        this.dataNascimento = dataNascimento;
        this.sexo = sexo;
    }

    public PessoaBean(String primeiroNome, String ultimoNome, String cpfCnpj, String tipoPessoa, String sexo, java.sql.Date dataNascimento) {
        this.primeiroNome = primeiroNome;
        this.ultimoNome = ultimoNome;
        this.cpfCnpj = cpfCnpj;
        this.tipoPessoa = tipoPessoa;
        this.sexo = sexo;
        this.dataNascimento = dataNascimento;
    }

    public int getIdPessoa() {
        return idPessoa;
    }

    public void setIdPessoa(int idPessoa) {
        this.idPessoa = idPessoa;
    }

    public String getPrimeiroNome() {
        return primeiroNome;
    }

    public void setPrimeiroNome(String primeiroNome) {
        this.primeiroNome = primeiroNome;
    }

    public String getUltimoNome() {
        return ultimoNome;
    }

    public void setUltimoNome(String ultimoNome) {
        this.ultimoNome = ultimoNome;
    }

    public String getCpfCnpj() {
        return cpfCnpj;
    }

    public void setCpfCnpj(String cpfCnpj) {
        this.cpfCnpj = cpfCnpj;
    }

    public String getTipoPessoa() {
        return tipoPessoa;
    }

    public void setTipoPessoa(String tipoPessoa) {
        this.tipoPessoa = tipoPessoa;
    }

    public String getSexo() {
        return sexo;
    }

    public void setSexo(String sexo) {
        this.sexo = sexo;
    }

    public java.sql.Date getDataNascimento() {
        return dataNascimento;
    }

    public void setDataNascimento(java.sql.Date dataNascimento) {
        this.dataNascimento = dataNascimento;
    }

    @Override
    public String toString() {
        return "id_pessoa: " + idPessoa +
               ", primeiro_nome: " + primeiroNome +
               ", ultimo_nome: " + ultimoNome +
               ", cpf_cnpj: " + cpfCnpj +
               ", tipo_pessoa: " + tipoPessoa +
               ", sexo: " + sexo +
               ", data_nascimento: " + dataNascimento;
    }
} 