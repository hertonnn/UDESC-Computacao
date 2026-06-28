public class EstatisticasVaraBean {
    private String nomeVara;
    private int totalProcessos;
    private int processosAtivos;
    private int processosEncerrados;
    private double mediaTramitesPorProcesso;

    public EstatisticasVaraBean(String nomeVara, int totalProcessos, int processosAtivos, 
                               int processosEncerrados, double mediaTramitesPorProcesso) {
        this.nomeVara = nomeVara;
        this.totalProcessos = totalProcessos;
        this.processosAtivos = processosAtivos;
        this.processosEncerrados = processosEncerrados;
        this.mediaTramitesPorProcesso = mediaTramitesPorProcesso;
    }

    public String getNomeVara() {
        return nomeVara;
    }

    public void setNomeVara(String nomeVara) {
        this.nomeVara = nomeVara;
    }

    public int getTotalProcessos() {
        return totalProcessos;
    }

    public void setTotalProcessos(int totalProcessos) {
        this.totalProcessos = totalProcessos;
    }

    public int getProcessosAtivos() {
        return processosAtivos;
    }

    public void setProcessosAtivos(int processosAtivos) {
        this.processosAtivos = processosAtivos;
    }

    public int getProcessosEncerrados() {
        return processosEncerrados;
    }

    public void setProcessosEncerrados(int processosEncerrados) {
        this.processosEncerrados = processosEncerrados;
    }

    public double getMediaTramitesPorProcesso() {
        return mediaTramitesPorProcesso;
    }

    public void setMediaTramitesPorProcesso(double mediaTramitesPorProcesso) {
        this.mediaTramitesPorProcesso = mediaTramitesPorProcesso;
    }

    @Override
    public String toString() {
        return String.format("Vara: %-20s | Total: %d | Ativos: %d | Encerrados: %d | Média Trâmites: %.2f", 
                           nomeVara, totalProcessos, processosAtivos, processosEncerrados, mediaTramitesPorProcesso);
    }
} 