import 'package:i12mobile/domain/models/model/base_model.dart';
import 'package:i12mobile/domain/models/model/pessoas_models.dart';

import '../../shared/descrition_model.dart';
import '../descendencia.dart';

class RotaDaVidaModels extends BaseModel {
  final PessoasModels pessoa;
  final String estaEmCelula;
  final String dataInscricaoUniVida;

  RotaDaVidaModels({
    required this.pessoa,
    required this.estaEmCelula,
    required this.dataInscricaoUniVida,
    required super.id,
    required super.descritionDto,
  });

  factory RotaDaVidaModels.fromJson(Map<String, dynamic> json) {
    return RotaDaVidaModels(
        descritionDto: json['descritionDto'],
        /*!= null
            ? Descrition(json['descritionDto'],
                id: '', descricao: '') // Convertendo a String em Descrition
            : Descrition('',
                descricao: '',
                id: ''),*/ // Se for null, passa uma Descrition vazia
        id: json['id'] ?? '', // Garante que não seja nulo
        pessoa: json['pessoa'] != null
            ? PessoasModels.fromJson(json['pessoa'])
            : PessoasModels(
                id: json['id'] ?? '',
                descritionDto: json['descritionDto'],
                /* != null
                    ? Descrition(json['descritionDto'],
                        id: '',
                        descricao: '') // Convertendo a String em Descrition
                    : Descrition('',
                        descricao: '',
                        id: ''),*/ // Se for null, passa uma Descrition vazia
                nome: '',
                sexo: '',
                descendencia: DescendenciaModels(descricao: '', sigla: ''),
                lider: ''),
        estaEmCelula:
            json['estaEmCelula'] ?? '', // Garantindo que não seja nulo
        dataInscricaoUniVida:
            json['dataInscricaoUniVida'] ?? '' // Garantindo que não seja nulo
        );
  }

  Map<String, dynamic> toJson() {
    return {
      'descritionDto': descritionDto,
      'id': id,
      'pessoa': pessoa,
      'estaEmCelula': estaEmCelula,
      'dataInscricaoUniVida': dataInscricaoUniVida,
    };
  }
}
