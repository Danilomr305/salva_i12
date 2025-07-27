import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:http/http.dart' as http;

import '../../../domain/models/model/discipular/ecd_model.dart';

class EcdProvider extends ChangeNotifier {
  List<EcdModel> ecdModels = [];
  EcdModel? ecdModelSelected;
  int? indexecdModel;

  Future<String?> getTokenEcd() async {
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    return sharedPreferences.getString('token');
  }

  Future<void> listEcd(String modulo, String dataInicio, String dataConclusao,
      num totalAlunos) async {
    var token = await getTokenEcd();
    print('Token utilizado: $token');

    final ecd = await http.post(
      Uri.parse('https://api.logos.eti.br/discipular/ecd/turmas/find'),
      headers: <String, String>{
        'Content-Type': 'application/json',
        'Authorization': token ?? '', // Evita problemas com token nulo
      },
      body: jsonEncode(<String, Object>{
        'paginator': {'page': 1, 'pageSize': 20},
        // Adicione outros parâmetros de pesquisa, se necessário
      }),
    );

    if (ecd.statusCode == 200) {
      var json = jsonDecode(ecd.body) as Map<String, dynamic>;

      if (json.containsKey('content')) {
        var jsonList = json['content'] as List<dynamic>;

        // Limpa a lista antes de adicionar novos dados
        ecdModels.clear();
        for (var item in jsonList) {
          ecdModels.add(EcdModel.fromJson(item));
          print('${ecdModels}');
        }
        notifyListeners(); // Notifica os ouvintes sobre a atualização
      } else {
        throw Exception('Campo "content" não encontrado no JSON.');
      }
    } else {
      throw Exception('Falha ao carregar os dados: ${ecd.statusCode}');
    }
  }
}
