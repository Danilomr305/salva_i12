import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:i12mobile/data/repository/ganhar/nova_vida_repository.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:http/http.dart' as http;
import '../../../domain/models/model/ganhar/visita_models.dart';

/*class NovaLifeProvider extends ChangeNotifier{
  final NovaVidaRepository _novaVidaRepository = NovaVidaRepository();
  List<VisitaModelsDrawer> lifes = [];
  VisitaModelsDrawer? lifesSelected;
  int? indexLifes;

  Future<String?> getTokenUsuario() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getString('token');
  }

  Future<bool> listNovaLifes(
    String pessoa,
    String tipoEvento,
    String dataVisita,
    String pedidoOracao,
    String numeroTelefone,
    String convidadoPor,
    String descendencia,
    String igreja,
    String estaEmCelula,
    String nomeLiderCelula,
    String tipoConversao,
  ) async {
    try {
      final data = await _novaVidaRepository.listNovaLifes(
          pessoa,
          tipoEvento,
          dataVisita,
          pedidoOracao,
          numeroTelefone,
          convidadoPor,
          descendencia,
          igreja,
          estaEmCelula,
          nomeLiderCelula,
          tipoConversao);
    } catch (e) {
      print("Erro ao logar: $e");
    }
    return false;
  }
}*/

/*String totalVisitas,
      String tipoEvento,
      String dataVisita,
      String pedidoOracao,
      String numeroTelefone,
      String convidadoPor,
      String descendencia,
      String igreja,
      String estaEmCelula,
      String nomeLiderCelula,
      String tipoConversao*/

class NovaLifeProvider extends ChangeNotifier {
  List<VisitaModels> lifes = [];
  VisitaModels? lifesSelected;
  int? indexLifes;

  Future<String?> getTokenNovaLifes() async {
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    return sharedPreferences.getString('token');
  }

  Future<void> listNovaLifes(
      String tipoConversao,
      String pessoa,
      String descendencia,
      String dataNascimento,
      String telefone,
      String convidadoPor,
      String estaEmCelula,
      String nomeLiderCelula,
      String pedidoOracao) async {
    var token = await getTokenNovaLifes();
    print('Token utilizado: $token');

    final novaLifes = await http.get(
      Uri.parse('https://ganhar.logos.seg.br/visitas'),
      headers: <String, String>{
        'Content-Type': 'application/json',
        'Authorization': '${token ?? ''}',
      },
    );

    if (novaLifes.statusCode == 200) {
      var json = jsonDecode(novaLifes.body) as Map<String, dynamic>;

      if (json.containsKey('content')) {
        var jsonList = json['content'] as List<dynamic>;

        lifes.clear();
        for (var item in jsonList) {
          lifes.add(VisitaModels.fromJson(item));
          print('${lifes}');
        }
        notifyListeners();
      } else {
        throw Exception('Campo "content" não encontrado no JSON.');
      }
    } else {
      print('Erro status: ${novaLifes.statusCode}');
      print('Resposta da API: ${novaLifes.body}');
      throw Exception('Falha ao carregar os dados: ${novaLifes.statusCode}');
    }
  }
}
