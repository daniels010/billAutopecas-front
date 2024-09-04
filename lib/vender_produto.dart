import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class VenderProdutoScreen extends StatefulWidget {
  @override
  _VenderProdutoScreenState createState() => _VenderProdutoScreenState();
}

class _VenderProdutoScreenState extends State<VenderProdutoScreen> {
  final TextEditingController _codigoController = TextEditingController();
  final TextEditingController _quantidadeController = TextEditingController();
  String _mensagem = '';

  Future<void> venderProduto() async {
    final url = Uri.parse('http://localhost:8080/produtos/vender-produto');
    final response = await http.post(
      url,
      body: {
        'codigo': _codigoController.text,
        'quantidade': _quantidadeController.text,
      },
    );

    setState(() {
      if (response.statusCode == 200) {
        _mensagem = 'Produto vendido com sucesso.';
      } else {
        _mensagem =
            'Erro ao vender produto. Verifique o código ou a quantidade.';
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Vender Produto'),
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
                      controller: _quantidadeController,
                      decoration: InputDecoration(
                        labelText: 'Quantidade',
                        border: OutlineInputBorder(),
                      ),
                      keyboardType: TextInputType.number,
                    ),
                    SizedBox(height: 16.0),
                    SizedBox(
                      width: 150,
                      child: ElevatedButton(
                        onPressed: venderProduto,
                        child: Text('Vender Produto'),
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
                            color: Color(
                                0xFFE1BEE7), // Cor roxa clara similar ao botão
                            child: Padding(
                              padding: const EdgeInsets.all(16.0),
                              child: SingleChildScrollView(
                                child: Text(
                                  _mensagem,
                                  style: TextStyle(
                                    fontSize: 16,
                                    color: Colors.black,
                                  ),
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
