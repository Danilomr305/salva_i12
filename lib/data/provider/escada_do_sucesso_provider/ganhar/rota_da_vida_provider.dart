// ignore_for_file: avoid_print

import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:i12mobile/domain/models/model/ganhar/rota_da_vida_models.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:http/http.dart' as http;

class RotaDaVidaProvider extends ChangeNotifier {
  List<RotaDaVidaModels> rotas = [];
  RotaDaVidaModels? rotasSelected;
  int? indexRotas;

  // Cache do token para evitar múltiplas leituras do SharedPreferences
  String? _cachedToken;

  // Função para obter o token, com cache
  Future<String?> getTokenRotaDaVida() async {
    if (_cachedToken != null)
      return _cachedToken; // Se já tem o token em cache, retorna
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    _cachedToken =
        sharedPreferences.getString('token'); // Armazena o token no cache
    return _cachedToken;
  }

  // Método para buscar a lista de rotas da vida
  Future<void> listRotaDaVida(
      String pessoa, String estaEmCelula, String dataInscricaoUniVida) async {
    var token = await getTokenRotaDaVida();
    print('Token utilizado: $token');

    try {
      final rotaVida = await http.post(
        Uri.parse('https://api.logos.eti.br/ganhar/rota_da_vida/find'),
        headers: <String, String>{
          'Content-Type': 'application/json',
          'Authorization': token ?? '', // Se o token for nulo, usa string vazia
        },
        body: jsonEncode(<String, Object>{
          'paginator': {'page': 1, 'pageSize': 1000},
          // Adicione outros parâmetros de pesquisa, se necessário
        }),
      );

      if (rotaVida.statusCode == 200) {
        // Decodifica o JSON para um mapa
        var json = jsonDecode(rotaVida.body) as Map<String, dynamic>;

        if (json.containsKey('content')) {
          // Limpa a lista antes de adicionar novos dados
          rotas.clear();

          // Obtém a lista de objetos do campo 'content'
          var jsonList = json['content'] as List<dynamic>;

          for (var item in jsonList) {
            rotas.add(
                RotaDaVidaModels.fromJson(item)); // Converte cada item do JSON
          }

          notifyListeners(); // Notifica ouvintes sobre a atualização
        } else {
          throw Exception('Campo "content" não encontrado no JSON.');
        }
      } else {
        throw Exception('Falha ao carregar os dados: ${rotaVida.statusCode}');
      }
    } catch (e) {
      print('Erro ao buscar os dados: $e');
      throw Exception('Erro na requisição: $e');
    }
  }

  // Definir a rota selecionada
  void setRotaSelecionada(RotaDaVidaModels rota, int index) {
    rotasSelected = rota;
    indexRotas = index;
    notifyListeners(); // Notifica ouvintes sobre a atualização
  }
}
