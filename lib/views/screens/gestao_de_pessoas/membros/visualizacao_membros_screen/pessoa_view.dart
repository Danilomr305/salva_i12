// ignore_for_file: camel_case_types, must_be_immutable, unnecessary_this

import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:i12mobile/domain/core/themes/global_colors.dart';
import 'package:provider/provider.dart';
import '../../../../../data/provider/gestao_de_pessoas_providers/pessoas_provider.dart';
import '../../../../../domain/core/themes/containers_all_estilo.dart';
import '../../../../widgets/field_form.dart';

class PessoaView extends StatefulWidget {
  const PessoaView({super.key});

  @override
  State<PessoaView> createState() => _PessoaViewState();
}

class _PessoaViewState extends State<PessoaView> {
  String title = 'Show Pessoa';

  TextEditingController controllerName = TextEditingController();

  TextEditingController controllerDescendencia = TextEditingController();

  TextEditingController controllerLider = TextEditingController();

  TextEditingController controllerSexo = TextEditingController();

  @override
  Widget build(BuildContext context) {
    //PessoaProvider pessoaProvider = PessoaProvider.of(context) as PessoaProvider;
    PessoaProvider pessoaProvider = Provider.of<PessoaProvider>(context);

    int? index;

    if (pessoaProvider.indexPessoa != null) {
      index = pessoaProvider.indexPessoa;
      controllerName.text = pessoaProvider.pessoaSelected!.nome;
      controllerDescendencia.text =
          corrigirTexto(pessoaProvider.pessoaSelected!.descendencia.descricao);
      controllerLider.text = pessoaProvider.pessoaSelected!.lider;
      controllerSexo.text = pessoaProvider.pessoaSelected!.sexo;
    }

    return Scaffold(
      appBar: AppBar(
        iconTheme: const IconThemeData(color: Colors.white),
        backgroundColor: GlobalColor.AzulEscuroClaroColor,
        centerTitle: true,
        title: Text(
          this.title,
          style: const TextStyle(
              color: Colors.white, fontSize: 22, fontWeight: FontWeight.bold),
        ),
      ),
      body: ContainerAll(
        child: Center(
            child: SingleChildScrollView(
          child: Column(
            children: [
              FieldForm(
                  isEmail: false,
                  label: 'Name',
                  isPassword: false,
                  controller: controllerName),
              const SizedBox(
                height: 25,
              ),
              FieldForm(
                  isEmail: true,
                  label: 'Descendência',
                  isPassword: false,
                  controller: controllerDescendencia),
              const SizedBox(
                height: 25,
              ),
              FieldForm(
                  isEmail: false,
                  label: 'Lider',
                  isPassword: false,
                  controller: controllerLider),
              const SizedBox(
                height: 25,
              ),
              FieldForm(
                  isEmail: false,
                  label: 'Sexo',
                  isPassword: false,
                  controller: controllerSexo),
              const SizedBox(
                height: 50,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  TextButton(
                    onPressed: () {
                      context.push('/createrPessoa');
                    },
                    style: ButtonStyle(
                        backgroundColor: WidgetStatePropertyAll(
                            GlobalColor.AzulEscuroClaroColor)),
                    child: const Text(
                      'Edit',
                      style: TextStyle(
                          fontWeight: FontWeight.bold,
                          color: Colors.white,
                          fontSize: 19),
                    ),
                  ),
                  const SizedBox(
                    width: 15,
                  ),
                  TextButton(
                    onPressed: () {
                      pessoaProvider.indexPessoa = null;
                      pessoaProvider.pessoas.removeAt(index!);
                      context.pop('/createrPessoa');
                    },
                    style: ButtonStyle(
                        backgroundColor: WidgetStatePropertyAll(
                            GlobalColor.AzulEscuroClaroColor)),
                    child: const Text('Deleter',
                        style: TextStyle(
                            fontWeight: FontWeight.bold,
                            color: Colors.white,
                            fontSize: 19)),
                  )
                ],
              )
            ],
          ),
        )),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          context.pop('/homeLib');
        },
        backgroundColor: GlobalColor.AzulEscuroColor,
        child: const Icon(
          Icons.home,
          size: 35,
          color: Colors.white,
        ),
      ),
    );
  }

  // Função de correção de texto com caracteres
  String corrigirTexto(String texto) {
    try {
      // Se a string estiver corrompida, tente corrigir a codificação
      return utf8.decode(texto.runes.toList());
    } catch (e) {
      return texto; // Retorna o texto original se não puder corrigir
    }
  }
}
