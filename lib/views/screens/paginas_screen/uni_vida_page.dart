// ignore_for_file: unused_local_variable

import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';

import '../../../data/provider/escada_do_sucesso_provider/univida_provider.dart';
import '../../../domain/models/model/consolidar/univida_model.dart';
import '../../../domain/core/themes/global_colors.dart';

class UniVidaPage extends StatefulWidget {
  const UniVidaPage({super.key});

  @override
  State<UniVidaPage> createState() => _UniVidaPageState();
}

class _UniVidaPageState extends State<UniVidaPage> {
  @override
  void initState() {
    super.initState();
    // Chama a função de carregar dados assim que a página for carregada
    WidgetsBinding.instance.addPostFrameCallback((_) {
      final uniVidaProvider =
          Provider.of<UniVidaProvider>(context, listen: false);
      uniVidaProvider.listUniVida(
        "",
        "",
        "",
        "",
      ); // Parâmetros padrão
    });
  }

  @override
  Widget build(BuildContext context) {
    UniVidaProvider uniVidaProvider = Provider.of<UniVidaProvider>(context);

    return Scaffold(
      appBar: AppBar(
        backgroundColor: GlobalColor.AzulEscuroClaroColor,
        centerTitle: true,
        iconTheme: const IconThemeData(color: Colors.white),
        title: const Text(
          'Universidade da Vida',
          style: TextStyle(
            fontSize: 22,
            fontWeight: FontWeight.bold,
            color: Colors.white,
          ),
        ),
      ),
      body: Consumer<UniVidaProvider>(
        builder: (context, provider, child) {
          if (provider.uniVidas.isEmpty) {
            return const Center(
              child: CircularProgressIndicator(),
            );
          }

          List<UniVida> unividas = provider.uniVidas;
          int uniVidaLength = unividas.length;

          return Padding(
            padding: EdgeInsets.all(10),
            child: Column(
              children: [
                const SizedBox(
                  height: 10,
                ),
                Expanded(
                  child: ListView.builder(
                    itemCount: uniVidaLength,
                    itemBuilder: (context, indexUniVidas) => Container(
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
                                  'Licão Atual: ${unividas[indexUniVidas].licaoAtual}',
                                  style: const TextStyle(
                                      color: Colors.black,
                                      fontWeight: FontWeight.bold,
                                      fontSize: 13),
                                ),
                                Text(
                                  'Total Aluno: ${unividas[indexUniVidas].totalAlunos}',
                                  style: const TextStyle(
                                      color: Colors.black,
                                      fontWeight: FontWeight.bold,
                                      fontSize: 13),
                                ),
                                Text(
                                  'Data Inicio: ${unividas[indexUniVidas].dataInicio}',
                                  style: const TextStyle(
                                      color: Colors.black,
                                      fontWeight: FontWeight.bold,
                                      fontSize: 13),
                                ),
                                Text(
                                  'Data Conclusão: ${unividas[indexUniVidas].dataConclusao}',
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
                                      uniVidaProvider.uniVidaSelected =
                                          unividas[indexUniVidas];
                                      uniVidaProvider.indexUniVida =
                                          indexUniVidas;
                                      context.push('/viewUniVida');
                                    },
                                    icon: const Icon(Icons.edit,
                                        color: Colors.black),
                                    iconSize: 25,
                                  ),
                                  IconButton(
                                    onPressed: () {
                                      uniVidaProvider.uniVidaSelected =
                                          unividas[indexUniVidas];
                                      uniVidaProvider.indexUniVida =
                                          indexUniVidas;
                                      context.push('/viewUniVida');
                                    },
                                    icon: const Icon(Icons.visibility,
                                        color: Colors.black),
                                    iconSize: 25,
                                  ),
                                  IconButton(
                                    onPressed: () {
                                      uniVidaProvider.uniVidaSelected =
                                          unividas[indexUniVidas];
                                      uniVidaProvider.indexUniVida =
                                          indexUniVidas;
                                      var idUniVida =
                                          uniVidaProvider.uniVidaSelected!.id;
                                      print('/alunoUni/$idUniVida');
                                      context.push('/alunoUni/$idUniVida');
                                    },
                                    icon: const Icon(Icons.person_pin_outlined,
                                        color: Colors.black),
                                    iconSize: 25,
                                  ),
                                  IconButton(
                                    onPressed: () {
                                      uniVidaProvider.uniVidaSelected =
                                          unividas[indexUniVidas];
                                      uniVidaProvider.indexUniVida =
                                          indexUniVidas;
                                      var idUniVida =
                                          uniVidaProvider.uniVidaSelected!.id;
                                      context.push('/registroUni/$idUniVida');
                                    },
                                    icon: const Icon(Icons.menu_book_outlined,
                                        color: Colors.black),
                                    iconSize: 25,
                                  ),
                                ],
                              ),
                            ),
                          )),
                    ),
                  ),
                ),
              ],
            ),
          );
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          uniVidaProvider.indexUniVida = null;
          context.push('/createrUniVida');
        },
        backgroundColor: Colors.black,
        child: const Icon(Icons.edit, color: Colors.white),
      ),
    );
  }
}
