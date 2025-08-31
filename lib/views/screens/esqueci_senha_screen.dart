import 'dart:async';
import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:http/http.dart' as http;
import 'package:i12mobile/domain/core/themes/global_colors.dart';

class EsqueciSenha extends StatefulWidget {
  const EsqueciSenha({super.key});

  @override
  State<EsqueciSenha> createState() => _EsqueciSenhaState();
}

class _EsqueciSenhaState extends State<EsqueciSenha> {
  final _emailController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: GlobalColor.backGroudPrincipal,
      appBar: AppBar(
        backgroundColor: GlobalColor.backGroudPrincipal,
        iconTheme: IconThemeData(color: Colors.white),
      ),
      body: Container(
        padding: EdgeInsets.only(top: 60, left: 25, right: 25),
        child: Center(
          child: ListView(
            children: [
              SizedBox(
                height: 150,
                child: Icon(
                  Icons.lock_reset_outlined,
                  color: Colors.white,
                  size: 80,
                ),
              ),
              Text("Esqueceu sua senha?",
                  style: TextStyle(
                      fontSize: 25,
                      fontWeight: FontWeight.w500,
                      color: Colors.white),
                  textAlign: TextAlign.center),
              SizedBox(
                height: 10,
              ),
              Text(
                "Por favor, informe o E-mail associado a sua conta que enviaremos um link para o mesmo com as instruções para restauração de sua senha.",
                style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.w400,
                    color: Colors.white),
                textAlign: TextAlign.center,
              ),
              SizedBox(
                height: 40,
              ),
              TextFormField(
                controller: _emailController,
                keyboardType: TextInputType.emailAddress,
                decoration: InputDecoration(
                    focusColor: Colors.white,
                    fillColor: Colors.white,
                    border: UnderlineInputBorder(
                      borderSide: BorderSide(
                          width: 4,
                          color: Colors.white,
                          style: BorderStyle.none), // Cor da linha inferior
                    ),
                    labelText: "E-mail",
                    labelStyle: TextStyle(
                        color: Colors.white,
                        fontWeight: FontWeight.w400,
                        fontSize: 16)),
                style: TextStyle(fontSize: 18),
              ),
              SizedBox(
                height: 20,
              ),
              SizedBox(
                width: 30,
                child: ElevatedButton(
                    onPressed: () async {
                      // Mostra um indicador de carregamento, se quiser
                      showDialog(
                        context: context,
                        barrierDismissible: false,
                        builder: (context) => Center(
                            child: CircularProgressIndicator(
                          color: Colors.white,
                        )),
                      );

                      String resultado = await esqueciSenha();

                      // Fecha o dialog de carregamento
                      Navigator.of(context).pop();

                      // Mostra a mensagem
                      ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(content: Text(resultado)),
                      );

                      // Aguarda um pouco antes de sair, para o usuário ver a mensagem
                      await Future.delayed(Duration(seconds: 2));
                      context.pop();
                    },
                    child: Text("Enviar")),
              )
            ],
          ),
        ),
      ),
    );
  }

  Future<String> esqueciSenha() async {
    var url =
        Uri.parse('https://ws-security.logos.seg.br/login/forgot-password');
    final headers = {"Content-Type": "application/json"};
    final body = json.encode({
      "email": _emailController.text,
    });

    try {
      final response = await http
          .post(url, headers: headers, body: body)
          .timeout(const Duration(seconds: 20));

      final isSuccess = response.statusCode == 200 &&
          response.body.trim().toLowerCase() == 'true';

      return isSuccess
          ? 'Solicitação enviada. Verifique seu e-mail.'
          : 'Erro ao solicitar redefinição de senha.';
    } on TimeoutException {
      return 'Tempo de resposta esgotado. Tente novamente mais tarde.';
    } on Exception {
      return 'Solicitação enviada. Verifique seu e-mail.'; // Assume sucesso leve
    } catch (_) {
      return 'Erro ao solicitar redefinição de senha.';
    }
  }
}
