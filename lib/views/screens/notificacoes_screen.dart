import 'package:flutter/material.dart';

import '../../domain/core/themes/global_colors.dart';

class NotificacoesPage extends StatefulWidget {
  const NotificacoesPage({super.key});

  @override
  State<NotificacoesPage> createState() => _NotificacoesPageState();
}

class _NotificacoesPageState extends State<NotificacoesPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
          elevation: 0,
          centerTitle: true,
          backgroundColor: GlobalColor.AzulEscuroClaroColor,
          iconTheme: const IconThemeData(color: Colors.white),
          title: const Text('NOTIFICAÕES',
              style: TextStyle(
                  fontSize: 22,
                  fontWeight: FontWeight.bold,
                  color: Colors.white))),
    );
  }
}
