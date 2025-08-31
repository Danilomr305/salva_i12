import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:i12mobile/views/screens/home/cards_screen.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../../../domain/core/themes/global_colors.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  String? userEmail;
  String? userName;
  String? userPhoto;
  String? userId;
  String? IgrejaId;
  String? IgrejaRazaoSocial;
  List<String> userRoles = [];

  @override
  void initState() {
    super.initState();
    //_loadUserEmail();
    _loadUserInfo();
  }

  Future<void> _loadUserInfo() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();

    setState(() {
      userEmail = prefs.getString('userEmail');
      userName = prefs.getString('username');
      userPhoto = prefs.getString('userPhoto');
      userId = prefs.getString('userId');
      IgrejaId = prefs.getString('igrejaId');
      IgrejaRazaoSocial = prefs.getString('igrejaRazaoSocial');
      userRoles = prefs.getStringList('userRoles') ?? [];

      // Adicione prints para verificar se os valores estão sendo carregados corretamente
      print('Email: $userEmail');
      print('Nome: $userName');
      print('Foto: $userPhoto');
      print('UserId: $userId');
      print('IgrejaId: $IgrejaId');
      print('IgrejaRazaoSocial: $IgrejaRazaoSocial');
      print('UserRoles: $userRoles');
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: GlobalColor.backGroudPrincipal,
      appBar: AppBar(
        automaticallyImplyLeading: false,
        elevation: 0,

        backgroundColor: GlobalColor.backGroudPrincipal,
        iconTheme: const IconThemeData(color: Colors.white),
        leading: SizedBox(
          height: 10,
          width: 10,
          child: Image.asset(
            'assets/images/logo_i12.png',
            height: 10,
            width: 20,
          ),
        ),
        title: Text(
          'I12',
          style: TextStyle(
              fontWeight: FontWeight.bold, fontSize: 25, color: Colors.white),
        ),
        actions: [
          Row(
            children: [
              IconButton(
                  onPressed: () {
                    context.push('/notification');
                  },
                  icon: const Icon(
                    Icons.notification_important_outlined,
                    color: Colors.white,
                    size: 25,
                  )),
              IconButton(
                  onPressed: () {
                    context.push('/perfil');
                  },
                  icon: const Icon(
                    Icons.person,
                    color: Colors.white,
                    size: 25,
                  )),
            ],
          )
        ],
        titleSpacing: 0.0, // Tente novamente com 0.0
      ),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Padding(
              padding: const EdgeInsets.all(16),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  SizedBox(
                    child: Text(
                      "Olá, " + "$userName!  " + "👋",
                      style: TextStyle(
                        fontSize: 20,
                        fontFamily: 'Pacifico',
                        //fontWeight: FontWeight.bold,
                        color: Colors.white,
                      ),
                      overflow: TextOverflow.ellipsis,
                    ),
                  ),
                  //SizedBox(width: 10),
                  // Logo da aplicação (você não incluiu o widget aqui)
                ],
              ),
            ),
            CardsScreen()
          ],
        ),
      ),
    );
  }
}
