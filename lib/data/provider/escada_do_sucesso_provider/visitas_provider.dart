import 'package:flutter/material.dart';

import '../../../domain/models/model/ganhar/visita_detalhe_models.dart';
import '../../repository/ganhar/visita_detalhe_repository.dart';

class VisitaDetalheProvider extends ChangeNotifier {
  final VisitaDetalheRepository _visitaRepository = VisitaDetalheRepository();

  List<VisitaDetalheModels> lifes = [];
  VisitaDetalheModels? lifesSelected;
  int? indexLifes;

  bool isLoading = false;
  String? error;

  Future<void> listVisita(
      String tipoConversao,
      String pessoa,
      String descendencia,
      String dataNascimento,
      String telefone,
      String convidadoPor,
      String estaEmCelula,
      String nomeLiderCelula,
      String pedidoOracao) async {
    isLoading = true;
    notifyListeners();

    try {
      final resultado = await _visitaRepository.listVisitas(
          tipoConversao: tipoConversao,
          pessoa: pessoa,
          descendencia: descendencia,
          dataNascimento: dataNascimento,
          telefone: telefone,
          convidadoPor: convidadoPor,
          estaEmCelula: estaEmCelula,
          nomeLiderCelula: nomeLiderCelula,
          pedidoOracao: pedidoOracao);

      lifes = resultado;
      error = null;
    } catch (e) {
      error = e.toString();
      lifes = [];
    }

    isLoading = false;
    notifyListeners();
  }
}
