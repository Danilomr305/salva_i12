import 'package:i12mobile/domain/models/model/base_model.dart';
import 'package:i12mobile/domain/models/model/igreja.dart';

import '../shared/descrition_model.dart';
import 'descendencia.dart';

class PessoasModels extends BaseModel {
  late String nome;
  final String sexo;
  final DescendenciaModels descendencia;
  late IgrejaModels igreja;
  final String lider;

  PessoasModels({
    required this.nome,
    required this.sexo,
    required this.descendencia,
    required this.lider,
    required super.id,
    required super.descritionDto,
  });

  factory PessoasModels.fromJson(Map<String, dynamic> json) {
    return PessoasModels(
      id: json['id'] ?? '',
      descritionDto: json['descritionDto'] != null &&
              json['descritionDto'] is Map<String, dynamic>
          ? Descrition.fromJson(json['descritionDto'])
          : Descrition(id: '', descricao: ''),
      descendencia: json['descendencia'] != null
          ? DescendenciaModels.fromJson(json['descendencia'])
          : DescendenciaModels(descricao: '', sigla: ''),
      nome: json['nome'],
      lider: '',
      sexo: json['sexo'] ?? '',
    );
  }

  // Converter Pessoas para JSON
  Map<String, dynamic> toJson() {
    return {
      'descendecia': descendencia,
      'nome': nome,
      'lider': lider,
      'sexo': sexo,
    };
  }
}
