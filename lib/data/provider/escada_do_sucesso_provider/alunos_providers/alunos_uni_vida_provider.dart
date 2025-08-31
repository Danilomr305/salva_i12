import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:i12mobile/domain/models/model/consolidar/univida_aluno_model.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:http/http.dart' as http;

class AlunosUniVidaProvider extends ChangeNotifier {
  List<UniVidaAluno> uniVidaAlunos = [];
  UniVidaAluno? uniVidaAlunoSelected;
  int? indexUniVidaAluno;

  Future<String?> getTokenUniVidaAluno() async {
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    return sharedPreferences.getString('token');
  }

  Future<void> listUniVidaAluno(String? idUniVida, String pessoa,
      bool comprouLivro, bool comprouCamisa, String dataInscricao) async {
    var token = await getTokenUniVidaAluno();
    print('Token utilizado: $token');

    final uniAluno = await http.post(
      Uri.parse(
          'https://api.logos.eti.br/consolidacao/univida/alunos/find/$idUniVida'),
      headers: <String, String>{
        'Content-Type': 'application/json',
        'Authorization': token ?? '', // Evita problemas com token nulo
      },
      body: jsonEncode(<String, Object>{
        'paginator': {'page': 1, 'pageSize': 20},

        // Adicione outros parâmetros de pesquisa, se necessário
      }),
    );

    if (uniAluno.statusCode == 200) {
      var json = jsonDecode(uniAluno.body) as Map<String, dynamic>;

      if (json.containsKey('content')) {
        var jsonList = json['content'] as List<dynamic>;

        // Limpa a lista antes de adicionar novos dados
        uniVidaAlunos.clear();
        for (var item in jsonList) {
          uniVidaAlunos.add(UniVidaAluno.fromJson(item));
          print('${uniVidaAlunos}');
        }
        notifyListeners(); // Notifica os ouvintes sobre a atualização
      } else {
        throw Exception('Campo "content" não encontrado no JSON.');
      }
    } else {
      throw Exception('Falha ao carregar os dados: ${uniAluno.statusCode}');
    }
  }
}
