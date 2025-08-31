import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:i12mobile/domain/models/model/consolidar/univida_model.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:http/http.dart' as http;

class UniVidaProvider extends ChangeNotifier {
  List<UniVida> uniVidas = [];
  UniVida? uniVidaSelected;
  int? indexUniVida;

  Future<String?> getTokenUniVida() async {
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    return sharedPreferences.getString('token');
  }

  Future<void> listUniVida(dynamic licaoAtual, String totalAlunos,
      String dataInicioTurma, String dataEncerramentoTurma) async {
    var token = await getTokenUniVida();
    print('Token utilizado: $token');

    final uniVid = await http.post(
      Uri.parse('https://api.logos.eti.br/consolidacao/univida/turmas/find'),
      headers: <String, String>{
        'Content-Type': 'application/json',
        'Authorization': token ?? '', // Evita problemas com token nulo
      },
      body: jsonEncode(<String, Object>{
        'paginator': {'page': 1, 'pageSize': 20},
        // Adicione outros parâmetros de pesquisa, se necessário
      }),
    );

    if (uniVid.statusCode == 200) {
      var json = jsonDecode(uniVid.body) as Map<String, dynamic>;

      if (json.containsKey('content')) {
        var jsonList = json['content'] as List<dynamic>;

        // Limpa a lista antes de adicionar novos dados
        uniVidas.clear();
        for (var item in jsonList) {
          uniVidas.add(UniVida.fromJson(item));
          print('${uniVidas}');
        }
        notifyListeners(); // Notifica os ouvintes sobre a atualização
      } else {
        throw Exception('Campo "content" não encontrado no JSON.');
      }
    } else {
      throw Exception('Falha ao carregar os dados: ${uniVid.statusCode}');
    }
  }
}
