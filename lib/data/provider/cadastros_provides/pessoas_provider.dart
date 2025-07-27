// ignore_for_file: must_be_immutable, unnecessary_brace_in_string_interps, avoid_print, use_key_in_widget_constructors, avoid_renaming_method_parameters, overridden_fields, annotate_overrides, non_constant_identifier_names
import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:http/http.dart' as http;
import '../../../domain/models/model/pessoas_models.dart';

class PessoaProvider extends ChangeNotifier {
  List<PessoasModels> pessoas = [];
  PessoasModels? pessoaSelected;
  int? indexPessoa;

  Future<String?> getTokenPessoas() async {
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    return sharedPreferences.getString('token');
  }

  Future<List<PessoasModels>> listPessoas(String name, String descendencia,
      String lider, String sexo, String id) async {
    var token = await getTokenPessoas();
    print('Token utilizado: $token');

    final response = await http.post(
      Uri.parse('https://g12.logos.seg.br/pessoas/'),
      headers: <String, String>{
        'Content-Type': 'application/json',
        'Authorization': token ?? '',
      },
      body: jsonEncode(<String, Object>{
        'paginator': {'page': 1, 'pageSize': 1000},
        // Adicione outros parâmetros de pesquisa, se necessário
      }),
    );

    if (response.statusCode == 200) {
      var json = jsonDecode(response.body) as Map<String, dynamic>;

      if (json.containsKey('content')) {
        var jsonList = json['content'] as List<dynamic>;

        // Limpa a lista antes de adicionar novos dados
        pessoas.clear();
        for (var item in jsonList) {
          pessoas.add(PessoasModels.fromJson(item));
        }
        print('${pessoas}');
        notifyListeners(); // Notifica os ouvintes que a lista foi atualizada
        return pessoas;
      } else {
        throw Exception('Campo "content" não encontrado no JSON.');
      }
    } else {
      throw Exception('Falha ao carregar os dados: ${response.statusCode}');
    }
  }
}
