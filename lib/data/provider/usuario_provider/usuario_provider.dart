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
        await prefs.setString('token', "Bearer ${data['accessToken']}");
        await prefs.setString('username', data["user"]['fullname'] ?? '');
        await prefs.setString('userPhoto', data['profilePicture'] ?? '');
        return true;
      }
      return false;
    } catch (e) {
      print("Erro ao logar: $e");
      return false;
    }
  }
}
