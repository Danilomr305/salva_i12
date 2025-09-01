import '../shared/descrition_model.dart';
import 'base_model.dart';

class IgrejaModels extends BaseModel {
  late String razaoSocial;
  late String sigla;
  late String nomeFantasia;
  late String documento;

  IgrejaModels({
    required this.razaoSocial,
    required this.sigla,
    required this.nomeFantasia,
    required this.documento,
    required super.id,
    required super.descritionDto,
  });

  factory IgrejaModels.fromJson(Map<String, dynamic> json) {
    return IgrejaModels(
      id: (json['id'] ?? '').toString(),
      descritionDto: json['descritionDto'] != null
          ? Descrition.fromJson(json['descritionDto'])
          : Descrition(id: '', descricao: ''),
      razaoSocial: (json['razaoSocial'] ?? '').toString(),
      sigla: (json['sigla'] ?? '').toString(),
      nomeFantasia: (json['nomeFantasia'] ?? '').toString(),
      documento: (json['documento'] ?? '').toString(),
    );
  }

  /*factory IgrejaModels.fromJson(Map<String, dynamic> json) {
    return IgrejaModels(
      id: json['id'] ??
          '', // Converte para String ou usa string vazia se for null
      descritionDto: json['descritionDto'] != null
          ? Descrition.fromJson(json['descritionDto'])
          : Descrition(id: '', descricao: ''), // Con
      razaoSocial: json['razaoSocial']?.toString() ??
          '', // Converte para String ou usa string vazia se for null
      sigla: json['sigla']?.toString() ??
          '', // Converte para String ou usa string vazia se for null
      nomeFantasia: json['nomeFantasia']?.toString() ??
          '', // Converte para String ou usa string vazia se for null
      documento: json['documento']?.toString() ??
          '', // Converte para String ou usa string vazia se for null
    );
  }*/

  Map<String, dynamic> toJson() {
    return {
      'razaoSocial': razaoSocial,
      'sigla': sigla,
      'nomeFantasia': nomeFantasia,
      'documento': documento,
      'id': id,
      'descritionDto': descritionDto.toJson(),
    };
  }

  // metodo empty para criar um objeto vazio
  static IgrejaModels empty() {
    return IgrejaModels(
      id: '',
      descritionDto: Descrition(id: '', descricao: ''),
      razaoSocial: '',
      sigla: '',
      nomeFantasia: '',
      documento: '',
    );
  }
}
