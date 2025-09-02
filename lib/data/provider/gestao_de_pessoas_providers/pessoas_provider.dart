// ignore_for_file: must_be_immutable, unnecessary_brace_in_string_interps, avoid_print, use_key_in_widget_constructors, avoid_renaming_method_parameters, overridden_fields, annotate_overrides, non_constant_identifier_names

import 'package:flutter/material.dart';
import 'package:i12mobile/data/repository/gestao_de_pessoas_repository/membros_repository.dart';
import '../../../domain/models/model/descendencia.dart';
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

  List<DescendenciaModels> _descendencias = [];
  List<DescendenciaModels> get descendencias => _descendencias;

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

  Future<void> listDescendencia(String? igrejaId) async {
    _setLoading(true);
    _error = null;
    try {
      final idLimpo = igrejaId?.replaceAll('"', '');
      _descendencias = await _membrosRepository.listarDescendencias(idLimpo);
    } catch (e) {
      _error = e.toString();
    } finally {
      _setLoading(false);
    }
  }

  Future<void> createMembroForm(PessoasModels membros) async {
    _setLoading(true);
    _error = null;
    try {
      await _membrosRepository.createMembroForm(membros);
      await listPessoas(); // Atualiza a lista após criar
    } catch (e) {
      _error = e.toString();
    } finally {
      _setLoading(false);
    }
  }
}
