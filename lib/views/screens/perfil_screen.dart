// ignore_for_file: use_build_context_synchronously, library_private_types_in_public_api, unused_import, avoid_print

import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:url_launcher/url_launcher.dart';

import '../../domain/core/themes/global_colors.dart';
import 'boas_vinda_screen.dart';
import 'notificacoes_screen.dart';
import '../widgets/menu_widgets.dart';

class PerfilScreen extends StatefulWidget {
  const PerfilScreen({super.key});

  @override
  _PerfilScreenState createState() => _PerfilScreenState();
}

class _PerfilScreenState extends State<PerfilScreen> {
  String? userEmail;
  String? userName;
  String? userPhoto;

  @override
  void initState() {
    super.initState();
    //_loadUserEmail();
    _loadUserInfo();
  }

  // Retorna todas as informanções para pode implimenta em alguma função se necessario
  Future<void> _loadUserInfo() async {
    final prefs = await SharedPreferences.getInstance();
    setState(() {
      userEmail = prefs.getString('userEmail');
      userName = prefs.getString('username');
      userPhoto = prefs.getString('userPhoto');
    });
  }

  // Responsavel para retornar para tela de login
  void _logout(BuildContext context) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        backgroundColor: Colors.blue,
        title: const Text('Confirmação', style: TextStyle(color: Colors.black)),
        content: const Text('Você tem certeza que deseja sair?',
            style: TextStyle(color: Colors.red)),
        actions: [
          TextButton(
            onPressed: () => Navigator.of(context).pop(),
            child:
                const Text('Cancelar', style: TextStyle(color: Colors.white)),
          ),
          TextButton(
            onPressed: () async {
              final prefs = await SharedPreferences.getInstance();
              await prefs.clear();
              Navigator.of(context).pop();
              context.go('/boasVindas');
            },
            child: const Text('Confirmar', style: TextStyle(color: Colors.red)),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: GlobalColor.backGroudPrincipal,
        appBar: AppBar(
          automaticallyImplyLeading: false,
          backgroundColor: GlobalColor.backGroudPrincipal,
          centerTitle: true,
          title: const Text(
            'Perfil',
            style: TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 22,
                letterSpacing: 1,
                color: Colors.white),
          ),
        ),
        body: Container(
          alignment: AlignmentDirectional.center,
          padding: const EdgeInsets.all(15),
          child: Column(
            children: [
              const SizedBox(height: 10),
              SizedBox(
                width: 90,
                height: 90,
                child: ClipRRect(
                    borderRadius: BorderRadius.circular(100),
                    child: CircleAvatar(
                      backgroundColor: Colors.white,
                      child: const Icon(
                        Icons.person,
                        size: 50,
                        color: Colors.grey,
                      ),
                    )),
              ),
              const SizedBox(
                height: 10,
              ),
              Text(
                '$userName',
                style: const TextStyle(fontWeight: FontWeight.bold),
              ),
              const SizedBox(
                height: 10,
              ),
              const SizedBox(
                height: 20,
              ),
              const Divider(),
              const SizedBox(
                height: 20,
              ),
              PerfilMenuWidget(
                title: 'Configurações',
                icon: Icons.settings,
                onPress: () {},
                buttonIcon: Icons.chevron_right_outlined,
              ),
              const SizedBox(
                height: 40,
              ),
              const SizedBox(
                height: 80,
              ),
              SizedBox(
                width: 130,
                child: ElevatedButton(
                  style: ButtonStyle(
                      backgroundColor:
                          WidgetStatePropertyAll(GlobalColor.AzulEscuroColor)),
                  onPressed: () async {
                    _logout(context);
                  },
                  child: const Row(
                    children: [
                      Icon(
                        Icons.logout_outlined,
                        color: Colors.white,
                      ),
                      SizedBox(
                        width: 5,
                      ),
                      Text(
                        'Logout',
                        style: TextStyle(
                            color: Colors.white,
                            fontWeight: FontWeight.bold,
                            fontSize: 15),
                      ),
                    ],
                  ),
                ),
              ),
              const SizedBox(
                height: 30,
              ),
              const Text(
                'Termos e Politica de Privacidade',
                style: TextStyle(fontSize: 10, letterSpacing: 0.5),
              )
            ],
          ),
        ));
  }
}
