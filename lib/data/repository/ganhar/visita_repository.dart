import 'dart:async';
import 'dart:convert';
import 'package:flutter/foundation.dart';
import 'package:http/http.dart' as http;
import 'package:i12mobile/domain/models/model/descendencia.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../../../domain/models/model/ganhar/visita_detalhe_models.dart';
import '../../../domain/models/model/ganhar/visita_form_model.dart';
import '../../../domain/models/shared/situacao_model.dart';

class VisitaRepository {
  // Url do Get e Post Vistas
  static const String _baseUrl = 'https://ganhar.logos.seg.br/visitas';

  //Resposável por obter o token de autenticação
  Future<String> _getTokenVisitas() async {
    final prefs = await SharedPreferences.getInstance();
    final token = prefs.getString('token');

    if (token == null || token.isEmpty) {
      throw Exception('Token não encontrado. Faça login novamente.');
    }
    return token;
  }

  ///---------------------------------------------------------------------------

  /// GET - Lista de situações
  /// Retorna uma lista de situações disponíveis para visitas.
  /// Utiliza o token de autenticação armazenado para acessar a API.
  /// Lança uma exceção se a requisição falhar ou se o formato da resposta
  /// não for o esperado.
  Future<List<SituacaoModel>> listarSituacoes() async {
    final token = await _getTokenVisitas();
    print('🔑 Token usado para retorna as situações: $token');

    final response = await http.get(
      Uri.parse('https://ganhar.logos.seg.br/visitas/tipos-conversao'),
      headers: {
        'Authorization': token,
      },
    );

    print('📡 Status de Situação: ${response.statusCode}');
    print('📦 Corpo de situação: ${response.body}');

    if (response.statusCode == 200) {
      final List<dynamic> jsonList = jsonDecode(response.body);
      return jsonList.map((item) => SituacaoModel.fromJson(item)).toList();
    } else {
      throw Exception(
        'Erro ao carregar situações: ${response.statusCode} - ${response.body}',
      );
    }
  }

  ///---------------------------------------------------------------------------
  Future<List<DescendenciaModels>> listarDescendencias(String? igrejaId) async {
    if (igrejaId == null || igrejaId.isEmpty) {
      throw Exception("⚠️ O parâmetro igrejaId não pode ser nulo ou vazio.");
    }

    final token = await _getTokenVisitas();
    print('🔑 Token usado para retornas as descendencia: $token');
    final response = await http.get(
      Uri.parse('https://eventos.logos.seg.br/descendencias/$igrejaId'),
      headers: {
        'Authorization': token,
      },
    );

    print('📡 Status de descendencia: ${response.statusCode}');
    print('📦 Corpo de descendencia: ${response.body}');

    if (response.statusCode == 200) {
      final List<dynamic> jsonList = jsonDecode(response.body);
      return jsonList.map((item) => DescendenciaModels.fromJson(item)).toList();
    } else {
      throw Exception(
        'Erro ao carregar descendências: ${response.statusCode} - ${response.body}',
      );
    }
  }

  ///---------------------------------------------------------------------------

  /// GET - Lista de visitas
  Future<List<VisitaDetalheModels>> listVisitas({
    int page = 1,
    int size = 48,
  }) async {
    final token = await _getTokenVisitas();

    final uri = Uri.parse('$_baseUrl?page=$page&size=$size');
    if (kDebugMode) print('🔹 [GET] $uri');

    final response = await http.get(
      uri,
      headers: {
        'Content-Type': 'application/json',
        'Authorization': token, // já vem com Bearer
      },
    );

    if (response.statusCode == 200) {
      final jsonBody = jsonDecode(response.body);

      if (jsonBody['content'] is List) {
        return (jsonBody['content'] as List)
            .map((e) => VisitaDetalheModels.fromJson(e))
            .toList();
      }
      throw Exception(
          'Formato de resposta inválido: campo "content" não encontrado.');
    } else {
      throw Exception(
          'Erro ao buscar visitas: ${response.statusCode} - ${response.body}');
    }
  }

  ///---------------------------------------------------------------------------

  /// POST - Criar nova visita
  Future<void> createVisitaForm(VisitaFormModel visita) async {
    final token = await _getTokenVisitas();

    print('📡 [POST VISITA] URL: $_baseUrl');
    print('📝 JSON enviado: ${jsonEncode(visita.toJson())}');
    print('🔑 Token: $token');

    try {
      final response = await http
          .post(
            Uri.parse(_baseUrl),
            headers: {
              'Content-Type': 'application/json; charset=UTF-8',
              'Authorization': token,
              //'Authorization': 'Bearer $token',
            },
            body: jsonEncode(visita.toJson()),
          )
          .timeout(const Duration(seconds: 10));
      final requestBody = visita.toJson();
      print('Corpo da requisição para a API: ${json.encode(requestBody)}');
      print('📡 Status [VISITA]: ${response.statusCode}');
      print('📦 Body [VISITA]: ${response.body}');

      if (response.statusCode == 200 || response.statusCode == 201) {
        print('✅ Visita criada com sucesso!');
      } else {
        print(
            'Erro ao criar visita: ${response.statusCode} - ${response.body}');
      }
    } on TimeoutException catch (_) {
      print('Erro: Timeout na requisição POST');
    } catch (e) {
      print('Erro na requisição POST: $e');
    }
  }
}
