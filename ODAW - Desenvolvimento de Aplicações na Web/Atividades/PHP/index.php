<?php
// --- CONFIGURAÇÕES E SESSÃO (Sempre no topo) ---
session_start();
date_default_timezone_set('America/Sao_Paulo');

// 1. Lógica da Data e Hora
$data = date('d/m/Y');
$hora = date('H:i');

// 2. Lógica de Strings e Arrays (Definição da Função)
function processarDados(array $entrada) {
    $saida = [];
    foreach ($entrada as $item) {
        // Trim remove espaços, strtolower padroniza para minúsculas e ucfirst capitaliza
        $saida[] = ucfirst(strtolower(trim($item)));
    }
    return $saida;
}
$listaNomes = ["  herton ", "UDESC", " PHP_STUDY  "];
$nomesFormatados = processarDados($listaNomes);

// 3. Lógica do Contador
$arquivo = 'contador.txt';
if (!file_exists($arquivo)) {
    file_put_contents($arquivo, '0');
}
$visitas = (int)file_get_contents($arquivo);
$visitas++;
file_put_contents($arquivo, $visitas);

// 4. Lógica de Session/Cookie
if (!isset($_SESSION['acessos_sessao'])) {
    $_SESSION['acessos_sessao'] = 1;
} else {
    $_SESSION['acessos_sessao']++;
}
// Criando um cookie que dura 1 hora
setcookie("usuario_logado", "Herton_Dev", time() + 3600);
?>

<!DOCTYPE html>
<html lang="pt-br">
<head>
    <meta charset="UTF-8">
    <title>Exercícios PHP - Consolidado</title>
    <style>
        body { font-family: sans-serif; line-height: 1.6; padding: 20px; background: #f4f4f4; }
        .card { background: white; padding: 15px; margin-bottom: 10px; border-radius: 8px; box-shadow: 0 2px 5px rgba(0,0,0,0.1); }
        h2 { color: #333; border-bottom: 2px solid #777bb4; padding-bottom: 5px; }
        code { background: #eee; padding: 2px 5px; }
    </style>
</head>
<body>

    <h1>Resultados dos Exercícios</h1>

    <div class="card">
        <h2>1 - Data e Hora</h2>
        <p>Hoje é <strong><?php echo $data; ?></strong> e agora são <strong><?php echo $hora; ?>h</strong></p>
    </div>

    <div class="card">
        <h2>2 - Função, Strings e Arrays</h2>
        <p>Dados originais: <code>["  herton ", "UDESC", " PHP_STUDY  "]</code></p>
        <p>Dados formatados: <strong><?php echo implode(", ", $nomesFormatados); ?></strong></p>
    </div>

    <div class="card">
        <h2>3 - Contador de Visitas</h2>
        <p>Esta página foi visitada <strong><?php echo $visitas; ?></strong> vezes.</p>
        <small>(Valor persistido no arquivo <code>contador.txt</code>)</small>
    </div>

    <div class="card">
        <h2>4 - Session & Cookie</h2>
        <p><strong>Session:</strong> Você interagiu com esta sessão <strong><?php echo $_SESSION['acessos_sessao']; ?></strong> vezes nesta aba.</p>
        <p><strong>Cookie:</strong> O valor do cookie <code>usuario_logado</code> é: 
            <strong><?php echo $_COOKIE['usuario_logado'] ?? 'Ainda não carregado (atualize a página)'; ?></strong>
        </p>
    </div>

</body>
</html>