import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'dart:convert';
import '../escada_do_sucesso/ganhar/paginas_ganhar_screen/visita_page.dart';

class NovaLifePageWrapper extends StatelessWidget {
  const NovaLifePageWrapper({super.key});

  // Insira a função _getIgrejaId() aqui dentro da classe.
  Future<String?> _getIgrejaId() async {
    final prefs = await SharedPreferences.getInstance();
    final String? igrejaIdJson = prefs.getString('igrejaId');
    if (igrejaIdJson != null && igrejaIdJson.isNotEmpty) {
      return jsonDecode(igrejaIdJson);
    }
    return null;
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<String?>(
      future: _getIgrejaId(),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const Scaffold(
            body: Center(
              child: CircularProgressIndicator(),
            ),
          );
        } else {
          final String? id = snapshot.data;
          return NovaLifePage(igrejaId: id);
        }
      },
    );
  }
}
