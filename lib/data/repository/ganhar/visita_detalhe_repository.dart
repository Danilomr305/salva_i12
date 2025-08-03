import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:i12mobile/domain/models/model/ganhar/visita_detalhe_models.dart';
import 'package:shared_preferences/shared_preferences.dart';

class VisitaDetalheRepository {
  Future<String?> _getTokenVisitas() async {
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    return sharedPreferences.getString('token');
  }

  Future<List<VisitaDetalheModels>> listVisitas(
      {required String tipoConversao,
      required String pessoa,
      required String descendencia,
      required String dataNascimento,
      required String telefone,
      required String convidadoPor,
      required String estaEmCelula,
      required String nomeLiderCelula,
      required String pedidoOracao}) async {
    var token = await _getTokenVisitas();
    print('Token utilizado: $token');

    final visitantes = await http.get(
      Uri.parse('https://ganhar.logos.seg.br/visitas?pages=1&size=48'),
      headers: <String, String>{
        'Content-Type': 'application/json',
        'Authorization': token ?? '', // Evita problemas com token nulo
      },
    );

    if (visitantes.statusCode == 200) {
      final json = jsonDecode(visitantes.body);

      if (json['content'] is List) {
        return (json['content'] as List)
            .map((e) => VisitaDetalheModels.fromJson(e))
            .toList();
      } else {
        throw Exception('Campo "content" não encontrado no JSON.');
      }
    } else {
      print('Erro status: ${visitantes.statusCode}');
      print('Resposta da API: ${visitantes.body}');
      throw Exception('Falha ao carregar os dados: ${visitantes.statusCode}');
    }
  }
}
