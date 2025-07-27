import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:i12mobile/data/provider/escada_do_sucesso_provider/registros_aulas_providers/registros_aula_uni_provider.dart';
import 'package:i12mobile/domain/models/model/consolidar/univida_aula_models.dart';
import 'package:provider/provider.dart';

import '../../../domain/core/themes/global_colors.dart';

class RegistroUniPage extends StatefulWidget {
  final String? idUniVida;
  const RegistroUniPage({super.key, this.idUniVida});

  @override
  State<RegistroUniPage> createState() =>
      _RegistroUniPageState(idUniVida: idUniVida);
}

class _RegistroUniPageState extends State<RegistroUniPage> {
  final String? idUniVida;
  _RegistroUniPageState({required this.idUniVida});

  @override
  void initState() {
    super.initState();
    // Chama a função de carregar dados assim que a página for carregada
    WidgetsBinding.instance.addPostFrameCallback((_) {
      final registrosAulasUniProvider =
          Provider.of<RegistrosAulasUniProvider>(context, listen: false);
      registrosAulasUniProvider.listRegistroUni(
          idUniVida, "", "", "", "", ""); // Parâmetros padrão
    });
  }

  @override
  Widget build(BuildContext context) {
    RegistrosAulasUniProvider registrosAulasUniProvider =
        Provider.of<RegistrosAulasUniProvider>(context);

    return Scaffold(
      appBar: AppBar(
        backgroundColor: GlobalColor.AzulEscuroClaroColor,
        centerTitle: true,
        iconTheme: const IconThemeData(color: Colors.white),
        title: const Text(
          'Registro Uni Vida',
          style: TextStyle(
            fontSize: 22,
            fontWeight: FontWeight.bold,
            color: Colors.white,
          ),
        ),
      ),
      body: Consumer<RegistrosAulasUniProvider>(
        builder: (context, registrosAula, child) {
          if (registrosAula.uniAulasUnis.isEmpty) {
            return const Center(child: CircularProgressIndicator());
          }

          List<UniVidaAula> registrosUniVida = registrosAula.uniAulasUnis;
          int registrosLength = registrosUniVida.length;

          registrosUniVida = registrosUniVida.map((registroUniVidaTexto) {
            registroUniVidaTexto.professor.nome =
                corrigirTexto(registroUniVidaTexto.professor.nome);
            return registroUniVidaTexto;
          }).toList();

          return Padding(
            padding: EdgeInsets.all(10),
            child: Column(
              children: [
                const SizedBox(
                  height: 10,
                ),
                Expanded(
                    child: ListView.builder(
                  itemCount: registrosLength,
                  itemBuilder: (BuildContext context, indexRegistrosUniAula) =>
                      Container(
                          decoration: const BoxDecoration(
                            border: Border(bottom: BorderSide(width: 0.4)),
                          ),
                          child: Container(
                            decoration: BoxDecoration(
                              color: Colors.grey,
                              borderRadius: BorderRadius.circular(12),
                            ),
                            margin: EdgeInsets.only(bottom: 10),
                            child: ListTile(
                              title: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    'Tipo: ${registrosUniVida[indexRegistrosUniAula].aulaTipo.descricao}',
                                    style: const TextStyle(
                                        color: Colors.black,
                                        fontWeight: FontWeight.bold,
                                        fontSize: 14),
                                  ),
                                  Text(
                                    'Data Aula: ${registrosUniVida[indexRegistrosUniAula].dataAula}',
                                    style: const TextStyle(
                                        color: Colors.black,
                                        fontWeight: FontWeight.bold,
                                        fontSize: 14),
                                  ),
                                  Text(
                                    'Tema: ${registrosUniVida[indexRegistrosUniAula].licao.descricao}',
                                    style: const TextStyle(
                                        color: Colors.black,
                                        fontWeight: FontWeight.bold,
                                        fontSize: 14),
                                  ),
                                  Text(
                                    'Professor: ${registrosUniVida[indexRegistrosUniAula].professor.nome}',
                                    style: const TextStyle(
                                        color: Colors.black,
                                        fontWeight: FontWeight.bold,
                                        fontSize: 14),
                                  ),

                                  /*Text(
                                'Alunos Presentes: ${registros[indexRegistrosAula].aluno}',
                                style: const TextStyle(color: Colors.black, fontWeight: FontWeight.bold, fontSize: 14),
                              ),*/
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
                                        registrosAulasUniProvider
                                                .registrosUniSelected =
                                            registrosUniVida[
                                                indexRegistrosUniAula];
                                        registrosAulasUniProvider
                                                .indexRegistrosAula =
                                            indexRegistrosUniAula;
                                        context.push('/createrRegistroUni');
                                      },
                                      icon: const Icon(Icons.edit,
                                          color: Colors.black),
                                      iconSize: 20,
                                    ),
                                    IconButton(
                                      onPressed: () {
                                        registrosAulasUniProvider
                                                .registrosUniSelected =
                                            registrosUniVida[
                                                indexRegistrosUniAula];
                                        registrosAulasUniProvider
                                                .indexRegistrosAula =
                                            indexRegistrosUniAula;
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
                          )),
                ))
              ],
            ),
          );
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          registrosAulasUniProvider.indexRegistrosAula = null;
          context.push('/createrRegistroUni');
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
