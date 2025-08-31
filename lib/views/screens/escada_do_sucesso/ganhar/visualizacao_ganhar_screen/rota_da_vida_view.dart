// ignore_for_file: unused_local_variable, unnecessary_this

import 'package:flutter/material.dart';
import 'package:i12mobile/domain/core/themes/containers_all_estilo.dart';
import 'package:i12mobile/domain/core/themes/global_colors.dart';
import 'package:i12mobile/views/widgets/field_form_button.dart';
import 'package:provider/provider.dart';

import '../../../../../data/provider/escada_do_sucesso_provider/ganhar/rota_da_vida_provider.dart';

class RotaDaVidaView extends StatefulWidget {
  const RotaDaVidaView({super.key});

  @override
  State<RotaDaVidaView> createState() => _RotaDaVidaViewState();
}

class _RotaDaVidaViewState extends State<RotaDaVidaView> {
  String title = 'Show Rota Da Vida';

  TextEditingController controllerPessoa = TextEditingController();
  TextEditingController controllerEstaEmCelula = TextEditingController();
  TextEditingController controllerDataInscricaoUniVida =
      TextEditingController();

  @override
  Widget build(BuildContext context) {
    //RotaDaVidaProvider rotaDaVidaProvider = RotaDaVidaProvider.of(context) as RotaDaVidaProvider;
    RotaDaVidaProvider rotaDaVidaProvider =
        Provider.of<RotaDaVidaProvider>(context);

    int? index;

    if (rotaDaVidaProvider.indexRotas != null) {
      index = rotaDaVidaProvider.indexRotas;
      controllerPessoa.text = rotaDaVidaProvider.rotasSelected!.pessoa.nome;
      controllerEstaEmCelula.text =
          rotaDaVidaProvider.rotasSelected!.estaEmCelula;
      controllerDataInscricaoUniVida.text =
          rotaDaVidaProvider.rotasSelected!.dataInscricaoUniVida;
    }

    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text(this.title),
      ),
      body: ContainerAll(
        child: Center(
          child: SingleChildScrollView(
            child: Column(
              children: [
                FieldFormButton(
                  label: 'Nome',
                  controllerButton: controllerPessoa,
                ),
                const SizedBox(
                  height: 25,
                ),
                FieldFormButton(
                  label: 'Inscrição Uni Vida',
                  controllerButton: controllerDataInscricaoUniVida,
                ),
                const SizedBox(
                  height: 25,
                ),
                FieldFormButton(
                  label: 'Esta em Celula',
                  controllerButton: controllerEstaEmCelula,
                ),
                const SizedBox(
                  height: 50,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    TextButton(
                      onPressed: () {
                        Navigator.popAndPushNamed(context, '/createrRota');
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
                        rotaDaVidaProvider.indexRotas = null;
                        rotaDaVidaProvider.rotas.removeAt(index!);
                        Navigator.popAndPushNamed(context, '/createrRota');
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
