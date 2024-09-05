import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class RelatorioEstoqueScreen extends StatefulWidget {
  @override
  _RelatorioEstoqueScreenState createState() => _RelatorioEstoqueScreenState();
}

class _RelatorioEstoqueScreenState extends State<RelatorioEstoqueScreen> {
  String _relatorio = '';
  bool _isLoading = true;
  String _mensagem = '';

  @override
  void initState() {
    super.initState();
    _fetchRelatorioEstoque();
  }

  Future<void> _fetchRelatorioEstoque() async {
    final url = Uri.parse(
        'http://localhost:8080/produtos/estoque'); // Ajuste para sua URL
    try {
      final response = await http.get(url);
      if (response.statusCode == 200) {
        setState(() {
          _relatorio = response.body;
          _isLoading = false;
        });
      } else if (response.statusCode == 404) {
        setState(() {
          _mensagem = 'Nenhum produto em estoque';
          _isLoading = false;
        });
      } else {
        setState(() {
          _mensagem = 'Erro ao buscar o relatório de estoque';
          _isLoading = false;
        });
      }
    } catch (e) {
      setState(() {
        _mensagem = 'Erro ao conectar com o servidor';
        _isLoading = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Relatório de Estoque'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              _isLoading
                  ? CircularProgressIndicator() // Mostra o carregando enquanto busca
                  : _relatorio.isNotEmpty || _mensagem.isNotEmpty
                      ? Container(
                          width: 600, // Largura fixa para os cards
                          margin: EdgeInsets.symmetric(vertical: 8),
                          child: Card(
                            elevation: 5,
                            child: Padding(
                              padding: const EdgeInsets.all(16.0),
                              child: Align(
                                alignment: Alignment
                                    .topLeft, // Alinha o texto à esquerda
                                child: Text(
                                  _relatorio.isNotEmpty
                                      ? _relatorio
                                      : _mensagem,
                                  style: TextStyle(fontSize: 16.0),
                                  textAlign: TextAlign
                                      .left, // Alinha o texto à esquerda
                                ),
                              ),
                            ),
                          ),
                        )
                      : Container(), // Em caso de ausência de dados
            ],
          ),
        ),
      ),
    );
  }
}
