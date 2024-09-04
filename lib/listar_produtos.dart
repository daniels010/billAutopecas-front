import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class ListarProdutosScreen extends StatefulWidget {
  @override
  _ListarProdutosScreenState createState() => _ListarProdutosScreenState();
}

class _ListarProdutosScreenState extends State<ListarProdutosScreen> {
  List<dynamic> _produtos = [];
  String _mensagem = '';

  Future<void> listarProdutos() async {
    final url = 'http://localhost:8080/produtos/todos';

    final response = await http.get(Uri.parse(url));

    if (response.statusCode == 200) {
      setState(() {
        _produtos =
            response.body.split("\n").where((item) => item.isNotEmpty).toList();
        _mensagem = ''; // Limpa mensagem se produtos foram carregados
      });
    } else if (response.statusCode == 404) {
      setState(() {
        _mensagem = 'Nenhum produto encontrado.';
      });
    } else {
      setState(() {
        _mensagem = 'Erro ao buscar produtos.';
      });
    }
  }

  @override
  void initState() {
    super.initState();
    listarProdutos(); // Carregar os produtos automaticamente ao abrir a tela
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Listar Produtos'),
      ),
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            children: <Widget>[
              Expanded(
                child: _produtos.isNotEmpty
                    ? Align(
                        alignment: Alignment.topCenter,
                        child: SingleChildScrollView(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: _produtos.map((produto) {
                              return ConstrainedBox(
                                constraints: BoxConstraints(
                                  minWidth:
                                      300, // Largura mínima para uniformidade
                                  maxWidth: 300, // Largura máxima para os cards
                                ),
                                child: Card(
                                  elevation: 5,
                                  margin: EdgeInsets.symmetric(vertical: 8),
                                  child: Padding(
                                    padding: const EdgeInsets.all(16.0),
                                    child: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: _formatarProduto(produto),
                                    ),
                                  ),
                                ),
                              );
                            }).toList(),
                          ),
                        ),
                      )
                    : _mensagem.isNotEmpty
                        ? Text(_mensagem, style: TextStyle(fontSize: 16))
                        : CircularProgressIndicator(), // Mostra um loading enquanto busca
              ),
            ],
          ),
        ),
      ),
    );
  }

  List<Widget> _formatarProduto(String produto) {
    final campos = produto.split(', ');

    return campos.map((campo) {
      final keyValue = campo.split(': ');
      return Padding(
        padding: const EdgeInsets.symmetric(vertical: 2.0),
        child: Text(
          '${keyValue[0]}: ${keyValue[1]}',
          style: TextStyle(fontSize: 14, fontWeight: FontWeight.w400),
          textAlign:
              TextAlign.left, // Garante que o texto esteja alinhado à esquerda
        ),
      );
    }).toList();
  }
}
