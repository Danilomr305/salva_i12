import 'package:i12mobile/domain/models/model/discipular/ecd_modulo_model.dart';
import '../../shared/descrition_model.dart';
import '../base_model.dart';
import '../igreja.dart';

class EcdModel extends BaseModel {
  final IgrejaModels igreja;
  final String descricao;
  final EcdModulo modulo;
  final String dataInicio;
  final String dataConclusao;
  final num totalAlunos;
  final String localAula;

  EcdModel({
    required super.id,
    required super.descritionDto,
    required this.igreja,
    required this.descricao,
    required this.modulo,
    required this.dataInicio,
    required this.dataConclusao,
    required this.totalAlunos,
    required this.localAula,
  });

  factory EcdModel.fromJson(Map<String, dynamic> json) {
    return EcdModel(
      id: json['id'] ?? '',
      descritionDto: json['descritionDto'],
      /* != null
          ? Descrition(json['descritionDto'],
              id: '', descricao: '') // Convertendo a String em Descrition
          : Descrition('',
              descricao: '',
              id: ''),*/ // Se for null, passa uma Descrition vazia,
      igreja: json['igreja'] != null
          ? IgrejaModels.fromJson(json['igreja'])
          : IgrejaModels(
              razaoSocial: '',
              sigla: '',
              nomeFantasia: '',
              documento: '',
              id: '',
              descritionDto: Descrition(id: '', descricao: '')),
      descricao: json['descricao'] ?? '',
      modulo: json['modulo'] != null
          ? EcdModulo.fromJson(json['modulo'])
          : EcdModulo(
              id: '',
              descritionDto: Descrition(descricao: '', id: ''),
              descricao: '',
              nivel: 0,
              livro: 0),
      dataInicio: json['dataInicio'] ?? '',
      dataConclusao: json['dataConclusao'] ?? '',
      totalAlunos: json['totalAluno'] != null
          ? num.tryParse(json['totalAluno'].toString()) ?? 0
          : 0,
      localAula: json['localAula'] ?? '',
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'descritionDto': descritionDto.toJson(),
      'igreja': igreja.toJson(),
      'descricao': descricao,
      'modulo': modulo.toJson(),
      'dataInicio': dataInicio,
      'dataConclusao': dataConclusao,
      'totalAlunos': totalAlunos,
      'localAula': localAula,
    };
  }

  @override
  String toString() {
    return 'EcdModel(id: $id, descricao: $descricao, igreja: ${igreja.razaoSocial}, modulo: ${modulo.descricao}, '
        'dataInicio: $dataInicio, dataConclusao: $dataConclusao, totalAlunos: $totalAlunos, localAula: $localAula)';
  }
}
