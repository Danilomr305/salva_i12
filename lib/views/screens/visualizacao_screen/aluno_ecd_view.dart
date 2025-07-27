// ignore_for_file: unused_local_variable

import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';

import '../../../domain/core/themes/containers_all_estilo.dart';
import '../../../domain/core/themes/global_colors.dart';
import '../../../data/provider/escada_do_sucesso_provider/alunos_providers/alunos_ecd_provider.dart';
import '../../widgets/field_form_button.dart';

class AlunoEcdView extends StatefulWidget {
  const AlunoEcdView({super.key});

  @override
  State<AlunoEcdView> createState() => _AlunoEcdViewState();
}

class _AlunoEcdViewState extends State<AlunoEcdView> {
  String title = 'View Aluno(a)';

  TextEditingController controllerPessoa = TextEditingController();
  TextEditingController controllerEscola = TextEditingController();
  TextEditingController controllerComprouLivro = TextEditingController();
  TextEditingController controllerValorLivro = TextEditingController();
  TextEditingController controllerComprouCamisa = TextEditingController();
  TextEditingController controllervalorCamisa = TextEditingController();
  TextEditingController controllerId = TextEditingController();
  TextEditingController controllerDescritionDto = TextEditingController();
  TextEditingController controllerDataInscricao = TextEditingController();
  @override
  Widget build(BuildContext context) {
    AlunosEcdProvider alunosEcdProvider =
        Provider.of<AlunosEcdProvider>(context);

    int? index;

    if (alunosEcdProvider.indexEcdAluno != null) {
      index = alunosEcdProvider.indexEcdAluno;

      controllerPessoa.text = alunosEcdProvider.ecdAlunosSelected!.pessoa.nome;
      controllerEscola.text =
          alunosEcdProvider.ecdAlunosSelected!.escola.descricao;
      controllerComprouLivro.text =
          alunosEcdProvider.ecdAlunosSelected!.comprouLivro ? 'Sim' : 'Não';
      controllerComprouCamisa.text =
          alunosEcdProvider.ecdAlunosSelected!.comprouCamisa ? 'Sim' : 'Não';
      controllerValorLivro.text =
          alunosEcdProvider.ecdAlunosSelected!.valorPagoLivro.toString();
      controllervalorCamisa.text =
          alunosEcdProvider.ecdAlunosSelected!.valorPagoCamisa.toString();
      controllerDataInscricao.text =
          alunosEcdProvider.ecdAlunosSelected!.dataInscricao;
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
                        context.push('/createrAlunoEcd');
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
                        context.push('/createrAlunoEcd');
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
