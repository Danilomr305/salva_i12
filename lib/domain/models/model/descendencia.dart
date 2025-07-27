import 'package:i12mobile/domain/models/model/igreja.dart';

class DescendenciaModels {
  late String descricao;
  final String sigla;
  late IgrejaModels? igreja;

  DescendenciaModels(
      {required this.descricao, required this.sigla, this.igreja});

  factory DescendenciaModels.fromJson(Map<String, dynamic> json) {
    return DescendenciaModels(
        descricao: json['descricao'] ?? '', sigla: json['sigla'] ?? '');
  }

  Map<String, dynamic> toJson() {
    return {'descricao': descricao, 'sigla': sigla};
  }
}
