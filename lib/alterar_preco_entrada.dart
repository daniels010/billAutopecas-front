import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class AlterarPrecoEntradaScreen extends StatefulWidget {
  @override
  _AlterarPrecoEntradaScreenState createState() =>
      _AlterarPrecoEntradaScreenState();
}

class _AlterarPrecoEntradaScreenState extends State<AlterarPrecoEntradaScreen> {
  final TextEditingController _codigoController = TextEditingController();
  final TextEditingController _novoPrecoController = TextEditingController();
  String _mensagem = '';

  Future<void> alterarPrecoEntrada() async {
    final url =
        Uri.parse('http://localhost:8080/produtos/alterar-preco-entrada');
    final response = await http.post(
      url,
      body: {
        'codigo': _codigoController.text,
        'novoPreco': _novoPrecoController.text,
      },
    );

    setState(() {
      if (response.statusCode == 200) {
        _mensagem = 'Preço de entrada alterado com sucesso.';
      } else {
        _mensagem =
            'Falha ao alterar o preço de entrada. Verifique o código e o valor.';
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Alterar Preço de Entrada'),
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
                        labelText: 'Novo Preço de Entrada',
                        border: OutlineInputBorder(),
                      ),
                      keyboardType: TextInputType.numberWithOptions(
                          decimal: true), // Aceita números decimais
                    ),
                    SizedBox(height: 16.0),
                    SizedBox(
                      width: 150,
                      child: ElevatedButton(
                        onPressed: alterarPrecoEntrada,
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
