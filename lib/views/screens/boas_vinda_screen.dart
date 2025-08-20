/*import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:i12mobile/core/themes/global_colors.dart';
import 'package:shared_preferences/shared_preferences.dart';

class BoasVindasPage extends StatefulWidget {
  const BoasVindasPage({super.key});

  @override
  State<BoasVindasPage> createState() => _BoasVindasPageState();
}

class _BoasVindasPageState extends State<BoasVindasPage> {
  final Duration duration = const Duration(seconds: 4);

  @override
  void initState() {
    super.initState();
    Future.delayed(duration, () {
      verificarToken().then((value) {
        if (value) {
          context.push('/homeLib');
        } else {
          context.push('/login');
        }
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: GlobalColor.AzulEscuroColor,
      body: Center(
        child: Image.asset('assets/gif/church_animation.gif'),
      ),
    );
  }

  Future<bool> verificarToken() async {
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    if (sharedPreferences.getString('token') != null) {
      return true;
    } else {
      return false;
    }
  }
}*/

import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:i12mobile/domain/core/themes/global_colors.dart';

class BoasVindasPage extends StatefulWidget {
  const BoasVindasPage({super.key});

  @override
  State<BoasVindasPage> createState() => _BoasVindasPageState();
}

class _BoasVindasPageState extends State<BoasVindasPage> {
  @override
  void initState() {
    super.initState();
    _navegarComDelay();
  }

  Future<void> _navegarComDelay() async {
    await Future.delayed(const Duration(seconds: 4));
    final possuiToken = await _temTokenSalvo();

    if (!mounted) return;

    // Redireciona com base no token
    if (possuiToken) {
      context.go('/homeLib');
    } else {
      context.go('/login');
    }
  }

  Future<bool> _temTokenSalvo() async {
    final prefs = await SharedPreferences.getInstance();
    final token = prefs.getString('token');
    return token != null && token.isNotEmpty;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: GlobalColor.AzulEscuroColor,
      body: const Center(
        child: Image(
          image: AssetImage('assets/gif/church_animation.gif'),
        ),
      ),
    );
  }
}
