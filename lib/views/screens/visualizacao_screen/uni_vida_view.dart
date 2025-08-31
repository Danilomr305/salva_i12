import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:i12mobile/data/provider/escada_do_sucesso_provider/univida_provider.dart';
import 'package:i12mobile/views/widgets/field_form_button.dart';
import 'package:provider/provider.dart';

import '../../../domain/core/themes/containers_all_estilo.dart';
import '../../../domain/core/themes/global_colors.dart';

class UniVidaView extends StatefulWidget {
  const UniVidaView({super.key});

  @override
  State<UniVidaView> createState() => _UniVidaViewState();
}

class _UniVidaViewState extends State<UniVidaView> {
  String title = 'View Turma';

  TextEditingController controllerIgreja = TextEditingController();
  TextEditingController controllerDescricao = TextEditingController();
  TextEditingController controllerLicaoAtual = TextEditingController();
  TextEditingController controllerDataInicioTurma = TextEditingController();
  TextEditingController controllerDataEncerramentoTurma =
      TextEditingController();
  TextEditingController controllerTotalAlunos = TextEditingController();
  TextEditingController controllerLocalAula = TextEditingController();
  TextEditingController controllerId = TextEditingController();
  TextEditingController controllerDescritionDto = TextEditingController();

  @override
  Widget build(BuildContext context) {
    UniVidaProvider uniVidaProvider = Provider.of<UniVidaProvider>(context);

    int? index;

    if (uniVidaProvider.indexUniVida != null) {
      controllerLocalAula.text = uniVidaProvider.uniVidaSelected!.localAula;
      controllerDataInicioTurma.text =
          uniVidaProvider.uniVidaSelected!.dataInicio;

      setState(() {
        this.title = 'Edit Turma';
      });
    }

    return Scaffold(
      appBar: AppBar(
        iconTheme: const IconThemeData(color: Colors.white),
        backgroundColor: GlobalColor.AzulEscuroClaroColor,
        centerTitle: true,
        title: Text(this.title,
            style: const TextStyle(
                color: Colors.white,
                fontSize: 22,
                fontWeight: FontWeight.bold)),
      ),
      body: ContainerAll(
        child: Center(
          child: SingleChildScrollView(
            child: Column(
              children: [
                FieldFormButton(
                  label: 'Local da Aula',
                  controllerButton: controllerLocalAula,
                ),
                const SizedBox(
                  height: 25,
                ),
                FieldFormButton(
                  label: 'Dados de Inicio',
                  controllerButton: controllerDataInicioTurma,
                ),
                const SizedBox(
                  height: 50,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    TextButton(
                      onPressed: () {
                        context.push('/createrUniVida');
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
                        uniVidaProvider.indexUniVida = null;
                        uniVidaProvider.uniVidas.removeAt(index!);
                        context.push('/createrUniVida');
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
