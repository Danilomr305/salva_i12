// ignore_for_file: empty_constructor_bodies

import 'package:i12mobile/domain/models/model/base_model.dart';
import 'package:i12mobile/domain/models/model/descendencia.dart';
import 'package:i12mobile/domain/models/model/pessoas_models.dart';
import 'package:i12mobile/domain/models/shared/descrition_model.dart';

class VisitaModels extends BaseModel {
  final PessoasModels pessoa;
  final int totalVisitas;
  final String dataUltimaVisita;
  final String pedidoOracao;
  final String numeroTelefone;
  late String convidadoPor;
  final String tipoConversao;
  final DescendenciaModels descendencia;
  final String estaEmCelula;
  final String nomeLiderCelula;
  //final Endereco endereco;

  VisitaModels({
    required this.pessoa,
    required this.totalVisitas,
    required this.dataUltimaVisita,
    required this.pedidoOracao,
    required this.numeroTelefone,
    required this.convidadoPor,
    required this.tipoConversao,
    required this.descendencia,
    required this.estaEmCelula,
    required this.nomeLiderCelula,
    required super.id,
    required super.descritionDto,
    //required this.endereco
  });

  factory VisitaModels.fromJson(Map<String, dynamic> json) {
    print("Valor do campo 'estaEmCelula': ${json['estaEmCelula']}");

    return VisitaModels(
        id: json['id'] ?? '',
        descritionDto: json['descritionDto'] != null &&
                json['descritionDto'] is Map<String, dynamic>
            ? Descrition.fromJson(json['descritionDto'])
            : Descrition(id: '', descricao: ''),
        pessoa: json['pessoa'] != null
            ? PessoasModels.fromJson(json['pessoa'])
            : PessoasModels(
                id: json['id'] ?? '',
                descritionDto: json['descritionDto'],
                nome: '',
                sexo: '',
                descendencia: DescendenciaModels(descricao: '', sigla: ''),
                lider: ''),
        dataUltimaVisita: json['dataUltimaVisita'] ?? '',
        pedidoOracao: json['pedidoOracao'] ?? '',
        numeroTelefone: json['numeroTelefone'] ?? '',
        convidadoPor: json['convidadoPor'] ?? '',
        totalVisitas: json['totalVisitas'] ?? '',
        descendencia: json['descendencia'] != null
            ? DescendenciaModels.fromJson(json['descendencia'])
            : DescendenciaModels(descricao: '', sigla: ''),
        estaEmCelula: json['estaEmCelula'] ?? '',
        nomeLiderCelula: json['nomeLiderCelula'] ?? '',
        tipoConversao: json['tipoConversao'] ?? '');
  }

  // Converter NovaVidaModel para Json
  Map<String, dynamic> toJson() {
    return {
      'descritionDto': descritionDto,
      'id': id,
      'descendencia': descendencia,
      'dataUltimaVisita': dataUltimaVisita,
      'pedidoOracao': pedidoOracao,
      'numeroTelefone': numeroTelefone,
      'nomeLiderCelula': nomeLiderCelula,
      'pessoa': pessoa,
      'convidadoPor': convidadoPor,
      'estaEmCelula': estaEmCelula,
      'tipoConversao': tipoConversao,
      'totalVisitas': totalVisitas
      //'endereco': endereco
    };
  }
}
