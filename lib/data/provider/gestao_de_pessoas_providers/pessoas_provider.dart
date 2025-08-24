// ignore_for_file: must_be_immutable, unnecessary_brace_in_string_interps, avoid_print, use_key_in_widget_constructors, avoid_renaming_method_parameters, overridden_fields, annotate_overrides, non_constant_identifier_names
import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:i12mobile/data/repository/gestao_de_pessoas_repository/membros_repository.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:http/http.dart' as http;
import '../../../domain/models/model/pessoas_models.dart';

class PessoaProvider extends ChangeNotifier {
  final MembrosRepository _membrosRepository;

  PessoaProvider(this._membrosRepository);

  List<PessoasModels> _pessoas = [];
  List<PessoasModels> get pessoas => _pessoas;
  PessoasModels? pessoaSelected;
  int? indexPessoa;
  bool get isLoading => _isLoading;
  String? get error => _error;
  String? _error;
  bool _isLoading = false;

  void _setLoading(bool value) {
    _isLoading = value;
    notifyListeners();
  }

  Future<void> listPessoas() async {
    _setLoading(true);
    _error = null;
    try {
      _pessoas = await _membrosRepository.listPessoas();
    } catch (e) {
      _error = e.toString();
    } finally {
      _setLoading(false);
    }
  }

  /*Future<String?> getTokenPessoas() async {
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    return sharedPreferences.getString('token');
  }

  Future<List<PessoasModels>> listPessoas({
    int page = 1,
    int size = 48,
  }
      /*String name, String descendencia,
      String lider, String sexo, String id, */
      ) async {
    var token = await getTokenPessoas();
    print('Token utilizado: $token');

    final response = await http.get(
      //Uri.parse('https://g12.logos.seg.br/pessoas'),
      Uri.parse('https://g12.logos.seg.br/pessoas?page=$page&size=$size'),
      headers: {
        'Authorization': token ?? '',
      },
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
  }*/
}
