import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class SearchProductScreen extends StatefulWidget {
  @override
  _SearchProductScreenState createState() => _SearchProductScreenState();
}

class _SearchProductScreenState extends State<SearchProductScreen> {
  final _codigoController = TextEditingController();
  String _resultado = '';

  Future<void> buscarProduto() async {
    final codigo = _codigoController.text.toUpperCase();

    if (codigo.isEmpty) {
      setState(() {
        _resultado = 'Digite o código do produto.';
      });
      return;
    }

    final url = 'http://localhost:8080/produtos/$codigo';
    final response = await http.get(Uri.parse(url));

    if (response.statusCode == 200) {
      final produto = jsonDecode(response.body);
      setState(() {
        _resultado =
            'Produto encontrado:\nCódigo: ${produto['codigo']}\nDescrição: ${produto['descricao']}\nMarca: ${produto['marca']}\nValor de Entrada: ${produto['valorEntrada']}\nValor de Saída: ${produto['valorSaida']}\nQuantidade Atual: ${produto['quantidadeAtual']}';
      });
    } else if (response.statusCode == 404) {
      setState(() {
        _resultado = 'Produto não encontrado.';
      });
    } else {
      setState(() {
        _resultado = 'Erro ao buscar produto.';
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Buscar Produto'),
      ),
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            children: <Widget>[
              Spacer(flex: 2), // Espaço acima
              SizedBox(
                width: 300,
                child: Column(
                  children: [
                    TextField(
                      controller: _codigoController,
                      decoration: InputDecoration(labelText: 'Código'),
                      textAlign: TextAlign.center,
                    ),
                    SizedBox(height: 16.0),
                    SizedBox(
                      width: 150,
                      child: ElevatedButton(
                        onPressed: buscarProduto,
                        child: Text('Buscar'),
                      ),
                    ),
                  ],
                ),
              ),
              SizedBox(height: 16.0),
              Expanded(
                flex: 2, // Permite que o card cresça de acordo com o texto
                child: _resultado.isNotEmpty
                    ? Align(
                        alignment: Alignment.center,
                        child: ConstrainedBox(
                          constraints: BoxConstraints(
                              maxWidth: 300), // Limita a largura do card
                          child: Card(
                            elevation: 5,
                            child: Padding(
                              padding: const EdgeInsets.all(16.0),
                              child: SingleChildScrollView(
                                child: Text(
                                  _resultado,
                                  style: TextStyle(fontSize: 16),
                                  textAlign: TextAlign
                                      .left, // Alinha o texto à esquerda
                                ),
                              ),
                            ),
                          ),
                        ),
                      )
                    : Container(),
              ),
              Spacer(flex: 2), // Espaço abaixo
            ],
          ),
        ),
      ),
    );
  }
}
