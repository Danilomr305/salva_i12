// ignore_for_file: unused_local_variable

import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:i12mobile/data/provider/escada_do_sucesso_provider/alunos_providers/alunos_uni_vida_provider.dart';
import 'package:i12mobile/domain/models/model/consolidar/univida_aluno_model.dart';
import 'package:provider/provider.dart';

import '../../../domain/core/themes/global_colors.dart';

class AlunoUniPage extends StatefulWidget {
  final String? idUniVida;
  AlunoUniPage({super.key, this.idUniVida});

  @override
  State<AlunoUniPage> createState() => _AlunoUniPageState(idUniVida: idUniVida);
}

class _AlunoUniPageState extends State<AlunoUniPage> {
  final String? idUniVida;
  _AlunoUniPageState({required this.idUniVida});

  @override
  void initState() {
    super.initState();
    // Chama a função de carregar dados assim que a página for carregada
    WidgetsBinding.instance.addPostFrameCallback((_) {
      final alunosUniVidaProvider =
          Provider.of<AlunosUniVidaProvider>(context, listen: false);
      alunosUniVidaProvider.listUniVidaAluno(
          idUniVida, "", true, true, ""); // Parâmetros padrão
    });
  }

  @override
  Widget build(BuildContext context) {
    AlunosUniVidaProvider alunosUniVidaProvider =
        Provider.of<AlunosUniVidaProvider>(context);

    return Scaffold(
      appBar: AppBar(
        backgroundColor: GlobalColor.AzulEscuroClaroColor,
        centerTitle: true,
        iconTheme: const IconThemeData(color: Colors.white),
        title: const Text(
          'Aluno Uni Vida',
          style: TextStyle(
            fontSize: 22,
            fontWeight: FontWeight.bold,
            color: Colors.white,
          ),
        ),
      ),
      body: Consumer<AlunosUniVidaProvider>(
        builder: (context, providerAlunoUni, child) {
          if (providerAlunoUni.uniVidaAlunos.isEmpty) {
            return const Center(child: CircularProgressIndicator());
          }

          List<UniVidaAluno> alunosEcd = providerAlunoUni.uniVidaAlunos;
          int alunosUniLength = alunosEcd.length;

          alunosEcd = alunosEcd.map((alunosEcdTexto) {
            alunosEcdTexto.pessoa.nome =
                corrigirTexto(alunosEcdTexto.pessoa.nome);
            return alunosEcdTexto;
          }).toList();

          //print('$alunos');
          return Padding(
            padding: EdgeInsets.all(10),
            child: Column(
              children: [
                const SizedBox(
                  height: 10,
                ),
                Expanded(
                  child: ListView.builder(
                      itemCount: alunosUniLength,
                      itemBuilder: ((BuildContext contextBuilder,
                              indexAlunosUni) =>
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
                                      'Aluno: ${alunosEcd[indexAlunosUni].pessoa.nome}',
                                      style: const TextStyle(
                                          color: Colors.black,
                                          fontWeight: FontWeight.bold,
                                          fontSize: 14),
                                    ),
                                    Text(
                                      'Comprou o Livro?: ${alunosEcd[indexAlunosUni].comprouLivro ? 'sim' : 'não'}',
                                      style: const TextStyle(
                                          color: Colors.black,
                                          fontWeight: FontWeight.bold,
                                          fontSize: 14),
                                    ),
                                    Text(
                                      'Comprou a Camisa?: ${alunosEcd[indexAlunosUni].comprouCamisa ? 'sim' : 'não'}',
                                      style: const TextStyle(
                                          color: Colors.black,
                                          fontWeight: FontWeight.bold,
                                          fontSize: 14),
                                    ),
                                    Text(
                                      'Data Inscrição : ${alunosEcd[indexAlunosUni].dataInscricao}',
                                      style: const TextStyle(
                                          color: Colors.black,
                                          fontWeight: FontWeight.bold,
                                          fontSize: 14),
                                    ),
                                  ],
                                ),
                                subtitle: Container(
                                  child: Row(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.center,
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    mainAxisSize: MainAxisSize.min,
                                    children: [
                                      IconButton(
                                        onPressed: () {
                                          alunosUniVidaProvider
                                                  .uniVidaAlunoSelected =
                                              alunosEcd[indexAlunosUni];
                                          alunosUniVidaProvider
                                                  .indexUniVidaAluno =
                                              indexAlunosUni;
                                          context.push('/createrAlunoUni');
                                        },
                                        icon: const Icon(Icons.edit,
                                            color: Colors.black),
                                        iconSize: 20,
                                      ),
                                      IconButton(
                                        onPressed: () {
                                          alunosUniVidaProvider
                                                  .uniVidaAlunoSelected =
                                              alunosEcd[indexAlunosUni];
                                          alunosUniVidaProvider
                                                  .indexUniVidaAluno =
                                              indexAlunosUni;
                                          context.push('/viewAlunoUni');
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
                          ))),
                )
              ],
            ),
          );
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          alunosUniVidaProvider.indexUniVidaAluno = null;
          context.push('/createrAlunoUni');
        },
        backgroundColor: Colors.black,
        child: const Icon(
          Icons.edit,
          color: Colors.white,
        ),
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
