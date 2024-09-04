import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class VendasScreen extends StatefulWidget {
  @override
  _VendasScreenState createState() => _VendasScreenState();
}

class _VendasScreenState extends State<VendasScreen> {
  String _relatorioVendas = "Carregando...";

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
        });
      } else if (response.statusCode == 404) {
        setState(() {
          _relatorioVendas = "Nenhuma venda registrada.";
        });
      } else {
        setState(() {
          _relatorioVendas = "Erro ao buscar relatório de vendas.";
        });
      }
    } catch (e) {
      setState(() {
        _relatorioVendas = "Erro ao se conectar com o servidor.";
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
        child: SingleChildScrollView(
          child: Text(
            _relatorioVendas,
            style: TextStyle(fontSize: 16.0),
          ),
        ),
      ),
    );
  }
}
