import 'package:i12mobile/domain/models/model/base_model.dart';

import 'descrition_model.dart';

class Endereco extends BaseModel {
  final String logradouro;
  final String numero;
  final String bairro;
  final String cidade;
  final String uf;
  final String cep;

  Endereco(
      {required super.id,
      required super.descritionDto,
      required this.logradouro,
      required this.numero,
      required this.cidade,
      required this.uf,
      required this.cep,
      required this.bairro});

  factory Endereco.fromJson(Map<String, dynamic> json) {
    print('Dados do endereço recebidos: $json');
    return Endereco(
      descritionDto: json['descritionDto'] != null
          ? Descrition.fromJson(json['descritionDto'])
          : Descrition(id: '', descricao: ''),
      id: json['id'] ?? '',
      logradouro: json['logradouro'] ?? '',
      numero: json['numero'] ?? '',
      cidade: json['cidade'] ?? '',
      uf: json['uf'] ?? '',
      cep: json['cep'] ?? '',
      bairro: json['bairro'] ?? '',
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'descritionDto': descritionDto,
      'id': id,
      'logradouro': logradouro,
      'numero': numero,
      'cidade': cidade,
      'uf': uf,
      'cep': cep,
      'bairro': bairro
    };
  }

  // Método para criar um objeto Endereco vazio
  static Endereco empty() {
    return Endereco(
      id: '',
      descritionDto: Descrition(id: '', descricao: ''),
      logradouro: '',
      numero: '',
      cidade: '',
      uf: '',
      cep: '',
      bairro: '',
    );
  }
}
