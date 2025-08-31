import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:i12mobile/data/provider/escada_do_sucesso_provider/registros_aulas_providers/registros_aula_ecd_provider.dart';
import 'package:i12mobile/domain/models/model/discipular/ecd_aula_model.dart';
import 'package:provider/provider.dart';

import '../../../domain/core/themes/global_colors.dart';

class RegistroEcdPage extends StatefulWidget {
  final String? idEcd;
  const RegistroEcdPage({super.key, this.idEcd});

  @override
  State<RegistroEcdPage> createState() => _RegistroEcdPageState(idEcd: idEcd);
}

class _RegistroEcdPageState extends State<RegistroEcdPage> {
  final String? idEcd;
  _RegistroEcdPageState({required this.idEcd});

  @override
  void initState() {
    super.initState();
    // Chama a função de carregar dados assim que a página for carregada
    WidgetsBinding.instance.addPostFrameCallback((_) {
      final registroAulaEcdProvider =
          Provider.of<RegistroAulaEcdProvider>(context, listen: false);
      registroAulaEcdProvider.listRegistroEcd(
          idEcd, "", "", "", "", ""); // Parâmetros padrão
    });
  }

  @override
  Widget build(BuildContext context) {
    RegistroAulaEcdProvider registroAulaEcdProvider =
        Provider.of<RegistroAulaEcdProvider>(context);

    return Scaffold(
      appBar: AppBar(
        backgroundColor: GlobalColor.AzulEscuroClaroColor,
        centerTitle: true,
        iconTheme: const IconThemeData(color: Colors.white),
        title: const Text(
          'Registros Ecd',
          style: TextStyle(
            fontSize: 22,
            fontWeight: FontWeight.bold,
            color: Colors.white,
          ),
        ),
      ),
      body: Consumer<RegistroAulaEcdProvider>(
        builder: (context, registroAulaEcd, child) {
          if (registroAulaEcd.ecdAulas.isEmpty) {
            return const Center(
              child: CircularProgressIndicator(),
            );
          }

          List<EcdAula> registroEcd = registroAulaEcd.ecdAulas;
          int registrosLengthEcd = registroEcd.length;

          registroEcd = registroEcd.map((registroEcdTexto) {
            registroEcdTexto.licao.descricao =
                corrigirTexto(registroEcdTexto.licao.descricao);
            return registroEcdTexto;
          }).toList();

          return Padding(
            padding: EdgeInsets.all(10),
            child: Column(
              children: [
                Expanded(
                  child: ListView.builder(
                      itemCount: registrosLengthEcd,
                      itemBuilder: (BuildContext context, indexRegistrosEcd) =>
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
                                      'Tipo: ${registroEcd[indexRegistrosEcd].aulaTipo.descricao}',
                                      style: const TextStyle(
                                          color: Colors.black,
                                          fontWeight: FontWeight.bold,
                                          fontSize: 14),
                                    ),
                                    Text(
                                      'Data Aula: ${registroEcd[indexRegistrosEcd].dataAula}',
                                      style: const TextStyle(
                                          color: Colors.black,
                                          fontWeight: FontWeight.bold,
                                          fontSize: 14),
                                    ),
                                    Text(
                                      'Tema: ${registroEcd[indexRegistrosEcd].licao.descricao}',
                                      style: const TextStyle(
                                          color: Colors.black,
                                          fontWeight: FontWeight.bold,
                                          fontSize: 14),
                                    ),
                                    Text(
                                      'Professor: ${registroEcd[indexRegistrosEcd].professor.nome}',
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
                                          registroAulaEcdProvider
                                                  .registrosEcdSelected =
                                              registroEcd[indexRegistrosEcd];
                                          registroAulaEcdProvider
                                                  .indexRegistrosEcd =
                                              indexRegistrosEcd;
                                          context.push('/createrRegistroEcd');
                                        },
                                        icon: const Icon(Icons.edit,
                                            color: Colors.black),
                                        iconSize: 20,
                                      ),
                                      IconButton(
                                        onPressed: () {
                                          registroAulaEcdProvider
                                                  .registrosEcdSelected =
                                              registroEcd[indexRegistrosEcd];
                                          registroAulaEcdProvider
                                                  .indexRegistrosEcd =
                                              indexRegistrosEcd;
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
                          )),
                )
              ],
            ),
          );
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          registroAulaEcdProvider.indexRegistrosEcd = null;
          context.push('/createrRegistroEcd');
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
