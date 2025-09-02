import 'package:i12mobile/domain/models/model/base_model.dart';

import 'descrition_model.dart';

class Endereco extends BaseModel {
  final String logradouro; //
  final String logradouroNumero;
  final String bairro; //
  final String cidade; //
  final String uf; //
  final String cep; //

  Endereco(
      {required super.id,
      required super.descritionDto,
      required this.logradouro,
      required this.logradouroNumero,
      required this.cidade,
      required this.uf,
      required this.cep,
      required this.bairro});

  // Método para criar um objeto Endereco a partir de um mapa JSON
  factory Endereco.fromJson(Map<String, dynamic> json) {
    print('Dados do endereço recebidos: $json');
    return Endereco(
      descritionDto: json['descritionDto'] != null
          ? Descrition.fromJson(json['descritionDto'])
          : Descrition(id: '', descricao: ''),
      id: json['id'] ?? '',
      logradouro: json['logradouro'] ?? '',
      logradouroNumero: json['logradouroNumero'] ?? '',
      cidade: json['cidade'] ?? '',
      uf: json['uf'] ?? '',
      cep: json['cep'] ?? '',
      bairro: json['bairro'] ?? '',
    );
  }

  // Método para converter o objeto Endereco em um mapa JSON
  Map<String, dynamic> toJson() {
    return {
      'descritionDto': descritionDto,
      'id': id,
      'logradouro': logradouro,
      'logradouroNumero': logradouroNumero,
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
      logradouroNumero: '',
      cidade: '',
      uf: '',
      cep: '',
      bairro: '',
    );
  }
}
