// ignore_for_file: empty_constructor_bodies

import 'package:i12mobile/domain/models/model/base_model.dart';
import 'package:i12mobile/domain/models/model/descendencia.dart';
import 'package:i12mobile/domain/models/model/pessoas_models.dart';
import 'package:i12mobile/domain/models/shared/descrition_model.dart';

import '../../shared/endereco_model.dart';
import '../igreja.dart';
import '../pessoas_discipulos_models.dart';

class VisitaDetalheModels extends BaseModel {
  final PessoasModels pessoa;
  final int totalVisitas;
  final String dataUltimaVisita;
  final String pedidoOracao;
  final String numeroTelefone;
  late String convidadoPor;
  final Descrition tipoConversao;
  final DescendenciaModels descendencia;
  final String estaEmCelula;
  final String nomeLiderCelula;
  //final Endereco endereco;

  VisitaDetalheModels({
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

  factory VisitaDetalheModels.fromJson(Map<String, dynamic> json) {
    print("Valor do campo 'estaEmCelula': ${json['estaEmCelula']}");
    print(json);

    return VisitaDetalheModels(
      id: json['id'] ?? '',
      descritionDto: json['descritionDto'] != null &&
              json['descritionDto'] is Map<String, dynamic>
          ? Descrition.fromJson(json['descritionDto'])
          : Descrition(id: '', descricao: ''),
      pessoa: json['pessoa'] != null
          ? PessoasModels.fromJson(json['pessoa'])
          : PessoasModels(
              igreja: IgrejaModels.empty(),
              nome: '',
              sexo: '',
              descendencia: DescendenciaModels(
                  descricao: '',
                  sigla: '',
                  id: '',
                  descritionDto: Descrition(id: '', descricao: ''),
                  igreja: IgrejaModels.empty(),
                  lider1: PessoasModels.empty(),
                  lider2: PessoasModels.empty()),
              lider: '',
              id: '',
              descritionDto: Descrition(id: '', descricao: ''),
              telefone: '',
              dataNascimento: DateTime(1900, 1, 1),
              idade: 0,
              endereco: Endereco.empty(),
              totalCelulas: 0,
              pessoasDiscipulos: PessoasDiscipulosModels.empty()),
      dataUltimaVisita: json['dataUltimaVisita'] ?? '',
      pedidoOracao: json['pedidoOracao'] ?? '',
      numeroTelefone: json['numeroTelefone'] ?? '',
      convidadoPor: json['convidadoPor'] ?? '',
      totalVisitas: int.tryParse(json['totalVisitas']?.toString() ?? '0') ?? 0,
      descendencia: json['descendencia'] != null
          ? DescendenciaModels.fromJson(json['descendencia'])
          : DescendenciaModels.empty(),
      estaEmCelula: json['estaEmCelula'] ?? '',
      nomeLiderCelula: json['nomeLiderCelula'] ?? '',
      tipoConversao:
          json['tipoConversao'] != null && json['tipoConversao'] is String
              ? Descrition(id: '', descricao: json['tipoConversao'])
              : json['tipoConversao'] is Map<String, dynamic>
                  ? Descrition.fromJson(json['tipoConversao'])
                  : Descrition(id: '', descricao: ''),
    );
  }

  // Converter NovaVidaModel para Json
  Map<String, dynamic> toJson() {
    return {
      'descritionDto': descritionDto,
      'id': id,
      'descendencia': descendencia.toJson(),
      'dataUltimaVisita': dataUltimaVisita,
      'pedidoOracao': pedidoOracao,
      'numeroTelefone': numeroTelefone,
      'nomeLiderCelula': nomeLiderCelula,
      'pessoa': pessoa.toJson(),
      'convidadoPor': convidadoPor,
      'estaEmCelula': estaEmCelula,
      'tipoConversao': tipoConversao,
      'totalVisitas': totalVisitas
      //'endereco': endereco
    };
  }
}
