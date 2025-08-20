import 'package:i12mobile/domain/models/model/base_model.dart';
import 'package:i12mobile/domain/models/model/igreja.dart';
import '../../shared/descrition_model.dart';

class UniVida extends BaseModel {
  final IgrejaModels igreja;
  final String descricao;
  final String licaoAtual; // Definido como String, ajuste conforme o tipo real.
  final String dataInicio;
  final String dataConclusao;
  final int totalAlunos;
  late String localAula;

  UniVida({
    required super.id,
    required super.descritionDto,
    required this.igreja,
    required this.descricao,
    required this.licaoAtual,
    required this.dataInicio,
    required this.dataConclusao,
    required this.totalAlunos,
    required this.localAula,
  });

  factory UniVida.fromJson(Map<String, dynamic> json) {
    return UniVida(
      id: json['id'] ?? '',
      descritionDto: json['descritionDto'],
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
      licaoAtual: json['licaoAtual'] ?? '',
      dataInicio: json['dataInicio'] ?? '',
      dataConclusao: json['dataConclusao'] ?? '',
      totalAlunos: json['totalAlunos'] ?? 0,
      localAula: json['localAula'] ?? '',
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'descritionDto': descritionDto
          .toJson(), // Supondo que Descrition tenha um método toJson()
      'igreja':
          igreja.toJson(), // Supondo que IgrejaModels tenha um método toJson()
      'descricao': descricao,
      'licaoAtual': licaoAtual,
      'dataInicio': dataInicio,
      'dataConclusao': dataConclusao,
      'totalAlunos': totalAlunos,
      'localAula': localAula,
    };
  }
}
