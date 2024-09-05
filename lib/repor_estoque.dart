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
  bool _estoqueRepostoComSucesso = false; // Controla a cor do card

  Future<void> reporEstoque() async {
    final codigo = _codigoController.text.toUpperCase();
    final quantidade = int.tryParse(_quantidadeController.text) ?? 0;

    if (codigo.isEmpty || quantidade <= 0) {
      setState(() {
        _mensagem = 'Código ou quantidade inválidos.';
        _estoqueRepostoComSucesso = false; // Erro nos dados
      });
      return;
    }

    final url =
        'http://localhost:8080/produtos/repor-estoque?codigo=$codigo&quantidade=$quantidade';
    final response = await http.post(Uri.parse(url));

    setState(() {
      if (response.statusCode == 200) {
        _mensagem = 'Estoque reposto com sucesso.';
        _estoqueRepostoComSucesso = true; // Sucesso
      } else if (response.statusCode == 400) {
        _mensagem = 'Dados inválidos. Verifique o código e a quantidade.';
        _estoqueRepostoComSucesso = false; // Erro nos dados
      } else {
        _mensagem = 'Erro ao repor estoque.';
        _estoqueRepostoComSucesso = false; // Outro erro
      }
    });
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
                      keyboardType: TextInputType.number,
                      decoration: InputDecoration(
                        labelText: 'Quantidade',
                        border: OutlineInputBorder(),
                      ),
                    ),
                    SizedBox(height: 16.0),
                    SizedBox(
                      width: 150,
                      child: ElevatedButton(
                        onPressed: reporEstoque,
                        child: Text('Repor Estoque'),
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
                            color: _estoqueRepostoComSucesso
                                ? Colors.white // Sucesso - cor padrão
                                : Color(0xFFE1BEE7), // Falha - cor roxa clara
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
