import 'package:i12mobile/domain/models/model/descendencia.dart';
import 'package:i12mobile/domain/models/model/igreja.dart';
import 'package:i12mobile/domain/models/model/pessoas_models.dart';
import 'package:i12mobile/domain/models/shared/descrition_model.dart';
import 'package:i12mobile/domain/models/shared/endereco_model.dart';

class VisitaFromModel {
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
  final String dataUltimaVisita;
  final String dataInscricaoUniVida;

  VisitaFromModel(
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

  factory VisitaFromModel.fromJson(Map<String, dynamic> json) {
    return VisitaFromModel(
        id: json['id'] ?? '',
        pessoa: json['pessoa'] != null
            ? PessoasModels.fromJson(json['pessoa'])
            : PessoasModels(
                nome: '',
                sexo: '',
                descendencia: DescendenciaModels(descricao: '', sigla: ''),
                lider: '',
                id: '',
                descritionDto: Descrition(id: '', descricao: '')),
        tipoEvento: json['tipoEvento'] ?? '',
        pedidoOracao: json['pedidoOracao'] ?? '',
        numeroTelefone: json['numeroTelefone'] ?? '',
        convidadoPor: json['convidadoPor'] ?? '',
        estaEmCelula: json['estaEmCelula'] ?? '',
        tipoConversao:
            json['tipoConversao'] != null && json['tipoConversao'] is String
                ? Descrition(id: '', descricao: json['tipoConversao'])
                : json['tipoConversao'] is Map<String, dynamic>
                    ? Descrition.fromJson(json['tipoConversao'])
                    : Descrition(id: '', descricao: ''),
        descendencia: json['descendencia'] != null
            ? DescendenciaModels.fromJson(json['descendencia'])
            : DescendenciaModels(descricao: '', sigla: ''),
        igreja: json['igreja'] != null
            ? IgrejaModels.fromJson(json['igreja'])
            : IgrejaModels(
                razaoSocial: '', sigla: '', nomeFantasia: '', documento: ''),
        endereco: json['endereco'],
        totalVisitas: json['totalVisitas'],
        dataUltimaVisita: json['dataUltimaVisita'] ?? '',
        dataInscricaoUniVida: json['dataInscricaoUniVida'] ?? '');
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'pessoa': pessoa,
      'tipoEvento': tipoEvento,
      'pedidoOracao': pedidoOracao,
      'numeroTelefone': numeroTelefone,
      'convidadoPor': convidadoPor,
      'estaEmCelula': estaEmCelula,
      'tipoConvencao': tipoConversao,
      'descendencia': descendencia,
      'igreja': igreja,
      'endenreco': endereco,
      'totalVisitas': totalVisitas,
      'dataUltimaVisita': dataUltimaVisita,
      'dataInscricaoUniVida': dataInscricaoUniVida
    };
  }
}
