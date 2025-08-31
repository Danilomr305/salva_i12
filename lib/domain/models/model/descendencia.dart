import 'package:i12mobile/domain/models/model/igreja.dart';
import 'package:i12mobile/domain/models/model/pessoas_discipulos_models.dart';
import 'package:i12mobile/domain/models/model/pessoas_models.dart';
import 'package:i12mobile/domain/models/shared/endereco_model.dart';

import '../shared/descrition_model.dart';
import 'base_model.dart';

class DescendenciaModels extends BaseModel {
  final String descricao;
  final String sigla;
  final IgrejaModels igreja;
  final PessoasModels? lider1;
  final PessoasModels? lider2;

  DescendenciaModels(
      {required this.descricao,
      required this.sigla,
      required this.igreja,
      required super.id,
      required super.descritionDto,
      this.lider1,
      this.lider2});

  factory DescendenciaModels.fromJson(Map<String, dynamic> json) {
    return DescendenciaModels(
        id: json['id'] ?? '',
        descritionDto: json['descritionDto'] != null
            ? Descrition.fromJson(json['descritionDto'])
            : Descrition(id: '', descricao: ''),
        igreja: json['igreja'] != null
            ? IgrejaModels.fromJson(json['igreja'])
            : IgrejaModels.empty(),
        descricao: json['descricao'] ?? '',
        sigla: json['sigla'] ?? '',
        lider1: json['lider1'] != null
            ? PessoasModels.fromJson(json['lider1'])
            : PessoasModels(
                igreja: IgrejaModels.empty(),
                nome: '',
                sexo: '',
                descendencia: DescendenciaModels.empty(),
                lider: '',
                id: '',
                descritionDto: Descrition(id: '', descricao: ''),
                telefone: '',
                dataNascimento: DateTime(1900, 1, 1),
                idade: 0,
                endereco: Endereco.empty(),
                totalCelulas: 0,
                pessoasDiscipulos: PessoasDiscipulosModels.empty()),
        lider2: json['lider2'] != null
            ? PessoasModels.fromJson(json['lider2'])
            : PessoasModels(
                igreja: IgrejaModels.empty(),
                nome: '',
                sexo: '',
                descendencia: DescendenciaModels.empty(),
                lider: '',
                id: '',
                descritionDto: Descrition(id: '', descricao: ''),
                telefone: '',
                dataNascimento: DateTime(1900, 1, 1),
                idade: 0,
                endereco: Endereco.empty(),
                totalCelulas: 0,
                pessoasDiscipulos: PessoasDiscipulosModels.empty()));
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'descricao': descricao,
      'sigla': sigla,
      'igreja': igreja.toJson(),
      'descritionDto': descritionDto.toJson(),
      if (lider1 != null) 'lider1': lider1!.toJson(),
      if (lider2 != null) 'lider2': lider2!.toJson(),
    };
  }

  // metodo empty para criar  um objeto vazio
  static DescendenciaModels empty() {
    return DescendenciaModels(
      id: '',
      descritionDto: Descrition(id: '', descricao: ''),
      descricao: '',
      sigla: '',
      igreja: IgrejaModels.empty(),
      lider1: null,
      lider2: null,
    );
  }
}
