import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:i12mobile/views/widgets/custom_text_form__login_widgets.dart';
import 'package:provider/provider.dart';
import '../../../data/provider/usuario_provider/usuario_provider.dart'
    show UsuarioProvider;
import '../../../domain/core/themes/global_colors.dart' show GlobalColor;

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final _formKey = GlobalKey<FormState>();
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();

  // Reponsavel para deixar ou não a senha do usuario visivel
  bool _obscurePassword = true;

  // Responsavel para retorna uma prever mensagem dizendo que email ee senha estão com os campos errados
  final _snackBar = const SnackBar(
    content: Text(
      'E-mail ou senha são inválidos!',
      textAlign: TextAlign.center,
    ),
    backgroundColor: Colors.redAccent,
  );

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: GlobalColor.backGroudPrincipal,
      body: Padding(
        padding: const EdgeInsets.all(25),
        child: Center(
          child: SingleChildScrollView(
            child: Form(
              key: _formKey,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Container(
                    alignment: Alignment.center,
                    child: Image.asset(
                      'assets/images/logo_i12.png',
                      height: 200,
                    ),
                  ),
                  CustomTextFormLogin(
                    controller: _emailController,
                    label: 'login',
                    obscureText: false,
                    hitText: 'Ex: ibnnf@gmail.com',
                    validator: (email) {
                      if (email == null || email.isEmpty) {
                        return 'Por favor, digite seu email \nou nome de usuario!';
                      }
                      return null;
                    },
                  ),
                  const SizedBox(height: 30),
                  CustomTextFormLogin(
                    controller: _passwordController,
                    label: 'Senha',
                    obscureText: _obscurePassword,
                    hitText: 'Ex: senha mínima de 3 digitos!',
                    validator: (senha) {
                      if (senha == null || senha.isEmpty) {
                        return 'Por favor, digite sua senha!';
                      }
                      return null;
                    },
                    suffixIconWidget: IconButton(
                        onPressed: () {
                          setState(() {
                            _obscurePassword = !_obscurePassword;
                          });
                        },
                        icon: Icon(
                          _obscurePassword
                              ? Icons.visibility_off_outlined
                              : Icons.visibility_outlined,
                          color: GlobalColor.backGroudPrincipal,
                        )),
                  ),
                  const SizedBox(
                    height: 50,
                  ),
                  Center(
                      child: SizedBox(
                    width: 300,
                    height: 60,
                    child: ElevatedButton(
                        style: ButtonStyle(
                            backgroundColor: WidgetStatePropertyAll(
                                GlobalColor.buttonsColors)),
                        onPressed: _loginPressed,
                        child: Text(
                          'Entrar',
                          style: TextStyle(
                              fontWeight: FontWeight.bold,
                              color: GlobalColor.iconsColors),
                        )),
                  )),
                  SizedBox(
                    height: 20,
                  ),
                  Center(
                    child: TextButton(
                        onPressed: () => context.push('/esqueciSenha'),
                        child: Text(
                          'Esqueci minha senha',
                          style: TextStyle(color: Colors.white),
                        )),
                  )
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  /* 
    Função responsavel para sabe se o usuario e senha estão correta para fazer 
    login ou se os campos estão invalidos.
  */
  Future<void> _loginPressed() async {
    final currentFocus = FocusScope.of(context);
    final usuarioProvider =
        Provider.of<UsuarioProvider>(context, listen: false);

    if (_formKey.currentState!.validate()) {
      _showLoading();

      final sucesso = await usuarioProvider.usuarioLogado(
          _passwordController.text, _emailController.text);

      Navigator.of(context).pop(); // fecha loading

      if (!currentFocus.hasPrimaryFocus) {
        currentFocus.unfocus();
      }

      if (sucesso) {
        context.push('/homeLib');
      } else {
        ScaffoldMessenger.of(context).showSnackBar(_snackBar);
      }
    }
  }

  // Função responsavel por cuida da animação do circulo ao digita senha ou email.
  void _showLoading() {
    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (_) => const Center(
        child: CircularProgressIndicator(color: Colors.white),
      ),
    );
  }
}
