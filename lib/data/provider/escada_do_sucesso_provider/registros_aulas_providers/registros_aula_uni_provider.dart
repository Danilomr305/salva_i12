import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:i12mobile/domain/models/model/consolidar/univida_aula_models.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:http/http.dart' as http;

class RegistrosAulasUniProvider extends ChangeNotifier {
  List<UniVidaAula> uniAulasUnis = [];
  UniVidaAula? registrosUniSelected;
  int? indexRegistrosAula;

  Future<String?> getTokenRegistrosAulasUni() async {
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    return sharedPreferences.getString('token');
  }

  Future<void> listRegistroUni(String? idUniVida, String licao,
      String professor, String aulaTipo, String uniVda, String dataAula) async {
    var token = await getTokenRegistrosAulasUni();
    print('Token utilizado: $token');

    final registrosAulaUni = await http.post(
      Uri.parse(
          'https://api.logos.eti.br/consolidacao/univida/aulas/find/$idUniVida'),
      headers: <String, String>{
        'Content-Type': 'application/json',
        'Authorization': token ?? '', // Evita problemas com token nulo
      },
      body: jsonEncode(<String, Object>{
        'paginator': {'page': 1, 'pageSize': 20},

        // Adicione outros parâmetros de pesquisa, se necessário
      }),
    );

    if (registrosAulaUni.statusCode == 200) {
      var json = jsonDecode(registrosAulaUni.body) as Map<String, dynamic>;

      if (json.containsKey('content')) {
        var jsonList = json['content'] as List<dynamic>;

        // Limpa a lista antes de adicionar novos dados
        uniAulasUnis.clear();
        for (var item in jsonList) {
          uniAulasUnis.add(UniVidaAula.fromJson(item));
          print('${uniAulasUnis}');
        }
        notifyListeners(); // Notifica os ouvintes sobre a atualização
      } else {
        throw Exception('Campo "content" não encontrado no JSON.');
      }
    } else {
      throw Exception(
          'Falha ao carregar os dados: ${registrosAulaUni.statusCode}');
    }
  }
}
