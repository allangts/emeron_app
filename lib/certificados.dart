import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class CertificadosPage extends StatefulWidget {
  @override
  _CertificadosPageState createState() => _CertificadosPageState();
}

class _CertificadosPageState extends State<CertificadosPage> {
  Map<String, dynamic>? certificado;
  bool isLoading = true;

  @override
  void initState() {
    super.initState();
    fetchCertificado();
  }

  Future<void> fetchCertificado() async {
    final url = Uri.parse('https://api-hmg.emeron.edu.br/formacao/440');
    try {
      final response = await http.get(url);

      if (response.statusCode == 200) {
        final data = jsonDecode(response.body);
        setState(() {
          certificado = data;
          isLoading = false;
        });
      } else {
        throw Exception('Falha ao carregar o certificado');
      }
    } catch (e) {
      setState(() {
        isLoading = false;
      });
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Erro: $e')),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Certificado'),
        backgroundColor: Colors.blue,
      ),
      body: isLoading
          ? const Center(child: CircularProgressIndicator())
          : certificado != null
              ? Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Nome: ${certificado!['nome']}',
                        style: TextStyle(
                          fontSize: 22,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      const SizedBox(height: 10),
                      Text(
                        'Início: ${formatarData(certificado!['dataInicio'])}',
                        style: const TextStyle(fontSize: 18),
                      ),
                      const SizedBox(height: 5),
                      Text(
                        'Fim: ${formatarData(certificado!['dataFim'])}',
                        style: const TextStyle(fontSize: 18),
                      ),
                      const SizedBox(height: 5),
                      Text(
                        'Situação: ${certificado!['situacao'] == "1" ? "Ativo" : "Inativo"}',
                        style: const TextStyle(fontSize: 18),
                      ),
                    ],
                  ),
                )
              : const Center(
                  child: Text(
                    'Nenhum certificado encontrado.',
                    style: TextStyle(fontSize: 18),
                  ),
                ),
    );
  }

  String formatarData(String data) {
    // Converte a data de 'yyyymmdd' para 'dd/mm/yyyy'
    if (data.length != 8) return data;
    return '${data.substring(6, 8)}/${data.substring(4, 6)}/${data.substring(0, 4)}';
  }
}
