import 'dart:convert';

import 'package:shared_preferences/shared_preferences.dart';
import 'package:flutter/material.dart';

import '../../../domain/models/model/usuario_model.dart';
import '../../repository/usuario_repository/usuario_repository.dart';

class UsuarioProvider extends ChangeNotifier {
  final UsuarioRepository _repositoryUsuario = UsuarioRepository();

  List<UsuarioModel> usuario = [];
  UsuarioModel? usuarioSeleted;
  int? indexUsuario;

  Future<String?> getTokenUsuario() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getString('token');
  }

  Future<bool> usuarioLogado(String password, String userName) async {
    try {
      final data = await _repositoryUsuario.usuarioLogin(userName, password);
      if (data != null) {
        final prefs = await SharedPreferences.getInstance();
        var igreja = data['user']['igreja'] ?? {};
        var roles = data['user']['roles'] ?? [];
        print('token recebido: Bearer ${data['accessToken']}');

        await prefs.setString('token', "Bearer ${data['accessToken']}");
        await prefs.setString('username', data["user"]['fullname'] ?? '');
        await prefs.setString('userEmail', data["user"]['email'] ?? '');
        await prefs.setString('userId', data["user"]['id'] ?? '');
        await prefs.setString('username', data["user"]['fullname'] ?? '');
        await prefs.setString('userData', jsonEncode(data['user']));
        await prefs.setString('igrejaId', jsonEncode(igreja['id'] ?? ''));
        await prefs.setString(
            'igrejaRazaoSocial', jsonEncode(igreja['razaoSocial'] ?? ''));
        await prefs.setStringList('userRoles', List<String>.from(roles));
        //await prefs.setString('igrejaSigla', jsonEncode(igreja['sigla'] ?? ''));
        //await prefs.setString('userPhoto', data['profilePicture'] ?? '');
        return true;
      }
      return false;
    } catch (e) {
      print("Erro ao logar: $e");
      return false;
    }
  }
}
