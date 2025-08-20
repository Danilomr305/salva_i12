import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:i12mobile/views/widgets/field_form_button.dart';
import 'package:provider/provider.dart';

import '../../../data/provider/escada_do_sucesso_provider/ecd_provider.dart';
import '../../../domain/core/themes/containers_all_estilo.dart';
import '../../../domain/core/themes/global_colors.dart';

class EcdView extends StatefulWidget {
  const EcdView({super.key});

  @override
  State<EcdView> createState() => _EcdViewState();
}

class _EcdViewState extends State<EcdView> {
  String title = 'View Ecd';

  TextEditingController controllerIgreja = TextEditingController();
  TextEditingController controllerDescricao = TextEditingController();
  TextEditingController controllerModulo = TextEditingController();
  TextEditingController controllerDataInicio = TextEditingController();
  TextEditingController controllerDataConclusao = TextEditingController();
  TextEditingController controllerTotalAlunos = TextEditingController();
  TextEditingController controllerLocalAula = TextEditingController();
  TextEditingController controllerId = TextEditingController();
  TextEditingController controllerDescritionDto = TextEditingController();
  @override
  Widget build(BuildContext context) {
    EcdProvider ecdProvider = Provider.of<EcdProvider>(context);

    int? index;

    if (ecdProvider.indexecdModel != null) {
      controllerLocalAula.text = ecdProvider.ecdModelSelected!.localAula;
      controllerModulo.text = ecdProvider.ecdModelSelected!.modulo.descricao;
      controllerDataInicio.text = ecdProvider.ecdModelSelected!.dataInicio;
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
                  label: 'Local da Aula',
                  controllerButton: controllerLocalAula,
                ),
                const SizedBox(
                  height: 25,
                ),
                FieldFormButton(
                  label: 'Modulo',
                  controllerButton: controllerModulo,
                ),
                const SizedBox(
                  height: 25,
                ),
                FieldFormButton(
                  label: 'Data de Inicio',
                  controllerButton: controllerDataInicio,
                ),
                const SizedBox(
                  height: 50,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    TextButton(
                      onPressed: () {
                        context.push('/createEcd');
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
                        ecdProvider.indexecdModel = null;
                        ecdProvider.ecdModels.removeAt(index!);
                        context.push('/createEcd');
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
