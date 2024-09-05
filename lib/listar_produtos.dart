import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class ListarProdutosScreen extends StatefulWidget {
  @override
  _ListarProdutosScreenState createState() => _ListarProdutosScreenState();
}

class _ListarProdutosScreenState extends State<ListarProdutosScreen> {
  List<dynamic> _produtos = [];
  String _mensagem = '';
  bool _isLoading = true;

  Future<void> listarProdutos() async {
    final url = 'http://localhost:8080/produtos/todos';

    try {
      final response = await http.get(Uri.parse(url));

      if (response.statusCode == 200) {
        setState(() {
          _produtos = response.body
              .split("\n")
              .where((item) => item.isNotEmpty)
              .toList();
          _mensagem = ''; // Limpa mensagem se produtos foram carregados
          _isLoading = false;
        });
      } else if (response.statusCode == 404) {
        setState(() {
          _mensagem = 'Nenhum produto encontrado.';
          _isLoading = false;
        });
      } else {
        setState(() {
          _mensagem = 'Erro ao buscar produtos.';
          _isLoading = false;
        });
      }
    } catch (e) {
      setState(() {
        _mensagem = 'Erro ao conectar com o servidor.';
        _isLoading = false;
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
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              _isLoading
                  ? CircularProgressIndicator() // Mostra um loading enquanto busca
                  : Expanded(
                      child: SingleChildScrollView(
                        child: Column(
                          children: <Widget>[
                            if (_produtos.isNotEmpty)
                              ..._produtos.map((produto) {
                                return Container(
                                  width: 220, // Largura fixa para os cards
                                  margin: EdgeInsets.symmetric(vertical: 8),
                                  child: Card(
                                    elevation: 5,
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
                            if (_mensagem.isNotEmpty)
                              Container(
                                width:
                                    250, // Largura fixa para o card de mensagem
                                margin: EdgeInsets.symmetric(vertical: 8),
                                child: Card(
                                  elevation: 5,
                                  child: Padding(
                                    padding: const EdgeInsets.all(16.0),
                                    child: Text(
                                      _mensagem,
                                      style: TextStyle(fontSize: 16),
                                      textAlign: TextAlign.center,
                                    ),
                                  ),
                                ),
                              ),
                          ],
                        ),
                      ),
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
