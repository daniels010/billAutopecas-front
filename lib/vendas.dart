import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class VendasScreen extends StatefulWidget {
  @override
  _VendasScreenState createState() => _VendasScreenState();
}

class _VendasScreenState extends State<VendasScreen> {
  String _relatorioVendas = '';
  bool _isLoading = true;
  String _mensagem = '';

  @override
  void initState() {
    super.initState();
    _fetchRelatorioVendas();
  }

  Future<void> _fetchRelatorioVendas() async {
    try {
      final response = await http.get(Uri.parse(
          'http://localhost:8080/produtos/vendas')); // Substitua pela URL do seu backend

      if (response.statusCode == 200) {
        setState(() {
          _relatorioVendas = response.body;
          _isLoading = false;
        });
      } else if (response.statusCode == 404) {
        setState(() {
          _mensagem = "Nenhuma venda registrada.";
          _isLoading = false;
        });
      } else {
        setState(() {
          _mensagem = "Erro ao buscar relatório de vendas.";
          _isLoading = false;
        });
      }
    } catch (e) {
      setState(() {
        _mensagem = "Erro ao se conectar com o servidor.";
        _isLoading = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Relatório de Vendas'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              _isLoading
                  ? CircularProgressIndicator() // Mostra o carregando enquanto busca
                  : _relatorioVendas.isNotEmpty || _mensagem.isNotEmpty
                      ? Container(
                          width: 700, // Largura fixa para os cards
                          margin: EdgeInsets.symmetric(vertical: 8),
                          child: Card(
                            elevation: 5,
                            child: Padding(
                              padding: const EdgeInsets.all(16.0),
                              child: Align(
                                alignment: Alignment
                                    .topLeft, // Alinha o texto à esquerda
                                child: Text(
                                  _relatorioVendas.isNotEmpty
                                      ? _relatorioVendas
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
