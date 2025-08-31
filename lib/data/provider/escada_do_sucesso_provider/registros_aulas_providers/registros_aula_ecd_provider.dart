import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:i12mobile/domain/models/model/discipular/ecd_aula_model.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:http/http.dart' as http;

class RegistroAulaEcdProvider extends ChangeNotifier {
  List<EcdAula> ecdAulas = [];
  EcdAula? registrosEcdSelected;
  int? indexRegistrosEcd;

  Future<String?> getTokenRegistrosAulasEcd() async {
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    return sharedPreferences.getString('token');
  }

  Future<void> listRegistroEcd(String? idEcd, String aulaTipo, String dataAula,
      String licao, String professor, String alunos) async {
    var token = await getTokenRegistrosAulasEcd();
    print('Token utilizado: $token');

    final registrosAulaEcd = await http.post(
      Uri.parse('https://api.logos.eti.br/discipular/ecd/aulas/find/$idEcd'),
      headers: <String, String>{
        'Content-Type': 'application/json',
        'Authorization': token ?? '', // Evita problemas com token nulo
      },
      body: jsonEncode(<String, Object>{
        'paginator': {'page': 1, 'pageSize': 20},

        // Adicione outros parâmetros de pesquisa, se necessário
      }),
    );

    if (registrosAulaEcd.statusCode == 200) {
      var json = jsonDecode(registrosAulaEcd.body) as Map<String, dynamic>;

      if (json.containsKey('content')) {
        var jsonList = json['content'] as List<dynamic>;

        // Limpa a lista antes de adicionar novos dados
        ecdAulas.clear();
        for (var item in jsonList) {
          ecdAulas.add(EcdAula.fromJson(item));
          print('${ecdAulas}');
        }
        notifyListeners(); // Notifica os ouvintes sobre a atualização
      } else {
        throw Exception('Campo "content" não encontrado no JSON.');
      }
    } else {
      throw Exception(
          'Falha ao carregar os dados: ${registrosAulaEcd.statusCode}');
    }
  }
}
