import 'package:i12mobile/domain/models/model/base_model.dart';

class UniVidaSemana extends BaseModel {
  final String descricao;
  final int semanaNumero;

  UniVidaSemana(
      {required super.id,
      required super.descritionDto,
      required this.descricao,
      required this.semanaNumero});

  factory UniVidaSemana.fromJson(Map<String, dynamic> json) {
    return UniVidaSemana(
        id: json['id'] ?? '',
        descritionDto: json['descritionDto'],
        /* != null
            ? Descrition(json['descritionDto'],
                id: '', descricao: '') // Convertendo a String em Descrition
            : Descrition('',
                descricao: '',
                id: ''), */ // Se for null, passa uma Descrition vazia,
        descricao: json['descricao'] ?? '',
        semanaNumero: json['semanaNumero'] ?? '');
  }

  // Converter VisitaModel para Json
  Map<String, dynamic> toJson() {
    return {
      'descritionDto': descritionDto,
      'id': id,
      'descricao': descricao,
      'semanaNumero': semanaNumero,
    };
  }
}
