import 'package:i12mobile/domain/models/model/base_model.dart';
import 'package:i12mobile/domain/models/model/igreja.dart';

import '../shared/descrition_model.dart';
import 'descendencia.dart';

class PessoasModels extends BaseModel {
  late String nome;
  final String sexo;
  final DescendenciaModels descendencia;
  final IgrejaModels igreja;
  final String lider;

  PessoasModels({
    required this.nome,
    required this.sexo,
    required this.descendencia,
    required this.lider,
    required this.igreja,
    required super.id,
    required super.descritionDto,
  });

  factory PessoasModels.fromJson(Map<String, dynamic> json) {
    return PessoasModels(
      id: json['id'] ?? '',
      igreja: json['igreja'] != null
          ? IgrejaModels.fromJson(json['igreja'])
          : IgrejaModels.empty(),
      descritionDto: json['descritionDto'] != null &&
              json['descritionDto'] is Map<String, dynamic>
          ? Descrition.fromJson(json['descritionDto'])
          : Descrition(id: '', descricao: ''),
      descendencia: json['descendencia'] != null
          ? DescendenciaModels.fromJson(json['descendencia'])
          : DescendenciaModels.empty(),
      nome: json['nome'],
      lider: '',
      sexo: json['sexo'] ?? '',
    );
  }

  // Converter Pessoas para JSON
  /*Map<String, dynamic> toJson() {
    return {
      'id': id,
      'igreja': igreja.toJson(),
      'descritionDto': descritionDto.toJson(),
      'descendencia': descendencia.toJson(),
      'nome': nome,
      'lider': lider,
      'sexo': sexo,
    };
  }*/
  Map<String, dynamic> toJson() {
    return {
      if (id.isNotEmpty) 'id': id,
      'nome': nome,
      'sexo': sexo,
      if (igreja.id.isNotEmpty) 'igreja': igreja.toJson(),
      if (descritionDto.id.isNotEmpty) 'descritionDto': descritionDto.toJson(),
      if (descendencia.id.isNotEmpty) 'descendencia': descendencia.toJson(),
      if (lider.isNotEmpty) 'lider': lider,
    };
  }

  // metodo empty para criar um objeto vazio
  static PessoasModels empty() {
    return PessoasModels(
      id: '',
      nome: '',
      sexo: '',
      descendencia: DescendenciaModels.empty(),
      lider: '',
      descritionDto: Descrition(id: '', descricao: ''),
      igreja: IgrejaModels.empty(),
    );
  }
}
