import org.snmp4j.CommunityTarget;
import org.snmp4j.PDU;
import org.snmp4j.Snmp;
import org.snmp4j.TransportMapping;
import org.snmp4j.event.ResponseEvent;
import org.snmp4j.mp.SnmpConstants;
import org.snmp4j.smi.*;
import org.snmp4j.transport.DefaultUdpTransportMapping;

public class GerenteSNMP {
    public static void main(String[] args) {
        // Valida se o Python passou os 4 argumentos necessários
        if (args.length < 4) {
            System.out.println("ERRO: Uso: java GerenteSNMP <IP> <Community> <Porta> <Acao 1=UP/2=DOWN>");
            System.exit(1);
        }

        String ip = args[0];
        String community = args[1];
        String porta = args[2];
        int acao = Integer.parseInt(args[3]);

        try {
            // 1. Iniciar o serviço de transporte UDP
            TransportMapping<UdpAddress> transport = new DefaultUdpTransportMapping();
            transport.listen();
            Snmp snmp = new Snmp(transport);

            // 2. Configurar o Alvo (o IP do Switch)
            Address targetAddress = GenericAddress.parse("udp:" + ip + "/161");
            CommunityTarget target = new CommunityTarget();
            target.setCommunity(new OctetString(community));
            target.setAddress(targetAddress);
            target.setRetries(2);
            target.setTimeout(2000); // Aguarda 2 segundos
            target.setVersion(SnmpConstants.version2c);

            // 3. Montar a mensagem (PDU) do tipo SET
            PDU pdu = new PDU();
            // OID MIB-II para status da porta é: 1.3.6.1.2.1.2.2.1.7.[indice_da_porta]
            OID oid = new OID("1.3.6.1.2.1.2.2.1.7." + porta);
            Variable var = new Integer32(acao);
            pdu.add(new VariableBinding(oid, var));
            pdu.setType(PDU.SET);

            // 4. Enviar a requisição para o Switch
            ResponseEvent responseEvent = snmp.send(pdu, target);
            PDU response = responseEvent.getResponse();

            // 5. Analisar a resposta e imprimir para o Python ler
            if (response != null) {
                if (response.getErrorStatus() == PDU.noError) {
                    System.out.println("SUCESSO: Porta " + porta + " alterada para " + acao);
                } else {
                    System.out.println("ERRO_SNMP: " + response.getErrorStatusText());
                }
            } else {
                System.out.println("ERRO: Timeout. O switch nao respondeu.");
            }
            
            snmp.close();
        } catch (Exception e) {
            System.out.println("ERRO_EXCECAO: " + e.getMessage());
        }
    }
}
