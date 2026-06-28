/*
   1. Impedir datas no passado no agendamento
   Arquivo alvo: segundo.html (Campo: data_visita)
*/
const dataVisita = document.getElementById('data_visita');
if (dataVisita) {
    const hoje = new Date();
    const ano = hoje.getFullYear();
    const mes = String(hoje.getMonth() + 1).padStart(2, '0');
    const dia = String(hoje.getDate()).padStart(2, '0');

    dataVisita.min = `${ano}-${mes}-${dia}`;
}

/*
   2. Capitalizar o nome automaticamente
   Arquivo alvo: segundo.html (Campo: nome)
*/
const inputNome = document.getElementById('nome');
if (inputNome) {
    inputNome.addEventListener('blur', function () {
        let palavras = this.value.toLowerCase().split(' ');

        for (let i = 0; i < palavras.length; i++) {
            if (palavras[i].length > 0) {
                palavras[i] = palavras[i][0].toUpperCase() + palavras[i].substring(1);
            }
        }
        this.value = palavras.join(' ');
    });
}

/*
   3. Máscara e validação de WhatsApp
   Arquivo alvo: terceiro.html (Campo: telefone)
*/
const inputTelefone = document.getElementById('telefone');
if (inputTelefone) {
    inputTelefone.addEventListener('input', function (e) {
        let num = e.target.value.replace(/\D/g, ''); 
        let formatado = num;

        if (num.length > 2) formatado = num.substring(0, 2) + ' ' + num.substring(2);
        if (num.length > 7) formatado = formatado.substring(0, 8) + '-' + formatado.substring(8, 12);

        e.target.value = formatado.substring(0, 13);
    });

    inputTelefone.addEventListener('blur', function () {
        const regexTelefone = /^\d{2} \d{5}-\d{4}$/;

        if (this.value.length > 0 && !regexTelefone.test(this.value)) {
            alert("Formato inválido! Por favor, insira o WhatsApp no formato: 47 99999-9999");
            this.value = '';
        }
    });
}

/*
   4. Calculadora de financiamento na tabela
   Arquivo alvo: segundo.html (Tabela de Preços)
*/
function calcularParcela(valorTotal, taxaMensal, meses) {
    const fator = Math.pow((1 + taxaMensal), meses);
    const prestacao = valorTotal * ((taxaMensal * fator) / (fator - 1));
    return prestacao;
}

const celulasPreco = document.querySelectorAll('tbody td:last-child');
celulasPreco.forEach(celula => {
    celula.style.cursor = 'pointer';
    celula.title = "Clique para simular financiamento em 48x";

    celula.addEventListener('click', function () {
        let textoPreco = this.innerText.replace('.', '').replace(',', '.');
        let valor = parseFloat(textoPreco);

        if (!isNaN(valor)) {
            let parcela = calcularParcela(valor, 0.015, 48); 
            alert(`Simulação para este veículo:\n48 parcelas de R$ ${parcela.toFixed(2)} (Taxa: 1.5% a.m.)`);
        }
    });
});

/*
   5. Confirmação inteligente do formulário
   Arquivo alvo: terceiro.html (Formulário do Simulador)
*/
const formSimulador = document.querySelector('#simulador form');
if (formSimulador) {
    formSimulador.addEventListener('submit', function (event) {
        event.preventDefault(); 

        let preferencias = [];
        const modelo = document.getElementById('modelo_fav').value;
        const potencia = document.getElementById('potencia').value;

        preferencias.push(modelo ? `Série: ${modelo}` : "Série não definida");
        preferencias.push(`Potência desejada: ${potencia} cv`);

        let resumoTextual = preferencias.join('\n');
        let confirmar = confirm(`Por favor, revise suas escolhas:\n\n${resumoTextual}\n\nDeseja salvar esta configuração?`);

        if (confirmar) {
            alert("Sua configuração foi salva com sucesso! (Simulação de envio)");
        }
    });
}