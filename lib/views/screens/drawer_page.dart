// ignore_for_file: use_build_context_synchronously

import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:i12mobile/views/screens/escada_do_sucesso_drawer_screen.dart';

import 'package:i12mobile/domain/core/themes/global_colors.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'cadastros_drawer_screen.dart';

class DrawerPage extends StatefulWidget {
  const DrawerPage({super.key});

  @override
  State<DrawerPage> createState() => _DrawerPageState();
}

class _DrawerPageState extends State<DrawerPage> {
  @override
  Widget build(BuildContext context) {
    return Drawer(
        backgroundColor: GlobalColor.AzulEscuroColor,
        child: ListView(
          padding: EdgeInsets.zero,
          children: [
            DrawerHeader(
                child: Container(
              alignment: Alignment.centerLeft,
              decoration: const BoxDecoration(
                shape: BoxShape.circle,
              ),
              child: Image.asset('assets/images/logo_i12.jpg'),
            )),
            Container(
              padding: const EdgeInsets.all(5),
              child: const Text(
                'CADASTROS',
                style:
                    TextStyle(color: Colors.grey, fontWeight: FontWeight.bold),
              ),
            ),
            const CadastrosDrawer(),
            const SizedBox(
              height: 15,
            ),
            Container(
              padding: const EdgeInsets.all(5),
              child: const Text(
                'ESCADA DO SUCESSO',
                style:
                    TextStyle(color: Colors.grey, fontWeight: FontWeight.bold),
              ),
            ),
            const EscadaDoSucessoDrawer(),
            Container(
              padding: const EdgeInsets.only(top: 40, left: 80, right: 80),
              child: ElevatedButton(
                  onPressed: () async {
                    _logout(context);
                  },
                  child: const Row(
                    children: [
                      Icon(
                        Icons.logout_outlined,
                        color: Colors.black,
                      ),
                      SizedBox(
                        width: 5,
                      ),
                      Text(
                        'Logout',
                        style: TextStyle(
                            color: Colors.black,
                            fontWeight: FontWeight.bold,
                            fontSize: 15),
                      ),
                    ],
                  )),
            ),
          ],
        ));
  }

  /*Future<bool> sair() async {
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    await sharedPreferences.clear();
    return true;
  }*/

  void _logout(BuildContext context) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          backgroundColor: Colors.blue,
          title: Text(
            'Confirmação',
            style: TextStyle(color: Colors.black),
          ),
          content: Text('Você tem certeza que deseja sair?',
              style: TextStyle(color: Colors.red)),
          actions: <Widget>[
            // Botão de Cancelar
            TextButton(
              onPressed: () {
                Navigator.of(context).pop(); // Fecha o diálogo
              },
              child: Text('Cancelar', style: TextStyle(color: Colors.white)),
            ),
            // Botão de Confirmar
            TextButton(
                onPressed: () async {
                  SharedPreferences sharedPreferences =
                      await SharedPreferences.getInstance();
                  await sharedPreferences.clear();

                  // Fecha o diálogo
                  Navigator.of(context).pop();

                  // Redireciona via GoRouter
                  context.go('/boasVindas');
                },
                child: const Text(
                  'Confirmar',
                  style: TextStyle(color: Colors.red),
                )),
          ],
        );
      },
    );
  }
}
