import 'dart:convert';

import 'package:http/http.dart' as http;

class NovaVidaRepository {
  Future<Map<String, dynamic>?> listNovaLifes(
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
      String tipoConversao) async {
    final url = Uri.parse('https://ganhar.logos.seg.br/visitas');

    try {
      final response = await http.post(
        url,
        headers: {"Content-Type": "application/json"},
        body: jsonEncode(<String, Object>{
          'paginator': {'page': 1, 'pageSize': 1000},
          // Adicione outros parâmetros de pesquisa, se necessário
        }),
      );

      if (response.statusCode == 200) {
        return jsonDecode(response.body);
      } else {
        return null;
      }
    } catch (e) {
      print("Erro no login: $e");
      return null;
    }
  }
}
