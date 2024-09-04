import 'package:flutter/material.dart';
import 'adicionar_produto.dart';
import 'buscar_produto.dart';
import 'repor_estoque.dart';
import 'listar_produtos.dart';
import 'vender_produto.dart';
import 'alterar_preco_saida.dart';
import 'alterar_preco_entrada.dart';
import 'alterar_preco_saida_todos.dart';
import 'vendas.dart';
import 'relatorio_estoque.dart'; // Novo import para a tela de relatório de estoque

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Gestão de Produtos',
      theme: ThemeData(
        primarySwatch: Colors.purple, // Mantendo as cores dos botões como estão
      ),
      home: MainScreen(),
    );
  }
}

class MainScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    double buttonWidth =
        250.0; // Definindo a largura dos botões para 250 pixels

    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Tela Principal',
          style: TextStyle(
            color: Colors.white, // Cor do texto da AppBar igual ao dos botões
          ),
        ),
        backgroundColor: Colors.deepPurple, // Cor da AppBar igual à dos botões
        centerTitle: true, // Centraliza o título na AppBar
      ),
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: <Widget>[
              SizedBox(
                width: buttonWidth,
                child: ElevatedButton(
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => AddProductScreen()),
                    );
                  },
                  child: Text('Adicionar Produto'),
                ),
              ),
              SizedBox(height: 16.0),
              SizedBox(
                width: buttonWidth,
                child: ElevatedButton(
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => SearchProductScreen()),
                    );
                  },
                  child: Text('Buscar Produto'),
                ),
              ),
              SizedBox(height: 16.0),
              SizedBox(
                width: buttonWidth,
                child: ElevatedButton(
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => ReporEstoqueScreen()),
                    );
                  },
                  child: Text('Repor Estoque'),
                ),
              ),
              SizedBox(height: 16.0),
              SizedBox(
                width: buttonWidth,
                child: ElevatedButton(
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => ListarProdutosScreen()),
                    );
                  },
                  child: Text('Listar Todos os Produtos'),
                ),
              ),
              SizedBox(height: 16.0),
              SizedBox(
                width: buttonWidth,
                child: ElevatedButton(
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => VenderProdutoScreen()),
                    );
                  },
                  child: Text('Vender Produto'),
                ),
              ),
              SizedBox(height: 16.0),
              SizedBox(
                width: buttonWidth,
                child: ElevatedButton(
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => AlterarPrecoSaidaScreen()),
                    );
                  },
                  child: Text('Alterar Preço de Saída'),
                ),
              ),
              SizedBox(height: 16.0),
              SizedBox(
                width: buttonWidth,
                child: ElevatedButton(
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => AlterarPrecoEntradaScreen()),
                    );
                  },
                  child: Text('Alterar Preço de Entrada'),
                ),
              ),
              SizedBox(height: 16.0),
              SizedBox(
                width: buttonWidth,
                child: ElevatedButton(
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => AlterarPrecoSaidaTodosScreen()),
                    );
                  },
                  child: Text('Alterar Preço de Saída (Todos)'),
                ),
              ),
              SizedBox(height: 16.0),
              SizedBox(
                width: buttonWidth,
                child: ElevatedButton(
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => VendasScreen()),
                    );
                  },
                  child: Text('Relatório de Vendas'),
                ),
              ),
              SizedBox(height: 16.0),
              SizedBox(
                width: buttonWidth,
                child: ElevatedButton(
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => RelatorioEstoqueScreen()),
                    );
                  },
                  child: Text('Relatório de Estoque'),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
