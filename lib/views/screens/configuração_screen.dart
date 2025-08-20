// ignore_for_file: file_names

import 'package:flutter/material.dart';

class ConfiguracaoTelasButton extends StatefulWidget {
  const ConfiguracaoTelasButton({super.key});

  @override
  State<ConfiguracaoTelasButton> createState() => _ConfiguracaoTelasButtonState();
}

class _ConfiguracaoTelasButtonState extends State<ConfiguracaoTelasButton> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Configurações', style: TextStyle(fontWeight: FontWeight.bold),),
      ),
    );
  }
}