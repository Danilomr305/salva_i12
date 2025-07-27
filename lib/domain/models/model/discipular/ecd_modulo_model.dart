import 'package:i12mobile/domain/models/model/base_model.dart';
import '../../shared/descrition_model.dart';

class EcdModulo extends BaseModel {
  late String descricao;
  final num nivel;
  final num livro;

  EcdModulo(
      {required super.id,
      required super.descritionDto,
      required this.descricao,
      required this.nivel,
      required this.livro});

  factory EcdModulo.fromJson(Map<String, dynamic> json) {
    return EcdModulo(
      id: json['id'] ?? '',
      descritionDto: json['descritionDto'],
      /* != null
          ? Descrition(json['descritionDto'], id: '', descricao: '')
          : Descrition('', descricao: '', id: ''),*/
      descricao: json['descricao'] ?? '',
      nivel: json['nivel'] != null
          ? num.tryParse(json['nivel'].toString()) ?? 0
          : 0, // Conversão para `num` ou padrão `0`
      livro: json['livro'] != null
          ? num.tryParse(json['livro'].toString()) ?? 0
          : 0, // Conversão para `num` ou padrão `0`
    );
  }

  // Converter VisitaModel para Json
  Map<String, dynamic> toJson() {
    return {
      'descritionDto': descritionDto,
      'id': id,
      'descricao': descricao,
      'nivel': nivel,
      'livro': livro
    };
  }
}
