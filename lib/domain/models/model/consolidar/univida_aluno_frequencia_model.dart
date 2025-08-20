import 'package:i12mobile/domain/models/model/consolidar/univida_aluno_model.dart';
import 'package:i12mobile/domain/models/model/igreja.dart';

import '../../shared/descrition_model.dart';
import '../base_model.dart';

class UniVidaAlunoFrequencia extends BaseModel {
  final IgrejaModels igreja;
  final UniVidaAluno aluno;
  final bool presente;
  final String justificativa;

  UniVidaAlunoFrequencia(
      {required super.id,
      required super.descritionDto,
      required this.igreja,
      required this.aluno,
      required this.justificativa,
      required this.presente});

  factory UniVidaAlunoFrequencia.fromJson(Map<String, dynamic> json) {
    return UniVidaAlunoFrequencia(
        descritionDto: json['descritionDto'],
        /* != null
            ? Descrition(json['descritionDto'],
                id: '', descricao: '') // Convertendo a String em Descrition
            : Descrition('',
                descricao: '',
                id: ''), */ // Se for null, passa uma Descrition vazia
        id: json['id'] ?? '',
        igreja: json['igreja'] != null
            ? IgrejaModels.fromJson(json['igreja'])
            : IgrejaModels(
                razaoSocial: '',
                sigla: '',
                nomeFantasia: '',
                documento: '',
                id: '',
                descritionDto: Descrition(id: '', descricao: '')),
        aluno: UniVidaAluno.fromJson(json['aluno']),
        justificativa: json['justificativa'] ?? '',
        presente: json['presente'] ?? '');
  }
  // Converter UniVidaAlunoFrequencia para Json
  Map<String, dynamic> toJson() {
    return {
      'descritionDto': descritionDto,
      'id': id,
      'aluno': aluno,
      'igreja': igreja,
      'justificativa': justificativa,
      'presente': presente
    };
  }
}
