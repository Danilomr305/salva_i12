import 'package:flutter/material.dart';
import '../../../../domain/models/model/descendencia.dart';
import '../../../../domain/models/model/ganhar/visita_detalhe_models.dart';
import '../../../../domain/models/model/ganhar/visita_form_model.dart';
import '../../../../domain/models/shared/situacao_model.dart';
import '../../../repository/ganhar/visita_repository.dart';

class VisitaProvider extends ChangeNotifier {
  final VisitaRepository _repository;

  VisitaProvider(this._repository);

  List<VisitaDetalheModels> _visitas = [];
  List<VisitaDetalheModels> get visitas => _visitas;
  bool get isLoading => _isLoading;
  String? get error => _error;
  bool _isLoading = false;
  String? _error;
  VisitaDetalheModels? visitasSelected;
  int? indexVisitas;

  List<SituacaoModel> _situacoes = [];
  List<SituacaoModel> get situacoes => _situacoes;

  List<DescendenciaModels> _descendencias = [];
  List<DescendenciaModels> get descendencias => _descendencias;

  void _setLoading(bool value) {
    _isLoading = value;
    notifyListeners();
  }

  Future<void> listVisitas() async {
    _setLoading(true);
    _error = null;
    try {
      _visitas = await _repository.listVisitas();
    } catch (e) {
      _error = e.toString();
    } finally {
      _setLoading(false);
    }
  }

  Future<void> createVisitaForm(VisitaFormModel visita) async {
    _setLoading(true);
    _error = null;
    try {
      await _repository.createVisitaForm(visita);
      await listVisitas(); // Atualiza a lista após criar
    } catch (e) {
      _error = e.toString();
    } finally {
      _setLoading(false);
    }
  }

  Future<void> listSituacao() async {
    _setLoading(true);
    _error = null;
    try {
      // Chama o repositório, que agora retorna uma Future<List<SituacaoModel>>
      _situacoes = await _repository.listarSituacoes();
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
      // Chama o repositório, que agora retorna uma Future<List<SituacaoModel>>
      _descendencias = await _repository.listarDescendencias(igrejaId);
    } catch (e) {
      _error = e.toString();
    } finally {
      _setLoading(false);
    }
  }
}
