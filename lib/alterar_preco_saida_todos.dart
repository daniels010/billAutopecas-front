import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class AlterarPrecoSaidaTodosScreen extends StatefulWidget {
  @override
  _AlterarPrecoSaidaTodosScreenState createState() =>
      _AlterarPrecoSaidaTodosScreenState();
}

class _AlterarPrecoSaidaTodosScreenState
    extends State<AlterarPrecoSaidaTodosScreen> {
  final TextEditingController _novoPrecoController = TextEditingController();
  String _mensagem = '';

  Future<void> alterarPrecoSaidaTodos() async {
    final url =
        Uri.parse('http://localhost:8080/produtos/alterar-preco-saida-todos');
    final response = await http.post(
      url,
      body: {
        'novoPreco': _novoPrecoController.text,
      },
    );

    setState(() {
      if (response.statusCode == 200) {
        _mensagem = 'Preço de saída de todos os produtos alterado com sucesso.';
      } else {
        _mensagem =
            'Falha ao alterar o preço de saída de todos os produtos. Verifique o valor.';
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Alterar Preço de Saída de Todos'),
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
                      controller: _novoPrecoController,
                      decoration: InputDecoration(
                        labelText: 'Novo Preço de Saída (%)',
                        border: OutlineInputBorder(),
                      ),
                      keyboardType: TextInputType.numberWithOptions(
                          decimal: true), // Aceita números decimais
                    ),
                    SizedBox(height: 16.0),
                    SizedBox(
                      width: 150,
                      child: ElevatedButton(
                        onPressed: alterarPrecoSaidaTodos,
                        child: Text('Alterar Preço'),
                      ),
                    ),
                  ],
                ),
              ),
              SizedBox(height: 16.0),
              Expanded(
                flex: 2,
                child: _mensagem.isNotEmpty
                    ? Align(
                        alignment: Alignment.center,
                        child: ConstrainedBox(
                          constraints: BoxConstraints(maxWidth: 300),
                          child: Card(
                            elevation: 5,
                            color: Color(0xFFE1BEE7), // Cor roxa clara
                            child: Padding(
                              padding: const EdgeInsets.all(16.0),
                              child: SingleChildScrollView(
                                child: Text(
                                  _mensagem,
                                  style: TextStyle(
                                    fontSize: 16,
                                    color: Colors.black,
                                  ),
                                  textAlign: TextAlign.left,
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
