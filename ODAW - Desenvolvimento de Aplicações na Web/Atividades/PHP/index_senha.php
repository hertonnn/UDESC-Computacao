<?php
/**
 * EXERCÍCIOS PHP CONSOLIDADOS
 * 1. Formulário completo com validação
 * 2. Login via arquivo de texto
 * 3. Hashing de senha (Segurança)
 */

session_start();
date_default_timezone_set('America/Sao_Paulo');

// --- VARIÁVEIS DE CONTROLE ---
$erros_form = [];
$sucesso_form = false;
$msg_login = "";
$msg_hash = "";

// --- 1. LÓGICA DO FORMULÁRIO DE CADASTRO ---
$nome  = $_POST['nome'] ?? '';
$email = $_POST['email'] ?? '';
$senha = $_POST['senha_reg'] ?? '';
$cidade = $_POST['cidade'] ?? '';
$genero = $_POST['genero'] ?? '';
$bio    = $_POST['bio'] ?? '';
$termos = isset($_POST['termos']);

if ($_SERVER["REQUEST_METHOD"] == "POST" && isset($_POST['btn_cadastro'])) {
    // Validação de campos vazios
    if (empty($nome) || empty($email) || empty($senha) || empty($cidade) || empty($genero) || empty($bio) || !$termos) {
        $erros_form[] = "Todos os campos do cadastro são obrigatórios.";
    } else {
        // Validação específica 1: E-mail
        if (!filter_var($email, FILTER_VALIDATE_EMAIL)) {
            $erros_form[] = "O formato do e-mail é inválido.";
        }
        // Validação específica 2: Senha (mínimo 6 caracteres)
        if (strlen($senha) < 6) {
            $erros_form[] = "A senha deve ter no mínimo 6 caracteres.";
        }
    }

    if (empty($erros_form)) {
        $sucesso_form = true;
    }
}

// --- 2. LÓGICA DO LOGIN (ARQUIVO TXT) ---
if ($_SERVER["REQUEST_METHOD"] == "POST" && isset($_POST['btn_login'])) {
    $user_login = $_POST['user_login'] ?? '';
    $pass_login = $_POST['pass_login'] ?? '';
    
    // Criar arquivo de exemplo caso não exista (admin;123456)
    if (!file_exists('autenticacao.txt')) {
        file_put_contents('autenticacao.txt', "admin;123456" . PHP_EOL . "aluno;udesc2026");
    }

    $usuarios = file('autenticacao.txt', FILE_IGNORE_NEW_LINES);
    $autenticado = false;

    foreach ($usuarios as $linha) {
        if (empty(trim($linha))) continue;
        list($u, $s) = explode(';', $linha);
        if ($user_login === $u && $pass_login === $s) {
            $autenticado = true;
            break;
        }
    }
    $msg_login = $autenticado ? "<span style='color:green'>✅ Acesso permitido!</span>" : "<span style='color:red'>❌ Usuário ou senha incorretos.</span>";
}

// --- 3. LÓGICA DE HASHING (CIFRAGEM) ---
$hash_exemplo = "";
if ($_SERVER["REQUEST_METHOD"] == "POST" && isset($_POST['btn_hash'])) {
    $texto_puro = $_POST['texto_hash'] ?? '';
    if (!empty($texto_puro)) {
        $hash_exemplo = password_hash($texto_puro, PASSWORD_DEFAULT);
        $msg_hash = "Hash gerado com sucesso!";
    }
}
?>

<!DOCTYPE html>
<html lang="pt-br">
<head>
    <meta charset="UTF-8">
    <title>Laboratório PHP - Integrado</title>
    <style>
        body { font-family: 'Segoe UI', Tahoma, Geneva, Verdana, sans-serif; background: #f0f2f5; padding: 20px; color: #333; }
        .container { max-width: 800px; margin: auto; }
        section { background: white; padding: 20px; margin-bottom: 20px; border-radius: 10px; box-shadow: 0 4px 6px rgba(0,0,0,0.1); }
        h2 { border-bottom: 2px solid #007bff; padding-bottom: 10px; color: #007bff; }
        .erro-box { background: #ffe3e3; border-left: 5px solid #ff4d4d; padding: 10px; margin-bottom: 15px; }
        .sucesso-box { background: #e3ffe3; border-left: 5px solid #2ecc71; padding: 10px; margin-bottom: 15px; }
        .field { margin-bottom: 15px; }
        label { display: block; font-weight: bold; margin-bottom: 5px; }
        input[type="text"], input[type="password"], textarea, select { width: 100%; padding: 8px; border: 1px solid #ccc; border-radius: 4px; box-sizing: border-box; }
        button { background: #007bff; color: white; border: none; padding: 10px 20px; border-radius: 4px; cursor: pointer; }
        button[type="reset"] { background: #6c757d; }
        button:hover { opacity: 0.9; }
        code { background: #f8f9fa; padding: 2px 4px; border-radius: 4px; color: #d63384; }
    </style>
</head>
<body>

<div class="container">
    <h1>Exercícios de Programação Web</h1>
    <p>Hoje é <strong><?= date('d/m/Y') ?></strong> e agora são <strong><?= date('H:i') ?>h</strong></p>

    <section>
        <h2>1. Formulário de Cadastro e Validação</h2>
        
        <?php if (!empty($erros_form)): ?>
            <div class="erro-box">
                <strong>Erros encontrados:</strong>
                <ul><?php foreach ($erros_form as $e) echo "<li>$e</li>"; ?></ul>
            </div>
        <?php endif; ?>

        <?php if ($sucesso_form): ?>
            <div class="sucesso-box">
                <h3>✅ Cadastro Confirmado!</h3>
                <p><strong>Nome:</strong> <?= htmlspecialchars($nome) ?> | <strong>E-mail:</strong> <?= htmlspecialchars($email) ?></p>
                <p><strong>Cidade:</strong> <?= $cidade ?> | <strong>Gênero:</strong> <?= $genero ?></p>
                <p><strong>Bio:</strong> <?= nl2br(htmlspecialchars($bio)) ?></p>
            </div>
        <?php endif; ?>

        <form method="POST">
            <div class="field">
                <label>Nome Completo:</label>
                <input type="text" name="nome" value="<?= htmlspecialchars($nome) ?>">
            </div>
            <div class="field">
                <label>E-mail:</label>
                <input type="text" name="email" value="<?= htmlspecialchars($email) ?>">
            </div>
            <div class="field">
                <label>Senha:</label>
                <input type="password" name="senha_reg">
            </div>
            <div class="field">
                <label>Cidade:</label>
                <select name="cidade">
                    <option value="">Selecione...</option>
                    <option value="Joinville" <?= $cidade == 'Joinville' ? 'selected' : '' ?>>Joinville</option>
                    <option value="Florianópolis" <?= $cidade == 'Florianópolis' ? 'selected' : '' ?>>Florianópolis</option>
                </select>
            </div>
            <div class="field">
                <label>Gênero:</label>
                <input type="radio" name="genero" value="Masculino" <?= $genero == 'Masculino' ? 'checked' : '' ?>> M
                <input type="radio" name="genero" value="Feminino" <?= $genero == 'Feminino' ? 'checked' : '' ?>> F
            </div>
            <div class="field">
                <label>Biografia:</label>
                <textarea name="bio" rows="3"><?= htmlspecialchars($bio) ?></textarea>
            </div>
            <div class="field">
                <input type="checkbox" name="termos" <?= $termos ? 'checked' : '' ?>> Aceito os termos de uso.
            </div>
            <button type="submit" name="btn_cadastro">Enviar Cadastro</button>
            <button type="reset">Limpar</button>
        </form>
    </section>

    <section>
        <h2>2. Autenticação (via autenticacao.txt)</h2>
        <p><?= $msg_login ?></p>
        <form method="POST">
            <div class="field">
                <input type="text" name="user_login" placeholder="Usuário (tente: admin)" required>
            </div>
            <div class="field">
                <input type="password" name="pass_login" placeholder="Senha (tente: 123456)" required>
            </div>
            <button type="submit" name="btn_login">Entrar no Sistema</button>
        </form>
    </section>

    <section>
        <h2>3. Cifragem e Validação de Dados</h2>
        
        <p>Utilize <code>password_hash()</code> para transformar senhas em códigos seguros.</p>
        <form method="POST">
            <div class="field">
                <input type="text" name="texto_hash" placeholder="Digite algo para cifrar..." required>
            </div>
            <button type="submit" name="btn_hash">Gerar Hash Seguro</button>
        </form>

        <?php if ($hash_exemplo): ?>
            <div style="margin-top: 15px; word-break: break-all;">
                <strong>Texto Original:</strong> <?= htmlspecialchars($_POST['texto_hash']) ?><br>
                <strong>Hash Gerado:</strong> <code><?= $hash_exemplo ?></code>
                <p><small>Note que cada vez que você gera um hash para a mesma palavra, o resultado muda (devido ao Salt interno), mas o PHP consegue validar todos eles.</small></p>
            </div>
        <?php endif; ?>
    </section>
</div>

</body>
</html>