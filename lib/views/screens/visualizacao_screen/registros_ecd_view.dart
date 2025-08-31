// ignore_for_file: unused_local_variable

import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:i12mobile/domain/core/themes/containers_all_estilo.dart';
import 'package:i12mobile/data/provider/escada_do_sucesso_provider/registros_aulas_providers/registros_aula_ecd_provider.dart';
import 'package:provider/provider.dart';

import '../../../domain/core/themes/global_colors.dart';
import '../../widgets/field_form_button.dart';

class RegistrosEcdView extends StatefulWidget {
  const RegistrosEcdView({super.key});

  @override
  State<RegistrosEcdView> createState() => _RegistrosEcdViewState();
}

class _RegistrosEcdViewState extends State<RegistrosEcdView> {
  String title = 'Novo Registro';

  TextEditingController controllerEscola = TextEditingController();
  TextEditingController controllerLicao = TextEditingController();
  TextEditingController controllerAulaTipo = TextEditingController();
  TextEditingController controllerProfessor = TextEditingController();
  //TextEditingController controllerAluno = TextEditingController();
  TextEditingController controllerId = TextEditingController();
  TextEditingController controllerDescritionDto = TextEditingController();
  TextEditingController controllerDataAula = TextEditingController();

  @override
  Widget build(BuildContext context) {
    int? index;

    RegistroAulaEcdProvider registroAulaEcdProvider =
        Provider.of<RegistroAulaEcdProvider>(context);
    if (registroAulaEcdProvider.indexRegistrosEcd != null) {
      index = registroAulaEcdProvider.indexRegistrosEcd;
      controllerAulaTipo.text =
          registroAulaEcdProvider.registrosEcdSelected!.aulaTipo.descricao;
      controllerLicao.text =
          registroAulaEcdProvider.registrosEcdSelected!.licao.descricao;
      controllerProfessor.text =
          registroAulaEcdProvider.registrosEcdSelected!.professor.nome;
    }
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        iconTheme: const IconThemeData(color: Colors.white),
        backgroundColor: GlobalColor.AzulEscuroClaroColor,
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
                FieldFormButton(
                    label: 'Lição', controllerButton: controllerLicao),
                const SizedBox(
                  height: 25,
                ),
                FieldFormButton(
                    label: 'Tipo de Aula',
                    controllerButton: controllerAulaTipo),
                const SizedBox(
                  height: 25,
                ),
                FieldFormButton(
                    label: 'Professor', controllerButton: controllerProfessor),
                const SizedBox(
                  height: 25,
                ),
                FieldFormButton(
                    label: 'Data Aula', controllerButton: controllerDataAula),
                const SizedBox(
                  height: 50,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    TextButton(
                      onPressed: () {
                        context.push('/createrRegistroEcd');
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
                        context.push('/createrRegistroEcd');
                      },
                      style: ButtonStyle(
                          backgroundColor: WidgetStatePropertyAll(
                              GlobalColor.AzulEscuroClaroColor)),
                      child: const Text(
                        'Deleter',
                        style: TextStyle(
                            fontWeight: FontWeight.bold,
                            color: Colors.white,
                            fontSize: 19),
                      ),
                    )
                  ],
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
