import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class AlterarPrecoSaidaScreen extends StatefulWidget {
  @override
  _AlterarPrecoSaidaScreenState createState() =>
      _AlterarPrecoSaidaScreenState();
}

class _AlterarPrecoSaidaScreenState extends State<AlterarPrecoSaidaScreen> {
  final TextEditingController _codigoController = TextEditingController();
  final TextEditingController _novoPrecoController = TextEditingController();
  String _mensagem = '';

  Future<void> alterarPrecoSaida() async {
    final url = Uri.parse('http://localhost:8080/produtos/alterar-preco-saida');
    final response = await http.post(
      url,
      body: {
        'codigo': _codigoController.text,
        'novoPreco': _novoPrecoController.text,
      },
    );

    setState(() {
      if (response.statusCode == 200) {
        _mensagem = 'Preço de saída alterado com sucesso.';
      } else {
        _mensagem =
            'Falha ao alterar o preço de saída. Verifique o código e o valor.';
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Alterar Preço de Saída'),
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
                      decoration: InputDecoration(
                        labelText: 'Código do Produto',
                        border: OutlineInputBorder(),
                      ),
                    ),
                    SizedBox(height: 16.0),
                    TextField(
                      controller: _novoPrecoController,
                      decoration: InputDecoration(
                        labelText: 'Novo Preço de Saída',
                        border: OutlineInputBorder(),
                      ),
                      keyboardType: TextInputType.numberWithOptions(
                          decimal: true), // Aceita números decimais
                    ),
                    SizedBox(height: 16.0),
                    SizedBox(
                      width: 150,
                      child: ElevatedButton(
                        onPressed: alterarPrecoSaida,
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
