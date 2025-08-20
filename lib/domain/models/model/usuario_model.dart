import 'package:i12mobile/domain/models/model/base_model.dart';
import 'package:i12mobile/domain/models/model/igreja.dart';

import '../shared/descrition_model.dart';

class UsuarioModel extends BaseModel {
  final String fullname;
  final String username;
  final String email;
  final String password;
  final IgrejaModels igreja;
  List<String> roles = [];

  UsuarioModel(
      {required super.id,
      required super.descritionDto,
      required this.fullname,
      required this.username,
      required this.email,
      required this.roles,
      required this.password,
      required this.igreja});

  factory UsuarioModel.fromJson(Map<String, dynamic> json) {
    return UsuarioModel(
      igreja: json['igreja'] != null
          ? IgrejaModels.fromJson(json['igreja'])
          : IgrejaModels(
              razaoSocial: '',
              sigla: '',
              nomeFantasia: '',
              documento: '',
              id: '',
              descritionDto: Descrition(id: '', descricao: '')),
      descritionDto: json['descritionDto'],
      roles: List<String>.from(json['roles'] as List),
      id: json['id'] ?? '',
      fullname: json['fullName'] ?? '', // Se for null, usa string vazia
      username: json['userName'] ?? '', // Se for null, usa string vazia
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
      'fullname': fullname,
      'username': username,
      'email': email,
      'password': password,
      'roles': roles,
    };
  }
}
