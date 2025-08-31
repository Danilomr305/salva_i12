import 'package:i12mobile/domain/models/model/base_model.dart';
import 'package:i12mobile/domain/models/model/consolidar/univida_semana_model.dart';

import '../../shared/descrition_model.dart';

class UniVidaLicao extends BaseModel {
  final String iD;
  final String descricao;
  final UniVidaSemana semana;
  final int dia;

  UniVidaLicao({
    required super.id,
    required super.descritionDto,
    required this.descricao,
    required this.semana,
    required this.dia,
    required this.iD,
  });

  factory UniVidaLicao.fromJson(Map<String, dynamic> json) {
    return UniVidaLicao(
      descritionDto: json['descritionDto'] != null
          ? Descrition.fromJson(
              json['descritionDto']) // Converte o JSON para Descrition
          : Descrition(
              id: '', descricao: ''), // Se for null, passa uma Descrition vazia
      id: json['id'] ?? '',
      descricao: json['descricao'] ?? '',
      semana: json['semana'] != null
          ? UniVidaSemana.fromJson(
              json['semana']) // Converte 'semana' para UniVidaSemana
          : UniVidaSemana(
              id: '',
              descricao: '',
              semanaNumero: 0,
              descritionDto: Descrition(id: '', descricao: '')),
      dia: json['dia'] ?? 0,
      iD: json['iD'] ?? '',
    );
  }

  // Converter UniVidaLicao para Json
  Map<String, dynamic> toJson() {
    return {
      'descritionDto': descritionDto.toJson(),
      'id': id,
      'descricao': descricao,
      'semana': semana.toJson(), // Convertendo 'semana' para JSON
      'dia': dia,
      'iD': iD,
    };
  }
}


/*class UniVidaLicao extends BaseModel {

  final String iD;
  final String descricao;
  final UniVidaSemana semana;
  final int dia;
  
  UniVidaLicao(
    {
      required super.id, 
      required super.descritionDto,
      required this.descricao,
      required this.semana,
      required this.dia,
      required this.iD
    }
  );

  factory UniVidaLicao.fromJson(Map<String, dynamic> json) {
    return UniVidaLicao( 
      descritionDto: json['descritionDto'] != null
        ? Descrition(json['descritionDto'], id: '', descrition: '') // Convertendo a String em Descrition
        : Descrition('', descrition: '', id: ''), // Se for null, passa uma Descrition vazia
      id: json['id'] ?? '',
      descricao: json['descricao'] ?? '', 
      semana: json['semana'] ?? '', 
      dia: json['dia'] ?? '', 
      iD: json['iD'] ?? ''
    );
  }
  
  // Converter VisitaModel para Json
  Map<String, dynamic> toJson() {
    return {
      'descritionDto': descritionDto,
      'id': id,
      'descricao': descricao,
      'semana': semana,
      'dia': dia,
      'iD': iD,
    };
  }
}*/