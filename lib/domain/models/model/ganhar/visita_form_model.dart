import 'package:i12mobile/domain/models/model/descendencia.dart';
import 'package:i12mobile/domain/models/model/igreja.dart';
import 'package:i12mobile/domain/models/model/pessoas_models.dart';
import 'package:i12mobile/domain/models/shared/descrition_model.dart';
import 'package:i12mobile/domain/models/shared/endereco_model.dart';

import 'visita_detalhe_models.dart';

class VisitaFormModel {
  final String id;
  final PessoasModels pessoa;
  final String tipoEvento;
  final String pedidoOracao;
  final String numeroTelefone;
  final String convidadoPor;
  final String estaEmCelula;
  final Descrition tipoConversao;
  final DescendenciaModels descendencia;
  final IgrejaModels igreja;
  final Endereco endereco;
  final int totalVisitas;
  final DateTime dataUltimaVisita;
  final DateTime dataInscricaoUniVida;

  VisitaFormModel(
      {required this.id,
      required this.pessoa,
      required this.tipoEvento,
      required this.pedidoOracao,
      required this.numeroTelefone,
      required this.convidadoPor,
      required this.estaEmCelula,
      required this.tipoConversao,
      required this.descendencia,
      required this.igreja,
      required this.endereco,
      required this.totalVisitas,
      required this.dataUltimaVisita,
      required this.dataInscricaoUniVida});

  factory VisitaFormModel.fromJson(Map<String, dynamic> json) {
    return VisitaFormModel(
      id: json['id'] ?? '',
      pessoa: json['pessoa'] != null
          ? PessoasModels.fromJson(json['pessoa'])
          : PessoasModels(
              nome: '',
              sexo: '',
              descendencia: DescendenciaModels.empty(),
              lider: '',
              id: '',
              descritionDto: Descrition(id: '', descricao: ''),
              igreja: IgrejaModels.empty(),
            ),
      tipoEvento: json['tipoEvento'] ?? '',
      pedidoOracao: json['pedidoOracao'] ?? '',
      numeroTelefone: json['numeroTelefone'] ?? '',
      convidadoPor: json['convidadoPor'] ?? '',
      estaEmCelula: json['estaEmCelula'] ?? '',
      tipoConversao: json['tipoConversao'] is String
          ? Descrition(id: '', descricao: json['tipoConversao'])
          : Descrition.fromJson(json['tipoConversao'] ?? {}),
      descendencia: json['descendencia'] != null
          ? DescendenciaModels.fromJson(json['descendencia'])
          : DescendenciaModels.empty(),
      igreja: json['igreja'] != null
          ? IgrejaModels.fromJson(json['igreja'])
          : IgrejaModels.empty(),
      endereco: json['endereco'] != null
          ? Endereco.fromJson(json['endereco'])
          : Endereco.empty(),
      totalVisitas: json['totalVisitas'] ?? 0,
      dataUltimaVisita: json['dataUltimaVisita'] ?? '',
      dataInscricaoUniVida: json['dataInscricaoUniVida'] ?? '',
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'pessoa': pessoa.toJson(),
      'tipoEvento': tipoEvento,
      'pedidoOracao': pedidoOracao,
      'numeroTelefone': numeroTelefone,
      'convidadoPor': convidadoPor,
      'estaEmCelula': estaEmCelula,
      'tipoConversao': tipoConversao.toJson(),
      'descendencia': descendencia.toJson(),
      'igreja': igreja.toJson(),
      'endereco': endereco.toJson(),
      'totalVisitas': totalVisitas,
      'dataUltimaVisita': dataUltimaVisita.toIso8601String(),
      'dataInscricaoUniVida': dataInscricaoUniVida.toIso8601String(),
    };
  }

  factory VisitaFormModel.fromDetalhe(VisitaDetalheModels detalhe) {
    return VisitaFormModel(
      id: detalhe.id ?? '',
      pessoa: detalhe.pessoa,
      tipoEvento: '', // Ajuste se tiver campo em detalhe
      pedidoOracao: detalhe.pedidoOracao,
      numeroTelefone: detalhe.numeroTelefone,
      convidadoPor: detalhe.convidadoPor,
      estaEmCelula: detalhe.estaEmCelula,
      tipoConversao: detalhe.tipoConversao,
      descendencia: detalhe.descendencia,
      igreja: detalhe.pessoa.igreja,
      endereco: Endereco.empty(),
      totalVisitas: detalhe.totalVisitas,
      dataUltimaVisita:
          DateTime.tryParse(detalhe.dataUltimaVisita) ?? DateTime.now(),
      dataInscricaoUniVida: DateTime.now(), // Ajuste se tiver a data correta
    );
  }
}
