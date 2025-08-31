// ignore_for_file: unnecessary_null_comparison

import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:i12mobile/data/provider/escada_do_sucesso_provider/ecd_provider.dart';
import 'package:i12mobile/domain/models/model/discipular/ecd_model.dart';
import 'package:i12mobile/domain/models/model/discipular/ecd_modulo_model.dart';
import 'package:i12mobile/views/widgets/field_form_button.dart';
import 'package:provider/provider.dart';

import '../../../domain/models/model/igreja.dart';
import '../../../domain/models/shared/descrition_model.dart';
import '../../../domain/core/themes/containers_all_estilo.dart';
import '../../../domain/core/themes/global_colors.dart';

class EcdForm extends StatefulWidget {
  const EcdForm({super.key});

  @override
  State<EcdForm> createState() => _EcdFormState();
}

class _EcdFormState extends State<EcdForm> {
  String title = 'Nova Turma';

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

      setState(() {
        this.title = 'Edit Turma';
      });
    }

    GlobalKey<FormState> _key = GlobalKey();

    void saveEcd() {
      final isValidateEcd = _key.currentState?.validate();

      if (isValidateEcd == false) {
        return;
      }

      _key.currentState?.save();

      // instacia da classe UniVida
      EcdModel ecdModel = EcdModel(
          igreja: new IgrejaModels(
              razaoSocial: '',
              sigla: '',
              nomeFantasia: controllerIgreja.text,
              documento: '',
              id: controllerId.text,
              descritionDto: Descrition(
                  id: controllerId.text,
                  descricao: controllerDescritionDto.text)),
          descricao: controllerDescricao.text,
          modulo: EcdModulo(
            id: controllerId.text, // Certifique-se de que isso seja válido
            descritionDto:
                Descrition(id: '', descricao: ''), // Ajuste conforme necessário
            descricao: controllerModulo.text,
            nivel:
                int.parse(controllerModulo.text), // Ajuste conforme necessário
            livro:
                int.parse(controllerModulo.text), // Ajuste conforme necessário
          ),
          dataInicio: controllerDataInicio.text,
          dataConclusao: controllerDataConclusao.text,
          totalAlunos: controllerTotalAlunos.text as num,
          localAula: controllerLocalAula.text,
          id: '',
          descritionDto: new Descrition(id: '', descricao: ''));

      if (index != null) {
        ecdProvider.ecdModels[index] = ecdModel;
      } else {
        //quantidades de turmas
        int ecdLength = ecdProvider.ecdModels.length;

        // Salva um nova turma
        ecdProvider.ecdModels.insert(ecdLength, ecdModel);

        // navegar para a pagina uniVida
        context.pop('/ecd');
      }
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
          child: Padding(
            padding: const EdgeInsets.all(15),
            child: Form(
              key: _key,
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
                    TextButton(
                      onPressed: saveEcd,
                      style: const ButtonStyle(
                          backgroundColor:
                              WidgetStatePropertyAll(Colors.black)),
                      child: const Text(
                        'Salva',
                        style: TextStyle(
                            fontWeight: FontWeight.bold,
                            color: Colors.white,
                            fontSize: 20),
                      ),
                    )
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
