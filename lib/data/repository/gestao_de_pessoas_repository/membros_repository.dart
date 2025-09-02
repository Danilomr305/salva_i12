import 'dart:async';
import 'dart:convert';

import 'package:flutter/foundation.dart';
import 'package:http/http.dart' as http;
import 'package:i12mobile/domain/models/model/pessoas_models.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../../domain/models/model/descendencia.dart';

class MembrosRepository {
  static const String _baseUrl = 'https://g12.logos.seg.br/pessoas';

  //Resposável por obter o token de autenticação
  Future<String> _getTokenPessoas() async {
    final prefs = await SharedPreferences.getInstance();
    final token = prefs.getString('token');

    if (token == null || token.isEmpty) {
      throw Exception('Token não encontrado. Faça login novamente.');
    }
    return token;
  }

  /// GET - Lista de membros
  Future<List<PessoasModels>> listPessoas({
    int page = 1,
    int size = 500,
  }) async {
    final token = await _getTokenPessoas();
    print('Token utilizado: $token');

    final uri = Uri.parse('$_baseUrl?page=$page&size=$size');
    if (kDebugMode) print('🔹 [GET] $uri');

    final response = await http.get(
      uri,
      headers: {
        'Content-Type': 'application/json',
        'Authorization': token, // já vem com Bearer
      },
    );

    print('📡 Status de Membros: ${response.statusCode}');
    print('📦 Corpo de Membros: ${response.body}');

    if (response.statusCode == 200) {
      final jsonBody = jsonDecode(response.body);

      if (jsonBody['content'] is List) {
        return (jsonBody['content'] as List)
            .map((e) => PessoasModels.fromJson(e))
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
  /// GET - Lista de descendencias
  Future<List<DescendenciaModels>> listarDescendencias(String? igrejaId) async {
    if (igrejaId == null || igrejaId.isEmpty) {
      throw Exception("⚠️ O parâmetro igrejaId não pode ser nulo ou vazio.");
    }

    final token = await _getTokenPessoas();
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

  /// POST - Criar novo membro
  Future<void> createMembroForm(PessoasModels membros) async {
    final token = await _getTokenPessoas();

    print('📡 [POST MEMBROS] URL: $_baseUrl');
    print('📝 JSON enviado: ${jsonEncode(membros.toJson())}');
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
            body: jsonEncode(membros.toJson()),
          )
          .timeout(const Duration(seconds: 10));
      final requestBody = membros.toJson();
      print('Corpo da requisição para a API: ${json.encode(requestBody)}');
      print('📡 Status [MEMBROS]: ${response.statusCode}');
      print('📦 Body [MEMBROS]: ${response.body}');

      if (response.statusCode == 200 || response.statusCode == 201) {
        print('✅ Membro criada com sucesso!');
      } else {
        print(
            'Erro ao criar membro: ${response.statusCode} - ${response.body}');
      }
    } on TimeoutException catch (_) {
      print('Erro: Timeout na requisição POST');
    } catch (e) {
      print('Erro na requisição POST: $e');
    }
  }
}
