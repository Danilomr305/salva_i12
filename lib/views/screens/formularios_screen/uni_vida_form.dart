// ignore_for_file: unnecessary_null_comparison

import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:i12mobile/data/provider/escada_do_sucesso_provider/univida_provider.dart';
import 'package:i12mobile/views/widgets/field_form_button.dart';
import 'package:provider/provider.dart';

import '../../../domain/models/model/consolidar/univida_model.dart';
import '../../../domain/models/model/igreja.dart';
import '../../../domain/models/shared/descrition_model.dart';
import '../../../domain/core/themes/containers_all_estilo.dart';
import '../../../domain/core/themes/global_colors.dart';

class UniVidaForm extends StatefulWidget {
  const UniVidaForm({super.key});

  @override
  State<UniVidaForm> createState() => _UniVidaFormState();
}

class _UniVidaFormState extends State<UniVidaForm> {
  String title = 'Nova Turma';

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

    GlobalKey<FormState> _key = GlobalKey();

    void saveUniVida() {
      final isValidateUniVida = _key.currentState?.validate();

      if (isValidateUniVida == false) {
        return;
      }

      _key.currentState?.save();

      // instacia da classe UniVida
      UniVida uniVida = UniVida(
        dataConclusao: controllerDataEncerramentoTurma.text,
        dataInicio: controllerDataInicioTurma.text,
        descricao: controllerDescricao.text,
        descritionDto: Descrition(id: '', descricao: ''),
        id: controllerId.text,
        igreja: new IgrejaModels(
            razaoSocial: '',
            sigla: '',
            nomeFantasia: controllerIgreja.text,
            documento: '',
            id: controllerId.text,
            descritionDto: Descrition(
                id: controllerId.text,
                descricao: controllerDescritionDto.text)),
        licaoAtual: controllerLicaoAtual.text,
        localAula: controllerLocalAula.text,
        totalAlunos: controllerTotalAlunos.text as int, // operacao em teste
      );

      if (index != null) {
        uniVidaProvider.uniVidas[index] = uniVida;
      } else {
        //quantidades de turmas
        int uniVidaLength = uniVidaProvider.uniVidas.length;

        // Salva um nova turma
        uniVidaProvider.uniVidas.insert(uniVidaLength, uniVida);

        // navegar para a pagina uniVida
        context.pop('/uniVida');
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
                      label: 'Dados de Inicio',
                      controllerButton: controllerDataInicioTurma,
                    ),
                    const SizedBox(
                      height: 50,
                    ),
                    TextButton(
                      onPressed: saveUniVida,
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
