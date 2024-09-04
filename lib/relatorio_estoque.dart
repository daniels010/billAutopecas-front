import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class RelatorioEstoqueScreen extends StatefulWidget {
  @override
  _RelatorioEstoqueScreenState createState() => _RelatorioEstoqueScreenState();
}

class _RelatorioEstoqueScreenState extends State<RelatorioEstoqueScreen> {
  String _relatorio = "Carregando...";

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
        });
      } else if (response.statusCode == 404) {
        setState(() {
          _relatorio = 'Nenhum produto em estoque';
        });
      } else {
        setState(() {
          _relatorio = 'Erro ao buscar o relatório de estoque';
        });
      }
    } catch (e) {
      setState(() {
        _relatorio = 'Erro ao conectar com o servidor';
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
        child: SingleChildScrollView(
          child: Text(
            _relatorio,
            style: TextStyle(fontSize: 16.0),
          ),
        ),
      ),
    );
  }
}
