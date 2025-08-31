import 'dart:convert';

import 'package:flutter/foundation.dart';
import 'package:http/http.dart' as http;
import 'package:i12mobile/domain/models/model/pessoas_models.dart';
import 'package:shared_preferences/shared_preferences.dart';

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
    int size = 48,
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
}
