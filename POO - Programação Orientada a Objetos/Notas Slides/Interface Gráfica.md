# Interface Gráfica em Java

## Introdução
- Java possui uma série de recursos nativos para a criação de interfaces gráficas.
- Iremos utilizar recursos de duas bibliotecas:
  - **AWT**: A ideia do AWT é que os recursos gráficos atendam ao estilo da plataforma na qual são executadas (design diferente no Linux e Windows).
  - **Swing**: É uma extensão da AWT. Basicamente, os componentes utilizados são da biblioteca Swing e os eventos são da AWT.

### Componentes Iniciais
- **JFrame**: É a janela da aplicação, podendo agrupar outros componentes dentro de si.
- **JPanel**: É um container para outros componentes, isto é, uma caixa que abriga os demais componentes.
- **JLabel**: Exibe textos ou imagens na tela.
- **JTextField**: É uma caixa utilizada para a entrada de dados em texto.
- **JButton**: É um botão que executa uma determinada ação quando pressionado.
- **JCheckBox**: É uma caixa que possui dois estados booleanos (marcada ou desmarcada).
- **JComboBox**: É uma gaveta que armazena uma lista de objetos do qual o usuário pode selecionar um deles.
- **JList**: É uma lista de objetos, semelhante a uma tabela de uma só coluna.
- **JTable**: É uma tabela de dados que podem ser editáveis.
- **JOptionPane**: Exibe um alerta na tela.

## Janelas
Para criar janelas, precisamos estender a classe `JFrame` (biblioteca `javax.swing.JFrame`).
Principais métodos:
- `setTitle(String titulo)`: Adiciona um título.
- `setDefaultCloseOperation(int arg0)`: Define o comportamento ao fechar a janela:
  - `JFrame.DO_NOTHING_ON_CLOSE`: Nada acontece.
  - `JFrame.HIDE_ON_CLOSE`: Apenas esconde a janela.
  - `JFrame.DISPOSE_ON_CLOSE`: Fecha apenas a janela, mas continua executando.
  - `JFrame.EXIT_ON_CLOSE`: Fecha a janela e encerra a aplicação.
- `setBounds(int x, int y, int tamanhoX, int tamanhoY)`: Define origem (x, y) e tamanho da janela em pixels.
- `setResizable(boolean arg)`: Define se é redimensionável.
- `setBorder(Border borda)`: Define uma borda.
- `setLayout(LayoutManager layout)`: Define o layout.
- `setIconImage(Image icone)`: Define o ícone do sistema.
- `add(Component componente)`: Adiciona um componente.
- `setVisible(boolean arg0)`: Define a visibilidade.

**Implementação de JFrame:**
```java
import javax.swing.JFrame;

public class ExemploJFrame extends JFrame {
    public ExemploJFrame() {
        setTitle("Exemplo");
        setBounds(50, 50, 300, 300);
        setDefaultCloseOperation(JFrame.EXIT_ON_CLOSE);
        setResizable(false);
    }
    
    public static void main(String[] args) {
        ExemploJFrame exemplo = new ExemploJFrame();
        exemplo.setVisible(true);
    }
}
```

## Painéis
Painéis (`JPanel`) servem para organizar o código e os componentes. Eles não existem sem um `JFrame`.
Principais métodos:
- `setBounds(...)` e `setBorder(...)` e `setLayout(...)` e `add(...)`.
- `setBackground(Color cor)`: Define a cor de fundo.

**Implementação de JPanel:**
```java
import java.awt.Color;
import javax.swing.JPanel;
import javax.swing.JFrame;

public class ExemploJPanel extends JPanel {
    public ExemploJPanel() {
        setBackground(Color.MAGENTA);
    }
}

public class Principal extends JFrame {
    public Principal() {
        setTitle("Exemplo");
        setBounds(50, 50, 300, 300);
        setDefaultCloseOperation(JFrame.EXIT_ON_CLOSE);
    }
    
    public static void main(String[] args) {
        Principal exemplo = new Principal();
        exemplo.add(new ExemploJPanel());
        exemplo.setVisible(true);
    }
}
```

### Painéis Multi-Abas
Usamos `JTabbedPane` para abas.
```java
import javax.swing.JPanel;
import javax.swing.JTabbedPane;
import javax.swing.JFrame;

public class ExemploJTabbedPane extends JTabbedPane {
    public ExemploJTabbedPane() {
        this.addTab("Aba 1", new JPanel());
        this.addTab("Aba 2", new JPanel());
        this.addTab("Aba 3", new JPanel());
    }
}

public class Principal extends JFrame {
    public Principal() {
        setTitle("Exemplo");
        setBounds(50, 50, 300, 300);
        setDefaultCloseOperation(JFrame.EXIT_ON_CLOSE);
    }
    
    public static void main(String[] args) {
        Principal exemplo = new Principal();
        exemplo.add(new ExemploJTabbedPane());
        exemplo.setVisible(true);
    }
}
```

### Painéis Scrollaveis
`JScrollPane`: usado quando o componente é grande demais e/ou cresce (listas e tabelas).

## Criando Bordas
Factory `javax.swing.BorderFactory`:
- `createLineBorder(Color cor)`: Borda com cor.
- `createTitledBorder(String titulo)` ou `createTitledBorder(Border borda, String titulo)`: Borda com título.

```java
import java.awt.Color;
import javax.swing.JPanel;
import javax.swing.border.Border;
import javax.swing.BorderFactory;

public class ExemploBorder extends JPanel {
    public ExemploBorder() {
        Border lineBorder = BorderFactory.createLineBorder(Color.BLACK);
        setBorder(BorderFactory.createTitledBorder(lineBorder, "Exemplo de borda"));
    }
}
```

## Textos e Imagens
Usamos `JLabel`. Métodos:
- `setText(String text)`: Define texto.
- `setIcon(Icon icone)`: Define ícone.
- `setHorizontalAlignment(int arg0)`: `JLabel.LEFT`, `JLabel.CENTER`, `JLabel.RIGHT`.
- `setVerticalAlignment(int arg0)`: `JLabel.TOP`, `JLabel.CENTER`, `JLabel.BOTTOM`.

**Exibindo Textos:**
```java
import java.awt.Color;
import javax.swing.JLabel;
import javax.swing.JPanel;
import javax.swing.BorderFactory;

public class ExemploJLabel extends JPanel {
    public ExemploJLabel() {
        setLayout(null);
        
        JLabel texto = new JLabel("Exemplo de texto");
        texto.setBounds(20, 20, 150, 20);
        texto.setHorizontalAlignment(JLabel.LEFT);
        texto.setBorder(BorderFactory.createLineBorder(Color.black));
        add(texto);
        
        JLabel texto2 = new JLabel("Exemplo de texto");
        texto2.setBounds(20, 50, 150, 20);
        texto2.setHorizontalAlignment(JLabel.CENTER);
        texto2.setBorder(BorderFactory.createLineBorder(Color.black));
        add(texto2);
        
        JLabel texto3 = new JLabel("Exemplo de texto");
        texto3.setBounds(20, 80, 150, 20);
        texto3.setHorizontalAlignment(JLabel.RIGHT);
        texto3.setBorder(BorderFactory.createLineBorder(Color.black));
        add(texto3);
    }
}
```

**Exibindo Imagens:**
```java
import javax.swing.ImageIcon;
import javax.swing.JLabel;
import javax.swing.JPanel;

public class ExemploImagem extends JPanel {
    public ExemploImagem() {
        JLabel imagem = new JLabel(new ImageIcon("jlabel/udesc.png"));
        add(imagem);
    }
}
```

## Botões
Botões usam o padrão Observer com `ActionListener`.
- `addActionListener(ActionListener actionListener)`: Observa e executa ações.

```java
import java.awt.Color;
import java.awt.event.ActionEvent;
import java.awt.event.ActionListener;
import javax.swing.JButton;
import javax.swing.JPanel;

public class ExemploJButton extends JPanel {
    public ExemploJButton() {
        JButton button = new JButton("Pressione");
        add(button);
        button.addActionListener(new ActionListener() {
            @Override
            public void actionPerformed(ActionEvent arg0) {
                trocaCor();
            }
        });
    }

    public void trocaCor() {
        if (getBackground().equals(Color.BLUE)) {
            setBackground(Color.RED);
        } else {
            setBackground(Color.BLUE);
        }
    }
}
```

## Tipos de Layouts
1. **Layout Absoluto (`null`)**: Delega para os objetos a posição e tamanho (`setBounds`, `setLocation`, `setSize`).
```java
import javax.swing.JButton;
import javax.swing.JFrame;

public class ExemploNullLayout extends JFrame {
    public ExemploNullLayout() {
        setTitle("Exemplo");
        setSize(300, 300);
        setLocation(50, 50);
        setDefaultCloseOperation(JFrame.EXIT_ON_CLOSE);
        setLayout(null);
    }

    public static void main(String[] args) {
        ExemploNullLayout exemplo = new ExemploNullLayout();
        exemplo.setVisible(true);

        JButton botao1 = new JButton("Botao 1");
        botao1.setBounds(50, 50, 100, 20);
        exemplo.add(botao1);
        
        JButton botao2 = new JButton("Botao 2");
        botao2.setBounds(120, 80, 100, 20);
        exemplo.add(botao2);
        
        JButton botao3 = new JButton("Botao 3");
        botao3.setBounds(85, 110, 100, 20);
        exemplo.add(botao3);
    }
}
```

2. **GridLayout**: Divide em células `n x m`.
```java
import javax.swing.JButton;
import javax.swing.JFrame;
import java.awt.GridLayout;

public class ExemploGridLayout extends JFrame {
    public ExemploGridLayout() {
        setTitle("Exemplo");
        setSize(300, 300);
        setLocation(50, 50);
        setDefaultCloseOperation(JFrame.EXIT_ON_CLOSE);
        setLayout(new GridLayout(2, 3));
    }
    
    public static void main(String[] args) {
        ExemploGridLayout exemplo = new ExemploGridLayout();
        exemplo.setVisible(true);
        exemplo.add(new JButton("Botao 1"));
        exemplo.add(new JButton("Botao 2"));
        exemplo.add(new JButton("Botao 3"));
        exemplo.add(new JButton("Botao 4"));
        exemplo.add(new JButton("Botao 5"));
    }
}
```

3. **FlowLayout**: Lado a lado (esquerda para direita, cima para baixo).
```java
import java.awt.FlowLayout;
import javax.swing.JButton;
import javax.swing.JFrame;

public class ExemploFlowLayout extends JFrame {
    public ExemploFlowLayout() {
        setTitle("Exemplo");
        setSize(300, 300);
        setLocation(50, 50);
        setDefaultCloseOperation(JFrame.EXIT_ON_CLOSE);
        setLayout(new FlowLayout());
    }

    public static void main(String[] args) {
        ExemploFlowLayout exemplo = new ExemploFlowLayout();
        exemplo.setVisible(true);
        exemplo.add(new JButton("Botao 1"));
        exemplo.add(new JButton("Botao 2"));
        exemplo.add(new JButton("Botao 3"));
        exemplo.add(new JButton("Botao 4"));
        exemplo.add(new JButton("Botao 5"));
    }
}
```

4. **BorderLayout**: Separa em Norte, Sul, Leste, Oeste, Centro.
```java
import java.awt.BorderLayout;
import javax.swing.JButton;
import javax.swing.JFrame;

public class ExemploBorderLayout extends JFrame {
    public ExemploBorderLayout() {
        setTitle("Exemplo");
        setSize(300, 300);
        setLocation(50, 50);
        setDefaultCloseOperation(JFrame.EXIT_ON_CLOSE);
        setLayout(new BorderLayout());
    }

    public static void main(String[] args) {
        ExemploBorderLayout ex = new ExemploBorderLayout();
        ex.setVisible(true);
        ex.add(new JButton("Botao 1"), BorderLayout.NORTH);
        ex.add(new JButton("Botao 2"), BorderLayout.SOUTH);
        ex.add(new JButton("Botao 3"), BorderLayout.EAST);
        ex.add(new JButton("Botao 4"), BorderLayout.WEST);
        ex.add(new JButton("Botao 5"), BorderLayout.CENTER);
    }
}
```

5. **CardLayout**: Revezamento de painéis.
```java
import java.awt.CardLayout;
import java.awt.BorderLayout;
import java.awt.Color;
import java.awt.event.ActionEvent;
import java.awt.event.ActionListener;
import javax.swing.JButton;
import javax.swing.JFrame;
import javax.swing.JPanel;

public class ExemploCardLayout extends JFrame {
    private CardLayout cardLayout = new CardLayout();
    private JPanel painelCard = new JPanel(cardLayout);
    private JButton botao = new JButton("Trocar");

    public ExemploCardLayout() {
        setTitle("Exemplo");
        setSize(300, 300);
        setLocation(50, 50);
        setDefaultCloseOperation(JFrame.EXIT_ON_CLOSE);
        setLayout(new BorderLayout());

        add(painelCard, BorderLayout.CENTER);
        add(botao, BorderLayout.SOUTH);

        JPanel vermelho = new JPanel();
        vermelho.setBackground(Color.RED);
        painelCard.add(vermelho);

        JPanel azul = new JPanel();
        azul.setBackground(Color.BLUE);
        painelCard.add(azul);

        botao.addActionListener(new ActionListener() {
            public void actionPerformed(ActionEvent arg0) {
                cardLayout.next(painelCard);
            }
        });
    }

    public static void main(String[] args) {
        ExemploCardLayout exemplo = new ExemploCardLayout();
        exemplo.setVisible(true);
    }
}
```

## Entradas de Texto
**JTextField**
```java
import javax.swing.JPanel;
import javax.swing.JTextField;

public class ExemploJTextField extends JPanel {
    public ExemploJTextField() {
        JTextField textField = new JTextField();
        textField.setColumns(10);
        add(textField);
    }
}
```

## CheckBox
**JCheckBox**
```java
import javax.swing.JCheckBox;
import javax.swing.JPanel;

public class ExemploJCheckBox extends JPanel {
    public ExemploJCheckBox() {
        JCheckBox checkBox = new JCheckBox("Clique para selecionar");
        add(checkBox);
    }
}
```

## ComboBox e Listas
**JComboBox**
```java
import javax.swing.JComboBox;
import javax.swing.JPanel;

public class ExemploJComboBox extends JPanel {
    public ExemploJComboBox() {
        String[] itens = new String[] { "Escolha 1", "Escolha 2" };
        JComboBox<String> comboBox = new JComboBox<String>(itens);
        add(comboBox);
    }
}
```

**JList**
```java
import javax.swing.JList;
import javax.swing.JPanel;

public class ExemploJList extends JPanel {
    public ExemploJList() {
        String[] array = new String[] { "Item 1", "Item 2", "Item 3" };
        JList<String> jList = new JList<String>(array);
        add(jList);
    }
}
```

## Tabelas
**JTable**
Estender `AbstractTableModel`:
```java
import java.util.LinkedList;
import java.util.List;
import javax.swing.table.AbstractTableModel;

public class Cidade {
    private String nome;
    private String estado;
    
    public Cidade(String nome, String estado) {
        this.nome = nome;
        this.estado = estado;
    }
    public String getNome() { return this.nome; }
    public String getEstado() { return this.estado; }
}

public class Tabela extends AbstractTableModel {
    private List<Cidade> cidades = new LinkedList<Cidade>();

    @Override
    public int getColumnCount() {
        return 2;
    }

    @Override
    public int getRowCount() {
        return cidades.size();
    }

    @Override
    public Object getValueAt(int linha, int coluna) {
        switch (coluna) {
            case 0: return cidades.get(linha).getNome();
            case 1: return cidades.get(linha).getEstado();
            default: throw new IllegalArgumentException();
        }
    }

    @Override
    public String getColumnName(int coluna) {
        switch (coluna) {
            case 0: return "Nome da Cidade";
            case 1: return "Estado";
            default: throw new IllegalArgumentException();
        }
    }

    public void adicionarCidade(Cidade cidade) {
        cidades.add(cidade);
        this.fireTableStructureChanged();
    }
}
```

```java
import javax.swing.JScrollPane;
import javax.swing.JTable;

public class ExemploJTable extends JScrollPane {
    public ExemploJTable() {
        Tabela cidades = new Tabela();
        JTable table = new JTable(cidades);
        setViewportView(table);

        cidades.adicionarCidade(new Cidade("Joinville", "Santa Catarina"));
        cidades.adicionarCidade(new Cidade("Curitiba", "Parana"));
        cidades.adicionarCidade(new Cidade("Florianopolis", "Santa Catarina"));
    }
}
```

## Janelas de Opções
**JOptionPane**
- `showInputDialog()`
- `showMessageDialog()`
- `showConfirmDialog()`

```java
import java.awt.event.ActionEvent;
import java.awt.event.ActionListener;
import javax.swing.JButton;
import javax.swing.JOptionPane;
import javax.swing.JPanel;

public class ExemploJOptionPane extends JPanel {
    public ExemploJOptionPane() {
        JButton button = new JButton("Pressione");
        add(button);
        button.addActionListener(new ActionListener() {
            @Override
            public void actionPerformed(ActionEvent arg0) {
                JOptionPane.showMessageDialog(null, "O botao foi pressionado", "Botao Pressionado", JOptionPane.INFORMATION_MESSAGE);
            }
        });
    }
}
```
