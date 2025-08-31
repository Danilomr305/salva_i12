import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:i12mobile/domain/core/themes/global_colors.dart';
import 'package:i12mobile/data/provider/escada_do_sucesso_provider/ganhar/rota_da_vida_provider.dart';
import 'package:i12mobile/domain/models/model/ganhar/rota_da_vida_models.dart';
import 'package:provider/provider.dart';

class RotaDaVidaPage extends StatefulWidget {
  const RotaDaVidaPage({super.key});

  @override
  State<RotaDaVidaPage> createState() => _RotaDaVidaPageState();
}

class _RotaDaVidaPageState extends State<RotaDaVidaPage> {
  List<RotaDaVidaModels> allRotas = [];
  List<RotaDaVidaModels> filteredRotas = [];
  final TextEditingController searchController = TextEditingController();

  late RotaDaVidaProvider rotaDaVidaProvider;

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      // Inicializando o provider
      rotaDaVidaProvider =
          Provider.of<RotaDaVidaProvider>(context, listen: false);
      // Chamando a função para carregar os dados
      carregarRotas();
      // Adicionando um listener para atualizar a UI quando as rotas forem carregadas
      rotaDaVidaProvider.addListener(_updateRotaDaVidaList);
    });
  }

  @override
  void dispose() {
    rotaDaVidaProvider.removeListener(_updateRotaDaVidaList);
    super.dispose();
  }

  Future<void> carregarRotas() async {
    try {
      await rotaDaVidaProvider.listRotaDaVida("", "", "");
      setState(() {
        // Após carregar os dados, atualize o estado
        allRotas = rotaDaVidaProvider.rotas;
        filteredRotas =
            List.from(allRotas); // Inicialmente, todos estão visíveis
        // Ordenando a lista alfabética com base no nome da pessoa
        filteredRotas.sort((a, b) =>
            a.pessoa.nome.toLowerCase().compareTo(b.pessoa.nome.toLowerCase()));
      });
    } catch (e) {
      // Caso ocorra algum erro
      print("Erro ao carregar rotas: $e");
    }
  }

  void _updateRotaDaVidaList() {
    setState(() {
      allRotas = rotaDaVidaProvider.rotas;
      filteredRotas = List.from(allRotas); // Atualizando as rotas filtradas
      // Ordenando após a atualização também
      filteredRotas.sort((a, b) =>
          a.pessoa.nome.toLowerCase().compareTo(b.pessoa.nome.toLowerCase()));
    });
  }

  String corrigirTexto(String texto) {
    try {
      return utf8.decode(texto.runes.toList());
    } catch (_) {
      return texto; // Retorna o texto original se não puder corrigir
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: GlobalColor.AzulEscuroClaroColor,
        centerTitle: true,
        iconTheme: const IconThemeData(color: Colors.white),
        title: const Text(
          'Rota Da Vida',
          style: TextStyle(
            color: Colors.white,
            fontSize: 22,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(10),
        child: allRotas.isEmpty
            ? const Center(child: CircularProgressIndicator())
            : Column(
                children: [
                  const SizedBox(height: 10),
                  Expanded(
                    child: ListView.builder(
                      itemCount: filteredRotas.length,
                      itemBuilder: (context, index) {
                        final rota = filteredRotas[index];
                        return Container(
                          decoration: const BoxDecoration(
                            border: Border(bottom: BorderSide(width: 0.4)),
                          ),
                          margin: const EdgeInsets.only(bottom: 10),
                          child: Container(
                            decoration: BoxDecoration(
                              color: Colors.grey,
                              borderRadius: BorderRadius.circular(12),
                            ),
                            child: ListTile(
                              title: Text(
                                'N: ${corrigirTexto(rota.pessoa.nome)}',
                                style: const TextStyle(
                                  color: Colors.black,
                                  fontSize: 15,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                              subtitle: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Row(
                                    children: [
                                      Text(
                                        'Está em Célula: ${rota.estaEmCelula}',
                                        style: const TextStyle(
                                          color: Colors.black,
                                          fontWeight: FontWeight.bold,
                                        ),
                                      ),
                                    ],
                                  ),
                                  Row(
                                    children: [
                                      Text(
                                        'Data Inscrição UDV: ${rota.dataInscricaoUniVida}',
                                        style: const TextStyle(
                                          color: Colors.black,
                                          fontWeight: FontWeight.bold,
                                        ),
                                      ),
                                    ],
                                  ),
                                ],
                              ),
                              trailing: IconButton(
                                onPressed: () {
                                  rotaDaVidaProvider.setRotaSelecionada(
                                      rota, index);
                                  context.push('/createrRota');
                                },
                                icon: const Icon(
                                  Icons.edit,
                                  color: Colors.black,
                                ),
                              ),
                            ),
                          ),
                        );
                      },
                    ),
                  ),
                ],
              ),
      ),
    );
  }
}

/*import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:i12mobile/data/provider/escada_do_sucesso_provider/rota_da_vida_provider.dart';
import 'package:i12mobile/data/shared/model/ganhar/rota_da_vida_models.dart';
import 'package:provider/provider.dart';

import '../../../../../../core/themes/global_colors.dart';

class RotaDaVidaPage extends StatelessWidget {
  const RotaDaVidaPage({super.key});

  Future<void> carregarRotas(RotaDaVidaProvider provider) async {
    String pessoa = "";
    String estaEmCelula = "";
    String dataInscricaoUniVida = "";
    await provider.listRotaDaVida(pessoa, estaEmCelula, dataInscricaoUniVida);
  }

  @override
  Widget build(BuildContext context) {
    RotaDaVidaProvider rotaDaVidaProvider = Provider.of<RotaDaVidaProvider>(context, listen: false);

    return Scaffold(
      appBar: AppBar(
        iconTheme: const IconThemeData(color: Colors.white),
        backgroundColor: GlobalColor.AzulEscuroClaroColor,
        centerTitle: true,
        title: const Text(
          'Rota Da Vida',
          style: TextStyle(
            fontSize: 22,
            fontWeight: FontWeight.bold,
            color: Colors.white,
          ),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(10),
        child: FutureBuilder(
          future: carregarRotas(rotaDaVidaProvider),
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return const Center(child: CircularProgressIndicator());
            } else if (snapshot.hasError) {
              return Center(child: Text('Erro ao carregar dados: ${snapshot.error}'));
            } else {
              List<RotaDaVidaModels> rotasvidas = rotaDaVidaProvider.rotas;

              if (rotasvidas.isEmpty) {
                return const Center(child: Text('Nenhuma rota encontrada.'));
              }

              return Column(
                children: [
                  const SizedBox(height: 10),
                  Expanded(
                    child: ListView.builder(
                      itemCount: rotasvidas.length,
                      itemBuilder: (BuildContext contextBuilder, indexRotaVida) {
                        return Container(
                          decoration: const BoxDecoration(
                            border: Border(bottom: BorderSide(width: 0.4)),
                          ),
                          margin: const EdgeInsets.only(bottom: 10),
                          child: Container(
                            decoration: BoxDecoration(
                              color: Colors.grey,
                              borderRadius: BorderRadius.circular(12),
                            ),
                            child: ListTile(
                              title: Text(
                                'N: ${rotasvidas[indexRotaVida].pessoa.nome}',
                                style: const TextStyle(
                                  color: Colors.black,
                                  fontWeight: FontWeight.bold,
                                  fontSize: 15
                                ),
                              ),
                              subtitle: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Row(
                                    children: [
                                      /*Text(
                                        'Des: ${rotasvidas[indexRotaVida].pessoa.descendencia.sigla}',
                                        style: const TextStyle(
                                          color: Colors.black,
                                          fontWeight: FontWeight.bold,
                                        ),
                                      ),
                                      const SizedBox(width: 15),*/
                                      Text(
                                        'Está em Celula: ${rotasvidas[indexRotaVida].estaEmCelula}',
                                        style: const TextStyle(
                                          color: Colors.black,
                                          fontWeight: FontWeight.bold,
                                        ),
                                      ),
                                    ],
                                  ),
                                  Row(
                                    children: [
                                      Text(
                                        'Data Inscrição UDV: ${rotasvidas[indexRotaVida].dataInscricaoUniVida}',
                                        style: const TextStyle(
                                          color: Colors.black,
                                          fontWeight: FontWeight.bold,
                                        ),
                                      ),
                                      const SizedBox(width: 15),
                                    ],
                                  ),
                                ],
                              ),
                              trailing: IconButton(
                                onPressed: () {
                                  rotaDaVidaProvider.setRotaSelecionada(rotasvidas[indexRotaVida], indexRotaVida);
                                  context.push('/createrRota');
                                },
                                icon: const Icon(Icons.edit, color: Colors.black),
                              ),
                            ),
                          ),
                        );
                      },
                    ),
                  ),
                ],
              );
            }
          },
        ),
      ),
    );
  }
}*/
