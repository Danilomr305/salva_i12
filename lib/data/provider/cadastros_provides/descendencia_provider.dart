import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:http/http.dart' as http;
import '../../../domain/models/model/descendencia.dart';

class DescendenciaProvider extends ChangeNotifier {
  List<DescendenciaModels> _descendencias = [];
  DescendenciaModels? descendenciaSelected;
  int? indexDescendencia;

  List<DescendenciaModels> get descendencias => _descendencias;

  Future<String?> getTokendescendencia() async {
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    return sharedPreferences.getString('token');
  }

  Future<void> listDescendecia(String descricao, String sigla) async {
    var token = await getTokendescendencia();
    if (token == null) {
      throw Exception('Token não encontrado.');
    }

    print('Token utilizado: $token');

    final response = await http.post(
      Uri.parse('https://g12.logos.seg.br/descendencias/'),
      headers: <String, String>{
        'Content-Type': 'application/json',
        'Authorization': token,
      },
      body: jsonEncode(<String, Object>{
        'paginator': {'page': 1, 'pageSize': 30},
        // Adicione outros parâmetros de pesquisa, se necessário
      }),
    );

    if (response.statusCode == 200) {
      var json = jsonDecode(response.body) as Map<String, dynamic>;

      if (json.containsKey('content')) {
        var jsonList = json['content'] as List<dynamic>;

        // Limpa a lista antes de adicionar novos dados
        _descendencias.clear();
        _descendencias =
            jsonList.map((item) => DescendenciaModels.fromJson(item)).toList();

        print('${_descendencias}');
        notifyListeners(); // Notifica os ouvintes sobre a mudança
      } else {
        throw Exception('Campo "content" não encontrado no JSON.');
      }
    } else {
      throw Exception('Falha ao carregar os dados: ${response.statusCode}');
    }
  }
}


//https://enviar.logos.seg.br/celulas/