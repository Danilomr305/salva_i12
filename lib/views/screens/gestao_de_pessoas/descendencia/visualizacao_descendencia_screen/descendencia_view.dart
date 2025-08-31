// ignore_for_file: unnecessary_this

import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:i12mobile/data/provider/cadastros_provides/descendencia_provider.dart';
import 'package:i12mobile/domain/core/themes/containers_all_estilo.dart';
import 'package:i12mobile/domain/core/themes/global_colors.dart';
import 'package:provider/provider.dart';

import '../../../../widgets/field_form_button.dart';

class DescendenciaView extends StatefulWidget {
  const DescendenciaView({super.key});

  @override
  State<DescendenciaView> createState() => _DescendenciaViewState();
}

class _DescendenciaViewState extends State<DescendenciaView> {
  String title = 'Show Desc';

  TextEditingController controllerDescricao = TextEditingController();

  TextEditingController controllerSiglas = TextEditingController();

  @override
  Widget build(BuildContext context) {
    //DescendenciaProvider descendenciaProvider = DescendenciaProvider.of(context) as DescendenciaProvider;
    DescendenciaProvider descendenciaProvider =
        Provider.of<DescendenciaProvider>(context);
    int? indexx;

    if (descendenciaProvider.indexDescendencia != null) {
      indexx = descendenciaProvider.indexDescendencia;
      controllerDescricao.text =
          descendenciaProvider.descendenciaSelected!.descricao;
      controllerSiglas.text = descendenciaProvider.descendenciaSelected!.sigla;
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
                FieldFormButton(
                    label: 'Descendência',
                    controllerButton: controllerDescricao),
                const SizedBox(
                  height: 25,
                ),
                FieldFormButton(
                    label: 'Sigla', controllerButton: controllerSiglas),
                const SizedBox(
                  height: 50,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    TextButton(
                      onPressed: () {
                        context.push('/createrDescendencia');
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
                        descendenciaProvider.indexDescendencia = null;
                        descendenciaProvider.descendencias.removeAt(indexx!);
                        context.pop('/createrDescendencia');
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
                ),
              ],
            ),
          ),
        ),
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
}
