import 'package:flutter/material.dart';
import 'home.dart';

void main() {
  runApp(CertificadoApp());
}

class CertificadoApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Certificado App',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: HomePage(),
    );
  }
}
