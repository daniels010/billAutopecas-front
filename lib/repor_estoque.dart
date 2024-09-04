import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class ReporEstoqueScreen extends StatefulWidget {
  @override
  _ReporEstoqueScreenState createState() => _ReporEstoqueScreenState();
}

class _ReporEstoqueScreenState extends State<ReporEstoqueScreen> {
  final _codigoController = TextEditingController();
  final _quantidadeController = TextEditingController();
  String _mensagem = '';

  Future<void> reporEstoque() async {
    final codigo = _codigoController.text.toUpperCase();
    final quantidade = int.tryParse(_quantidadeController.text) ?? 0;

    if (codigo.isEmpty || quantidade <= 0) {
      setState(() {
        _mensagem = 'Código ou quantidade inválidos.';
      });
      return;
    }

    final url =
        'http://localhost:8080/produtos/repor-estoque?codigo=$codigo&quantidade=$quantidade';
    final response = await http.post(Uri.parse(url));

    if (response.statusCode == 200) {
      setState(() {
        _mensagem = 'Estoque reposto com sucesso.';
      });
    } else if (response.statusCode == 400) {
      setState(() {
        _mensagem = 'Dados inválidos. Verifique o código e a quantidade.';
      });
    } else {
      setState(() {
        _mensagem = 'Erro ao repor estoque.';
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Repor Estoque'),
      ),
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: <Widget>[
              TextField(
                controller: _codigoController,
                decoration: InputDecoration(labelText: 'Código'),
              ),
              TextField(
                controller: _quantidadeController,
                keyboardType: TextInputType.number,
                decoration: InputDecoration(labelText: 'Quantidade'),
              ),
              SizedBox(height: 16.0),
              ElevatedButton(
                onPressed: reporEstoque,
                child: Text('Repor Estoque'),
              ),
              SizedBox(height: 16.0),
              _mensagem.isNotEmpty
                  ? Card(
                      elevation: 5,
                      child: Padding(
                        padding: const EdgeInsets.all(16.0),
                        child: Text(
                          _mensagem,
                          style: TextStyle(fontSize: 16),
                          textAlign:
                              TextAlign.left, // Justifica o texto à esquerda
                        ),
                      ),
                    )
                  : Container(),
            ],
          ),
        ),
      ),
    );
  }
}
