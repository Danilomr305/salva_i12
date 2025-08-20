import 'package:flutter/material.dart';
import 'package:i12mobile/domain/core/themes/global_colors.dart';
import 'package:i12mobile/views/screens/eventos_screen.dart';
import 'package:i12mobile/views/screens/home/home_screen.dart';
import 'package:i12mobile/views/screens/perfil_screen.dart';
import 'package:i12mobile/domain/core/gnav_navigator.dart';

class HomeLib extends StatefulWidget {
  const HomeLib({super.key});

  @override
  State<HomeLib> createState() => _HomeLibState();
}

class _HomeLibState extends State<HomeLib> {
  int paginaAtual = 0;

  void setPaginaAtual(pagina) {
    setState(() {
      paginaAtual = pagina;
    });
  }

  final List<Widget> _pages = [
    const HomeScreen(),
    const EventosScreen(),
    const PerfilScreen(),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: GlobalColor.buttonsColors,
      body: _pages[paginaAtual],
      bottomNavigationBar: SafeArea(
        child: MyBottomGnavBar(
          onTabChange: (index) => setPaginaAtual(index),
        ),
      ),
    );
  }
}
