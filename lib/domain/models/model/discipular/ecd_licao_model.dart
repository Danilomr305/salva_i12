import 'package:i12mobile/domain/models/model/base_model.dart';
import '../../shared/descrition_model.dart';
import 'ecd_modulo_model.dart';

class EcdLicao extends BaseModel {
  late String descricao;
  final EcdModulo modulo;
  final num capitulo;

  EcdLicao(
      {required super.id,
      required super.descritionDto,
      required this.descricao,
      required this.modulo,
      required this.capitulo});

  factory EcdLicao.fromJson(Map<String, dynamic> json) {
    return EcdLicao(
      id: json['id'] ?? '',
      descritionDto: json['descritionDto'],
      descricao: json['descricao'] ?? '',
      modulo: json['modulo'] != null
          ? EcdModulo.fromJson(json['modulo'])
          : EcdModulo(
              id: '',
              descritionDto: Descrition(descricao: '', id: ''),
              descricao: '',
              nivel: 0,
              livro: 0),
      capitulo: json['capitulo'] != null
          ? num.tryParse(json['capitulo'].toString()) ?? 0
          : 0,
    );
  }

  // Converter VisitaModel para Json
  Map<String, dynamic> toJson() {
    return {
      'descritionDto': descritionDto,
      'id': id,
      'descricao': descricao,
      'modulo': modulo,
      'capitulo': capitulo
    };
  }
}
