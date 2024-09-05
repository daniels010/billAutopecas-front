import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class AddProductScreen extends StatefulWidget {
  @override
  _AddProductScreenState createState() => _AddProductScreenState();
}

class _AddProductScreenState extends State<AddProductScreen> {
  final _codigoController = TextEditingController();
  final _descricaoController = TextEditingController();
  final _marcaController = TextEditingController();
  final _valorEntradaController = TextEditingController();
  final _valorSaidaController = TextEditingController();
  final _quantidadeAtualController = TextEditingController();
  String _mensagem = '';
  bool _produtoAdicionadoComSucesso = false; // Controla a cor do card

  Future<void> adicionarProduto() async {
    final url = 'http://localhost:8080/produtos/adicionar';

    final response = await http.post(
      Uri.parse(url),
      headers: {'Content-Type': 'application/json'},
      body: jsonEncode({
        'codigo': _codigoController.text.toUpperCase(),
        'descricao': _descricaoController.text.toUpperCase(),
        'marca': _marcaController.text.toUpperCase(),
        'valorEntrada': double.tryParse(_valorEntradaController.text) ?? 0,
        'valorSaida': double.tryParse(_valorSaidaController.text) ?? 0,
        'quantidadeAtual': int.tryParse(_quantidadeAtualController.text) ?? 0,
      }),
    );

    setState(() {
      if (response.statusCode == 201) {
        _mensagem = 'Produto adicionado com sucesso';
        _produtoAdicionadoComSucesso = true; // Produto adicionado com sucesso
      } else if (response.statusCode == 400) {
        _mensagem = 'Dados inválidos: ${response.body}';
        _produtoAdicionadoComSucesso = false; // Erro nos dados
      } else if (response.statusCode == 409) {
        _mensagem = 'Produto já existe';
        _produtoAdicionadoComSucesso = false; // Produto duplicado
      } else {
        _mensagem = 'Erro ao adicionar produto';
        _produtoAdicionadoComSucesso = false; // Outro erro
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Adicionar Produto'),
      ),
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            children: <Widget>[
              Spacer(flex: 2), // Espaço acima
              Align(
                alignment: Alignment.center,
                child: SizedBox(
                  width: 300, // Largura dos campos de texto
                  child: Column(
                    children: [
                      TextField(
                        controller: _codigoController,
                        decoration: InputDecoration(
                          labelText: 'Código',
                          border:
                              OutlineInputBorder(), // Borda nas caixas de texto
                        ),
                        textAlign: TextAlign.center,
                      ),
                      SizedBox(height: 16.0),
                      TextField(
                        controller: _descricaoController,
                        decoration: InputDecoration(
                          labelText: 'Descrição',
                          border: OutlineInputBorder(),
                        ),
                        textAlign: TextAlign.center,
                      ),
                      SizedBox(height: 16.0),
                      TextField(
                        controller: _marcaController,
                        decoration: InputDecoration(
                          labelText: 'Marca',
                          border: OutlineInputBorder(),
                        ),
                        textAlign: TextAlign.center,
                      ),
                      SizedBox(height: 16.0),
                      TextField(
                        controller: _valorEntradaController,
                        keyboardType: TextInputType.number,
                        decoration: InputDecoration(
                          labelText: 'Valor de Entrada',
                          border: OutlineInputBorder(),
                        ),
                        textAlign: TextAlign.center,
                      ),
                      SizedBox(height: 16.0),
                      TextField(
                        controller: _valorSaidaController,
                        keyboardType: TextInputType.number,
                        decoration: InputDecoration(
                          labelText: 'Valor de Saída',
                          border: OutlineInputBorder(),
                        ),
                        textAlign: TextAlign.center,
                      ),
                      SizedBox(height: 16.0),
                      TextField(
                        controller: _quantidadeAtualController,
                        keyboardType: TextInputType.number,
                        decoration: InputDecoration(
                          labelText: 'Quantidade Atual',
                          border: OutlineInputBorder(),
                        ),
                        textAlign: TextAlign.center,
                      ),
                    ],
                  ),
                ),
              ),
              SizedBox(height: 16.0),
              Align(
                alignment: Alignment.center,
                child: SizedBox(
                  width: 150, // Largura do botão
                  child: ElevatedButton(
                    onPressed: adicionarProduto,
                    child: Text('Adicionar'),
                  ),
                ),
              ),
              SizedBox(height: 16.0),
              SizedBox(
                height: 100, // Altura reservada para o card
                child: _mensagem.isNotEmpty
                    ? Align(
                        alignment: Alignment.center,
                        child: ConstrainedBox(
                          constraints: BoxConstraints(
                              maxWidth: 300), // Limita a largura do card
                          child: Card(
                            elevation: 5,
                            color: _produtoAdicionadoComSucesso
                                ? Colors.white // Cor padrão para sucesso
                                : Color(
                                    0xFFE1BEE7), // Cor roxa clara para erros
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
