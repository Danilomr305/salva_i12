import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:i12mobile/domain/models/model/discipular/ecd_aluno_model.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:http/http.dart' as http;

class AlunosEcdProvider extends ChangeNotifier {
  List<EcdAluno> ecdAlunos = [];
  EcdAluno? ecdAlunosSelected;
  int? indexEcdAluno;

  Future<String?> getTokenEcdAluno() async {
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    return sharedPreferences.getString('token');
  }

  Future<void> listEcdAluno(String? idEcd, bool comprouLivro,
      bool comprouCamisa, String dataInicioTurma, String dataInscricao) async {
    var token = await getTokenEcdAluno();
    print('Token utilizado: $token');

    final ecdAluno = await http.post(
      Uri.parse('https://api.logos.eti.br/discipular/ecd/alunos/find/$idEcd'),
      headers: <String, String>{
        'Content-Type': 'application/json',
        'Authorization': token ?? '', // Evita problemas com token nulo
      },
      body: jsonEncode(<String, Object>{
        'paginator': {'page': 1, 'pageSize': 20},
        // Adicione outros parâmetros de pesquisa, se necessário
      }),
    );

    if (ecdAluno.statusCode == 200) {
      var json = jsonDecode(ecdAluno.body) as Map<String, dynamic>;

      if (json.containsKey('content')) {
        var jsonList = json['content'] as List<dynamic>;

        // Limpa a lista antes de adicionar novos dados
        ecdAlunos.clear();
        for (var item in jsonList) {
          ecdAlunos.add(EcdAluno.fromJson(item));
          print('${ecdAlunos}');
        }
        notifyListeners(); // Notifica os ouvintes sobre a atualização
      } else {
        throw Exception('Campo "content" não encontrado no JSON.');
      }
    } else {
      throw Exception('Falha ao carregar os dados: ${ecdAluno.statusCode}');
    }
  }
}
