import 'package:i12mobile/domain/models/model/base_model.dart';
import 'package:i12mobile/domain/models/shared/descrition_model.dart';

import 'rota_da_vida_models.dart';

class RotaDaVidaContatos extends BaseModel {
  final RotaDaVidaModels rota;
  final String dataContato;
  final Descrition tipoContato;
  final Descrition reacao;
  final String responsavel;
  final String observacao;

  RotaDaVidaContatos(
      {required this.rota,
      required this.dataContato,
      required this.tipoContato,
      required this.reacao,
      required this.responsavel,
      required this.observacao,
      required super.id,
      required super.descritionDto});

  factory RotaDaVidaContatos.fromJson(Map<String, dynamic> json) {
    return RotaDaVidaContatos(
      rota: RotaDaVidaModels.fromJson(json['rota']),
      dataContato: json['dataContato'],
      tipoContato: json['tipoContato'],
      /* != null
          ? Descrition(json['tipoContato'],
              id: '', descricao: '') // Convertendo a String em Descrition
          : Descrition('',
              descricao: '',
              id: ''), */ // Se for null, passa uma Descrition vazia,
      reacao: json['reacao'],
      /*!= null
          ? Descrition(json['reacao'],
              id: '', descricao: '') // Convertendo a String em Descrition
          : Descrition('',
              descricao: '',
              id: ''),*/ // Se for null, passa uma Descrition vazia,,
      responsavel: json['responsavel'],
      observacao: json['observacao'],
      id: json['id'] ?? '',
      descritionDto: json[
          'descritionDto'], /*!= null
          ? Descrition(json['descritionDto'],
              id: '', descricao: '') // Convertendo a String em Descrition
          : Descrition('',
              descricao: '', id: ''),*/ // Se for null, passa uma Descrition vazia
    );
  }
}
