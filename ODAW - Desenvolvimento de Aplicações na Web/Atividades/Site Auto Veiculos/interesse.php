<?php
// 1. CONEXÃO COM O BANCO DE DADOS
$host = 'localhost';
$dbname = 'autoveiculos_db';
$user = 'root';
$pass = ''; // Sua senha do MySQL (vazia no XAMPP padrão Windows)

try {
    $pdo = new PDO("mysql:host=$host;dbname=$dbname", $user, $pass);
    $pdo->setAttribute(PDO::ATTR_ERRMODE, PDO::ERRMODE_EXCEPTION);
} catch (PDOException $e) {
    die("Erro na conexão: " . $e->getMessage());
}

// 2. VARIÁVEIS PARA MODO DE EDIÇÃO
$edit_id = '';
$editData = [
    'nome' => '', 'email' => '', 'senha' => '', 'condicao' => 'seminovo',
    'modelo' => '', 'opcionais' => '', 'data_visita' => '', 'mensagem' => ''
];

// 3. LÓGICA DE CRUD (Create, Read, Update, Delete)

// A. INSERIR OU ALTERAR (POST)
if ($_SERVER['REQUEST_METHOD'] == 'POST') {
    $id = $_POST['id'] ?? null;
    $nome = trim($_POST['nome']);
    $email = trim($_POST['email']);
    $senha = $_POST['senha']; 
    $condicao = $_POST['condicao'] ?? '';
    $modelo = $_POST['modelo'] ?? '';
    
    // Transforma o array de checkboxes em uma string separada por vírgulas
    $opcionais = isset($_POST['opcionais']) ? implode(', ', $_POST['opcionais']) : '';
    
    $data_visita = $_POST['data_visita'] ?? null;
    $mensagem = trim($_POST['mensagem']);

    // Validação básica PHP (além das validações HTML5 e JS)
    if (!empty($nome) && filter_var($email, FILTER_VALIDATE_EMAIL)) {
        if ($id) {
            // ALTERAR
            $sql = "UPDATE interesses SET nome=?, email=?, senha=?, condicao=?, modelo=?, opcionais=?, data_visita=?, mensagem=? WHERE id=?";
            $stmt = $pdo->prepare($sql);
            $stmt->execute([$nome, $email, $senha, $condicao, $modelo, $opcionais, $data_visita, $mensagem, $id]);
        } else {
            // INSERIR
            $sql = "INSERT INTO interesses (nome, email, senha, condicao, modelo, opcionais, data_visita, mensagem) VALUES (?, ?, ?, ?, ?, ?, ?, ?)";
            $stmt = $pdo->prepare($sql);
            $stmt->execute([$nome, $email, $senha, $condicao, $modelo, $opcionais, $data_visita, $mensagem]);
        }
        header("Location: interesse.php");
        exit;
    }
}

// B. EXCLUIR (GET)
if (isset($_GET['excluir'])) {
    $stmt = $pdo->prepare("DELETE FROM interesses WHERE id = ?");
    $stmt->execute([$_GET['excluir']]);
    header("Location: interesse.php");
    exit;
}

// C. CARREGAR DADOS PARA EDIÇÃO (GET)
if (isset($_GET['editar'])) {
    $stmt = $pdo->prepare("SELECT * FROM interesses WHERE id = ?");
    $stmt->execute([$_GET['editar']]);
    $result = $stmt->fetch(PDO::FETCH_ASSOC);
    if ($result) {
        $edit_id = $result['id'];
        $editData = $result;
    }
}

// D. VISUALIZAR TODOS OS REGISTROS
$stmt = $pdo->query("SELECT * FROM interesses ORDER BY id DESC");
$registros = $stmt->fetchAll(PDO::FETCH_ASSOC);
?>

<!DOCTYPE html>
<html lang="pt-BR">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Auto Veículos - Cadastro de Interesse</title>
    <link rel="stylesheet" href="style.css">
    <script src="script.js" defer></script>
    <style>
        /* Estilos adicionais para a tabela de registros */
        .tabela-registros { width: 100%; border-collapse: collapse; margin-top: 20px; }
        .tabela-registros th, .tabela-registros td { padding: 10px; border-bottom: 1px solid #cbd5e1; text-align: left; }
        .tabela-registros th { background-color: #f1f5f9; color: #0f172a; }
        .acao-btn { padding: 5px 10px; text-decoration: none; border-radius: 4px; font-size: 14px; font-weight: bold; }
        .btn-edit { background-color: #f59e0b; color: white; margin-right: 5px; }
        .btn-delete { background-color: #ef4444; color: white; }
    </style>
</head>
<body>

    <header>
        <h1>Auto Veículos</h1>
        <p>Inovação, tecnologia e aventura em cada detalhe</p>
    </header>

    <nav>
        <a href="primeiro.html">Início</a>
        <a href="segundo.html">Catálogo</a>
        <a href="terceiro.html">Experiência</a>
        <a href="interesse.php">Gestão de Interesses</a>
    </nav>

    <main class="container">
        
        <section class="card">
            <h2><?= $edit_id ? 'Editar Interesse de Compra' : 'Registrar Novo Interesse' ?></h2>
            <p>Preencha os dados abaixo. Nós aplicamos validações para garantir a qualidade das informações.</p>

            <form action="interesse.php" method="POST">
                <input type="hidden" name="id" value="<?= $edit_id ?>">
                
                <fieldset style="border: 1px solid #cbd5e1; border-radius: 8px; padding: 20px;">
                    <legend style="font-weight: bold; color: #0f172a; padding: 0 10px;">Dados do Cliente</legend>

                    <div class="form-group">
                        <label for="nome">Nome Completo:</label>
                        <input type="text" id="nome" name="nome" class="form-control" value="<?= htmlspecialchars($editData['nome']) ?>" required>
                    </div>

                    <div class="form-group">
                        <label for="email">E-mail:</label>
                        <input type="email" id="email" name="email" class="form-control" value="<?= htmlspecialchars($editData['email']) ?>" required>
                    </div>

                    <div class="form-group">
                        <label for="senha">Senha de Acesso (Simulação):</label>
                        <input type="password" id="senha" name="senha" class="form-control" value="<?= htmlspecialchars($editData['senha']) ?>" required>
                    </div>
                </fieldset>
                
                <br>

                <fieldset style="border: 1px solid #cbd5e1; border-radius: 8px; padding: 20px;">
                    <legend style="font-weight: bold; color: #0f172a; padding: 0 10px;">Preferências do Veículo</legend>

                    <div class="form-group">
                        <label>Condição do Veículo:</label><br>
                        <input type="radio" id="novo" name="condicao" value="novo" <?= $editData['condicao'] == 'novo' ? 'checked' : '' ?>>
                        <label for="novo">Zero KM</label>
                        
                        <input type="radio" id="seminovo" name="condicao" value="seminovo" <?= $editData['condicao'] == 'seminovo' ? 'checked' : '' ?>>
                        <label for="seminovo">Seminovo</label>
                    </div>

                    <div class="form-group">
                        <label for="modelo">Modelo de Interesse:</label>
                        <select id="modelo" name="modelo" class="form-control" required>
                            <option value="" disabled <?= empty($editData['modelo']) ? 'selected' : '' ?>>Selecione um carro...</option>
                            <option value="civic" <?= $editData['modelo'] == 'civic' ? 'selected' : '' ?>>Honda Civic</option>
                            <option value="corolla" <?= $editData['modelo'] == 'corolla' ? 'selected' : '' ?>>Toyota Corolla</option>
                            <option value="nivus" <?= $editData['modelo'] == 'nivus' ? 'selected' : '' ?>>VW Nivus</option>
                        </select>
                    </div>

                    <div class="form-group">
                        <label>Opcionais Desejados:</label><br>
                        <?php $opcionaisArray = explode(', ', $editData['opcionais']); ?>
                        <input type="checkbox" id="couro" name="opcionais[]" value="Bancos em Couro" <?= in_array('Bancos em Couro', $opcionaisArray) ? 'checked' : '' ?>>
                        <label for="couro">Bancos em Couro</label><br>
                        
                        <input type="checkbox" id="teto" name="opcionais[]" value="Teto Solar" <?= in_array('Teto Solar', $opcionaisArray) ? 'checked' : '' ?>>
                        <label for="teto">Teto Solar</label><br>
                        
                        <input type="checkbox" id="multimidia" name="opcionais[]" value="Kit Multimídia" <?= in_array('Kit Multimídia', $opcionaisArray) ? 'checked' : '' ?>>
                        <label for="multimidia">Kit Multimídia</label>
                    </div>

                    <div class="form-group">
                        <label for="data_visita">Melhor data para visita:</label>
                        <input type="date" id="data_visita" name="data_visita" class="form-control" style="width: auto;" value="<?= $editData['data_visita'] ?>" required>
                    </div>

                    <div class="form-group">
                        <label for="mensagem">Mensagem Adicional:</label>
                        <textarea id="mensagem" name="mensagem" class="form-control" rows="3"><?= htmlspecialchars($editData['mensagem']) ?></textarea>
                    </div>

                    <button type="submit" class="btn-primary"><?= $edit_id ? 'Atualizar Interesse' : 'Enviar Interesse' ?></button>
                    <?php if($edit_id): ?>
                        <a href="interesse.php" style="margin-left: 10px; color: #64748b; text-decoration: none;">Cancelar Edição</a>
                    <?php endif; ?>
                </fieldset>
            </form>
        </section>

        <section class="card">
            <h2>Interesses Registrados</h2>
            <div style="overflow-x: auto;">
                <table class="tabela-registros">
                    <thead>
                        <tr>
                            <th>ID</th>
                            <th>Cliente</th>
                            <th>Contato</th>
                            <th>Modelo</th>
                            <th>Condição</th>
                            <th>Data Visita</th>
                            <th>Ações</th>
                        </tr>
                    </thead>
                    <tbody>
                        <?php if (count($registros) > 0): ?>
                            <?php foreach ($registros as $row): ?>
                            <tr>
                                <td><?= $row['id'] ?></td>
                                <td><?= htmlspecialchars($row['nome']) ?></td>
                                <td><?= htmlspecialchars($row['email']) ?></td>
                                <td><span class="text-highlight"><?= ucfirst($row['modelo']) ?></span></td>
                                <td><?= ucfirst($row['condicao']) ?></td>
                                <td><?= $row['data_visita'] ? date('d/m/Y', strtotime($row['data_visita'])) : '-' ?></td>
                                <td>
                                    <a href="?editar=<?= $row['id'] ?>" class="acao-btn btn-edit">Editar</a>
                                    <a href="?excluir=<?= $row['id'] ?>" class="acao-btn btn-delete" onclick="return confirm('Tem certeza que deseja apagar o registro de <?= $row['nome'] ?>?');">Excluir</a>
                                </td>
                            </tr>
                            <?php endforeach; ?>
                        <?php else: ?>
                            <tr>
                                <td colspan="7" style="text-align: center; color: #64748b;">Nenhum interesse registrado ainda.</td>
                            </tr>
                        <?php endif; ?>
                    </tbody>
                </table>
            </div>
        </section>

    </main>

    <footer>
        <p>&copy; 2026 Auto Veículos. Todos os direitos reservados.</p>
    </footer>

</body>
</html>