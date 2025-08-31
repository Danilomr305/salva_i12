// ignore_for_file: unnecessary_null_comparison, no_leading_underscores_for_local_identifiers, unnecessary_this

import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:i12mobile/data/provider/cadastros_provides/descendencia_provider.dart';
import 'package:i12mobile/domain/core/themes/containers_all_estilo.dart';
import 'package:provider/provider.dart';

import '../../../../../domain/models/model/descendencia.dart';
import '../../../../../domain/core/themes/global_colors.dart';
import '../../../../../domain/models/model/igreja.dart';
import '../../../../../domain/models/model/pessoas_models.dart';
import '../../../../../domain/models/shared/descrition_model.dart';
import '../../../../widgets/field_form_button.dart';

class DescendenciaForm extends StatefulWidget {
  const DescendenciaForm({super.key});

  @override
  State<DescendenciaForm> createState() => _DescendenciaFormState();
}

class _DescendenciaFormState extends State<DescendenciaForm> {
  String title = 'Descendência';

  TextEditingController controllerDescricao = TextEditingController();
  TextEditingController controllerSiglas = TextEditingController();
  TextEditingController controllerId = TextEditingController();
  TextEditingController controllerDescendencia = TextEditingController();

  @override
  Widget build(BuildContext context) {
    //DescendenciaProvider descendenciaProvider = DescendenciaProvider.of(context) as DescendenciaProvider;
    DescendenciaProvider descendenciaProvider =
        Provider.of<DescendenciaProvider>(context);
    int? index;

    if (descendenciaProvider.indexDescendencia != null) {
      index = descendenciaProvider.indexDescendencia;
      controllerDescricao.text =
          descendenciaProvider.descendenciaSelected!.descricao;
      controllerSiglas.text = descendenciaProvider.descendenciaSelected!.sigla;

      setState(() {
        this.title = 'Edit Desc';
      });
    }

    GlobalKey<FormState> _key = GlobalKey();

    void savedescendencia() {
      final isValidate = _key.currentState?.validate();

      if (isValidate == false) {
        return;
      }

      _key.currentState?.save();

      // instancia de classe user um nova descendência
      DescendenciaModels descendenciaModel = DescendenciaModels(
          lider1: PessoasModels.empty(),
          lider2: PessoasModels.empty(),
          descricao: controllerDescricao.text,
          sigla: controllerSiglas.text,
          id: controllerId.text,
          descritionDto: Descrition(
            id: controllerId.text,
            descricao: controllerDescendencia.text,
          ),
          igreja: IgrejaModels.empty());

      if (index != null) {
        descendenciaProvider.descendencias[index] = descendenciaModel;
      } else {
        //quantidade de descendencia
        int descendenciaLength = descendenciaProvider.descendencias.length;

        // salva uma nova descendencia
        descendenciaProvider.descendencias
            .insert(descendenciaLength, descendenciaModel);
      }

      // navegar para pagina home
      context.pop('/homeLib');
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
          child: Padding(
            padding: const EdgeInsets.all(15),
            child: Form(
              key: _key,
              child: SingleChildScrollView(
                child: Column(
                  children: [
                    FieldFormButton(
                      label: 'Descendência',
                      controllerButton: controllerDescricao,
                    ),
                    const SizedBox(
                      height: 25,
                    ),
                    FieldFormButton(
                        label: 'Siglas', controllerButton: controllerSiglas),
                    const SizedBox(
                      height: 50,
                    ),
                    TextButton(
                      onPressed: savedescendencia,
                      style: const ButtonStyle(
                          backgroundColor:
                              WidgetStatePropertyAll(Colors.black)),
                      child: const Text(
                        'Salva',
                        style: TextStyle(
                            fontWeight: FontWeight.bold, color: Colors.white),
                      ),
                    )
                  ],
                ),
              ),
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
