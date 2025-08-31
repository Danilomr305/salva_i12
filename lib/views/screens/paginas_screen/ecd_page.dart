import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:i12mobile/data/provider/escada_do_sucesso_provider/ecd_provider.dart';
import 'package:i12mobile/domain/models/model/discipular/ecd_model.dart';
import 'package:provider/provider.dart';

import '../../../domain/core/themes/global_colors.dart';

class EcdPage extends StatefulWidget {
  const EcdPage({super.key});

  @override
  State<EcdPage> createState() => _EcdPageState();
}

class _EcdPageState extends State<EcdPage> {
  @override
  void initState() {
    super.initState();
    // Chama a função de carregar dados assim que a página for carregada
    WidgetsBinding.instance.addPostFrameCallback((_) {
      final ecdProvider = Provider.of<EcdProvider>(context, listen: false);
      ecdProvider.listEcd("", "", "", 0); // Parâmetros padrão
    });
  }

  @override
  Widget build(BuildContext context) {
    EcdProvider ecdProvider = Provider.of<EcdProvider>(context);

    return Scaffold(
      appBar: AppBar(
        backgroundColor: GlobalColor.AzulEscuroClaroColor,
        centerTitle: true,
        iconTheme: const IconThemeData(color: Colors.white),
        title: const Text(
          'Capacitação Destino',
          style: TextStyle(
            fontSize: 22,
            fontWeight: FontWeight.bold,
            color: Colors.white,
          ),
        ),
      ),
      body: Consumer<EcdProvider>(
        builder: (context, provider, child) {
          if (provider.ecdModels.isEmpty) {
            return const Center(child: CircularProgressIndicator());
          }

          List<EcdModel> ecds = provider.ecdModels;
          int ecdLength = ecds.length;

          ecds = ecds.map((ecdsTexto) {
            ecdsTexto.modulo.descricao =
                corrigirTexto(ecdsTexto.modulo.descricao);
            return ecdsTexto;
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
                    itemCount: ecdLength,
                    itemBuilder: (BuildContext constext, indexEcd) => Container(
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
                                'Módulo: ${ecds[indexEcd].modulo.nivel}',
                                style: const TextStyle(
                                    color: Colors.black,
                                    fontWeight: FontWeight.bold,
                                    fontSize: 13),
                              ),
                              Text(
                                'Livro: ${ecds[indexEcd].modulo.descricao}',
                                style: const TextStyle(
                                    color: Colors.black,
                                    fontWeight: FontWeight.bold,
                                    fontSize: 13),
                              ),
                              Text(
                                'Data Inicio: ${ecds[indexEcd].dataInicio}',
                                style: const TextStyle(
                                    color: Colors.black,
                                    fontWeight: FontWeight.bold,
                                    fontSize: 13),
                              ),
                              Text(
                                'Total Alunos: ${ecds[indexEcd].totalAlunos}',
                                style: const TextStyle(
                                    color: Colors.black,
                                    fontWeight: FontWeight.bold,
                                    fontSize: 13),
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
                                    ecdProvider.ecdModelSelected =
                                        ecds[indexEcd];
                                    ecdProvider.indexecdModel = indexEcd;
                                    context.push('/viewEcd');
                                  },
                                  icon: const Icon(Icons.edit,
                                      color: Colors.black),
                                  iconSize: 25,
                                ),
                                IconButton(
                                  onPressed: () {
                                    ecdProvider.ecdModelSelected =
                                        ecds[indexEcd];
                                    ecdProvider.indexecdModel = indexEcd;
                                    context.push('/viewEcd');
                                  },
                                  icon: const Icon(Icons.visibility,
                                      color: Colors.black),
                                  iconSize: 25,
                                ),
                                IconButton(
                                  onPressed: () {
                                    ecdProvider.ecdModelSelected =
                                        ecds[indexEcd];
                                    ecdProvider.indexecdModel = indexEcd;
                                    var idEcd =
                                        ecdProvider.ecdModelSelected!.id;
                                    print('/alunoEcd/$idEcd');
                                    context.push('/alunoEcd/$idEcd');
                                  },
                                  icon: const Icon(Icons.person_pin_outlined,
                                      color: Colors.black),
                                  iconSize: 25,
                                ),
                                IconButton(
                                  onPressed: () {
                                    ecdProvider.ecdModelSelected =
                                        ecds[indexEcd];
                                    ecdProvider.indexecdModel = indexEcd;
                                    var idEcd =
                                        ecdProvider.ecdModelSelected!.id;
                                    print('/alunoEcd/$idEcd');
                                    context.push('/registroEcd/$idEcd');
                                  },
                                  icon: const Icon(Icons.menu_book_outlined,
                                      color: Colors.black),
                                  iconSize: 25,
                                ),
                              ],
                            ),
                          ),
                        ),
                      ),
                    ),
                  ),
                )
              ],
            ),
          );
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          ecdProvider.indexecdModel = null;
          context.push('/createrEcd');
        },
        backgroundColor: Colors.black,
        child: const Icon(
          Icons.edit,
          color: Colors.white,
        ),
      ),
    );
  }

  // Funções para corritir texto com caracteres
  String corrigirTexto(String texto) {
    try {
      // Se a string estiver corrompida, tente corrigir a codificação
      return utf8.decode(texto.runes.toList());
    } catch (e) {
      return texto; // Retorna o texto original se não puder corrigir
    }
  }
}
