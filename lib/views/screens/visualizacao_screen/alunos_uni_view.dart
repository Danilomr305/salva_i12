// ignore_for_file: unused_local_variable

import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:i12mobile/data/provider/escada_do_sucesso_provider/alunos_providers/alunos_uni_vida_provider.dart';
import 'package:provider/provider.dart';

import '../../../domain/core/themes/containers_all_estilo.dart';
import '../../../domain/core/themes/global_colors.dart';
import '../../widgets/field_form_button.dart';

class AlunoUniView extends StatefulWidget {
  const AlunoUniView({super.key});

  @override
  State<AlunoUniView> createState() => _AlunoUniViewState();
}

class _AlunoUniViewState extends State<AlunoUniView> {
  String title = 'View Aluno';

  TextEditingController controllerIgreja = TextEditingController();
  TextEditingController controllerPessoa = TextEditingController();
  TextEditingController controllerUniversidadeDaVida = TextEditingController();
  TextEditingController controllerComprouLivro = TextEditingController();
  TextEditingController controllerValorLivro = TextEditingController();
  TextEditingController controllerComprouCamisa = TextEditingController();
  TextEditingController controllervalorCamisa = TextEditingController();
  TextEditingController controllerId = TextEditingController();
  TextEditingController controllerDescritionDto = TextEditingController();
  TextEditingController controllerDataInscricao = TextEditingController();

  @override
  Widget build(BuildContext context) {
    AlunosUniVidaProvider alunosUniVidaProvider =
        Provider.of<AlunosUniVidaProvider>(context);

    int? index;

    if (alunosUniVidaProvider.indexUniVidaAluno != null) {
      index = alunosUniVidaProvider.indexUniVidaAluno;
      controllerIgreja.text =
          alunosUniVidaProvider.uniVidaAlunoSelected!.igreja.sigla;
      controllerPessoa.text =
          alunosUniVidaProvider.uniVidaAlunoSelected!.pessoa.nome;
      controllerUniversidadeDaVida.text = alunosUniVidaProvider
          .uniVidaAlunoSelected!.universidadeDaVida.dataInicio;
      controllerComprouLivro.text =
          alunosUniVidaProvider.uniVidaAlunoSelected!.comprouLivro
              ? 'Sim'
              : 'Não';
      controllerValorLivro.text =
          alunosUniVidaProvider.uniVidaAlunoSelected!.valorLivro;
      controllerComprouCamisa.text =
          alunosUniVidaProvider.uniVidaAlunoSelected!.comprouCamisa
              ? 'Sim'
              : 'Não';
      controllervalorCamisa.text =
          alunosUniVidaProvider.uniVidaAlunoSelected!.valorPagoCamisa;
      controllerDataInscricao.text =
          alunosUniVidaProvider.uniVidaAlunoSelected!.dataInscricao;
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
                    label: 'Aluno', controllerButton: controllerPessoa),
                const SizedBox(
                  height: 25,
                ),
                FieldFormButton(
                    label: 'ComprouLivro?',
                    controllerButton: controllerComprouLivro),
                const SizedBox(
                  height: 25,
                ),
                FieldFormButton(
                    label: 'ComprouCamisa',
                    controllerButton: controllerComprouCamisa),
                const SizedBox(
                  height: 25,
                ),
                FieldFormButton(
                    label: 'Data da Inscrição',
                    controllerButton: controllerDataInscricao),
                const SizedBox(
                  height: 50,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    TextButton(
                      onPressed: () {
                        context.push('/createrAlunoUni');
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
                        context.push('/createrAlunoUni');
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
