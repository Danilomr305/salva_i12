import 'package:i12mobile/domain/models/model/base_model.dart';
import 'package:i12mobile/domain/models/model/igreja.dart';

import '../shared/descrition_model.dart';

class UsuarioModel extends BaseModel {
  final String fullName;
  final String userName;
  final String email;
  final String password;
  final IgrejaModels igreja;

  UsuarioModel(
      {required super.id,
      required super.descritionDto,
      required this.fullName,
      required this.userName,
      required this.email,
      required this.password,
      required this.igreja});

  factory UsuarioModel.fromJson(Map<String, dynamic> json) {
    return UsuarioModel(
      igreja: json['igreja'] != null
          ? IgrejaModels.fromJson(json['igreja'])
          : IgrejaModels(
              razaoSocial: '', sigla: '', nomeFantasia: '', documento: ''),
      descritionDto: json['descritionDto'],
      /* != null
          ? Descrition(json['descritionDto'],
              id: '', descricao: '') // Convertendo a String em Descrition
          : Descrition('',
              descricao: '', id: ''),*/
      id: json['id'] ?? '',
      fullName: json['fullName'] ?? '', // Se for null, usa string vazia
      userName: json['userName'] ?? '', // Se for null, usa string vazia
      email: json['email'] ?? '', // Se for null, usa string vazia
      password: json['password'] ?? '', // Se for null, usa string vazia
    );
  }

  // Converter UsuarioModel para Json
  Map<String, dynamic> toJson() {
    return {
      'descritionDto': descritionDto,
      'id': id,
      'igreja': igreja,
      'fullName': fullName,
      'userName': userName,
      'email': email,
      'password': password
    };
  }
}
