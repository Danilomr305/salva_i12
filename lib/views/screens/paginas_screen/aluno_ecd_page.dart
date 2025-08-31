import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:i12mobile/domain/models/model/discipular/ecd_aluno_model.dart';
import 'package:provider/provider.dart';

import '../../../domain/core/themes/global_colors.dart';
import '../../../data/provider/escada_do_sucesso_provider/alunos_providers/alunos_ecd_provider.dart';

class AlunoEcdPage extends StatefulWidget {
  final String? idEcd;
  const AlunoEcdPage({super.key, this.idEcd});

  @override
  State<AlunoEcdPage> createState() => _AlunoEcdPageState(idEcd: idEcd);
}

class _AlunoEcdPageState extends State<AlunoEcdPage> {
  final String? idEcd;
  _AlunoEcdPageState({required this.idEcd});

  @override
  void initState() {
    super.initState();
    // Chama a função de carregar dados assim que a página for carregada
    WidgetsBinding.instance.addPostFrameCallback((_) {
      final alunosEcdProvider =
          Provider.of<AlunosEcdProvider>(context, listen: false);
      alunosEcdProvider.listEcdAluno(
          idEcd, true, true, "", ""); // Parâmetros padrão
    });
  }

  @override
  Widget build(BuildContext context) {
    AlunosEcdProvider alunosEcdProvider =
        Provider.of<AlunosEcdProvider>(context);

    List<EcdAluno> ecdAluno = alunosEcdProvider.ecdAlunos;

    ecdAluno = ecdAluno.map((ecdAlunoTexto) {
      //ecdAlunoTexto.pessoa.name = corrigirTexto(ecdAlunoTexto.pessoa.nome);
      return ecdAlunoTexto;
    }).toList();

    return Scaffold(
      appBar: AppBar(
        backgroundColor: GlobalColor.AzulEscuroClaroColor,
        centerTitle: true,
        iconTheme: const IconThemeData(color: Colors.white),
        title: const Text(
          'Alunos Ecd',
          style: TextStyle(
            fontSize: 22,
            fontWeight: FontWeight.bold,
            color: Colors.white,
          ),
        ),
      ),
      body: Consumer<AlunosEcdProvider>(
        builder: (context, providerAlunoEcd, child) {
          if (providerAlunoEcd.ecdAlunos.isEmpty) {
            return const Center(
              child: CircularProgressIndicator(),
            );
          }

          List<EcdAluno> alunosEcds = providerAlunoEcd.ecdAlunos;
          int alunosEcdLength = alunosEcds.length;

          return Padding(
            padding: EdgeInsets.all(10),
            child: Column(
              children: [
                const SizedBox(
                  height: 10,
                ),
                Expanded(
                  child: ListView.builder(
                    itemCount: alunosEcdLength,
                    itemBuilder: ((BuildContext contextBuilder,
                            indexAlunosEcd) =>
                        Container(
                          decoration: const BoxDecoration(
                            border: Border(bottom: BorderSide(width: 0.4)),
                          ),
                          child: Container(
                            decoration: BoxDecoration(
                              color: Colors.grey,
                              borderRadius: BorderRadius.circular(12),
                            ),
                            margin: const EdgeInsets.only(bottom: 10),
                            child: ListTile(
                              title: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    'Aluno: ${alunosEcds[indexAlunosEcd].pessoa.nome}',
                                    style: const TextStyle(
                                        color: Colors.black,
                                        fontWeight: FontWeight.bold,
                                        fontSize: 14),
                                  ),
                                  Text(
                                    'Comprou o Livro?: ${alunosEcds[indexAlunosEcd].comprouLivro ? 'sim' : 'não'}',
                                    style: const TextStyle(
                                        color: Colors.black,
                                        fontWeight: FontWeight.bold,
                                        fontSize: 14),
                                  ),
                                  Text(
                                    'Comprou a Camisa?: ${alunosEcds[indexAlunosEcd].comprouCamisa ? 'sim' : 'não'}',
                                    style: const TextStyle(
                                        color: Colors.black,
                                        fontWeight: FontWeight.bold,
                                        fontSize: 14),
                                  ),
                                  Text(
                                    'Data Inscrição : ${alunosEcds[indexAlunosEcd].dataInscricao}',
                                    style: const TextStyle(
                                        color: Colors.black,
                                        fontWeight: FontWeight.bold,
                                        fontSize: 14),
                                  ),
                                ],
                              ),
                              subtitle: Container(
                                child: Row(
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  mainAxisSize: MainAxisSize.min,
                                  children: [
                                    IconButton(
                                      onPressed: () {
                                        alunosEcdProvider.ecdAlunosSelected =
                                            alunosEcds[indexAlunosEcd];
                                        alunosEcdProvider.indexEcdAluno =
                                            indexAlunosEcd;
                                        context.push('/createrAlunoEcd');
                                      },
                                      icon: const Icon(Icons.edit,
                                          color: Colors.black),
                                      iconSize: 20,
                                    ),
                                    IconButton(
                                      onPressed: () {
                                        alunosEcdProvider.ecdAlunosSelected =
                                            alunosEcds[indexAlunosEcd];
                                        alunosEcdProvider.indexEcdAluno =
                                            indexAlunosEcd;
                                        context.push('/viewAlunoEcd');
                                      },
                                      icon: const Icon(Icons.visibility,
                                          color: Colors.black),
                                      iconSize: 20,
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          ),
                        )),
                  ),
                ),
              ],
            ),
          );
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          alunosEcdProvider.indexEcdAluno = null;
          context.push('/createrAlunoEcd');
        },
        backgroundColor: Colors.black,
        child: const Icon(Icons.edit, color: Colors.white),
      ),
    );
  }

  // Função de correção de texto com caracteres
  String corrigirTexto(String texto) {
    try {
      // Se a string estiver corrompida, tente corrigir a codificação
      return utf8.decode(texto.runes.toList());
    } catch (e) {
      return texto; // Retorna o texto original se não puder corrigir
    }
  }
}
