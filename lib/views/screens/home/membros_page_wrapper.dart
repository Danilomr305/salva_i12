import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:i12mobile/views/screens/gestao_de_pessoas/membros/paginas_membros_screen/membros_page.dart';
import 'package:shared_preferences/shared_preferences.dart';

class MembrosPageWrapper extends StatelessWidget {
  const MembrosPageWrapper({super.key});

  Future<String?> _getIgrejaId() async {
    final prefs = await SharedPreferences.getInstance();
    final String? igrejaIdJson = prefs.getString('igrejaId');
    if (igrejaIdJson != null && igrejaIdJson.isNotEmpty) {
      return jsonDecode(igrejaIdJson); // remove aspas extras
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
            body: Center(child: CircularProgressIndicator()),
          );
        } else {
          final String? id = snapshot.data;
          return MembrosPage(igrejaId: id);
        }
      },
    );
  }
}
