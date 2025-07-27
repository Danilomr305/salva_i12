import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:i12mobile/data/provider/escada_do_sucesso_provider/nova_vida_provider.dart';
import 'package:i12mobile/domain/core/themes/global_colors.dart';
import 'package:provider/provider.dart';

import '../../../domain/models/model/ganhar/visita_models.dart';

class NovaLifePage extends StatefulWidget {
  const NovaLifePage({super.key});

  @override
  _NovaLifePageState createState() => _NovaLifePageState();
}

class _NovaLifePageState extends State<NovaLifePage> {
  List<VisitaModels> allVisitantes = [];
  List<VisitaModels> filteredVisitantes = [];
  TextEditingController searchController = TextEditingController();

  late NovaLifeProvider novaLifeProvider;

  @override
  void initState() {
    super.initState();

    // Salvar a referência do provider no initState
    WidgetsBinding.instance.addPostFrameCallback((_) {
      novaLifeProvider = Provider.of<NovaLifeProvider>(context, listen: false);
      novaLifeProvider.listNovaLifes(
        "",
        "",
        "",
        "",
        "",
        "",
        "",
        "",
        "",
      );
      novaLifeProvider.addListener(_updateVisitantesList);
    });
  }

  @override
  Widget build(BuildContext context) {
    NovaLifeProvider novaLifeProvider = Provider.of<NovaLifeProvider>(context);
    List<VisitaModels> lifes = novaLifeProvider.lifes;

    lifes = lifes.map((lifesNome) {
      lifesNome.pessoa.nome = corrigirTexto(lifesNome.pessoa.nome);
      lifesNome.convidadoPor = corrigirTexto(lifesNome.convidadoPor);
      return lifesNome;
    }).toList();

    return Scaffold(
      appBar: AppBar(
        backgroundColor: GlobalColor.AzulEscuroClaroColor,
        centerTitle: true,
        iconTheme: const IconThemeData(color: Colors.white),
        title: const Text(
          'Nova Vida',
          style: TextStyle(
            fontSize: 22,
            fontWeight: FontWeight.bold,
            color: Colors.white,
          ),
        ),
      ),
      body: novaLifeProvider.lifes.isEmpty
          ? const Center(child: CircularProgressIndicator())
          : SafeArea(
              child: Padding(
                padding: const EdgeInsets.all(10),
                child: Column(
                  children: [
                    // Campo de busca
                    SizedBox(
                      height: 50,
                      child: TextField(
                        controller: searchController,
                        decoration: InputDecoration(
                          prefixIcon: const Icon(Icons.search_outlined),
                          labelText: 'Pesquisar Visitante',
                          labelStyle: const TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 15,
                          ),
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(30),
                            borderSide: const BorderSide(color: Colors.black),
                          ),
                        ),
                        onChanged: (query) {
                          _filterVisitantes(query);
                        },
                      ),
                    ),
                    const SizedBox(height: 10),

                    // Lista de visitantes
                    Expanded(
                      child: ListView.builder(
                        itemCount: filteredVisitantes.length,
                        itemBuilder: (context, index) {
                          // Ordenar visitantes antes de construir os itens
                          filteredVisitantes.sort((a, b) => a.pessoa.nome
                              .trim()
                              .toLowerCase()
                              .compareTo(b.pessoa.nome.trim().toLowerCase()));

                          final visitante = filteredVisitantes[index];
                          return Container(
                            decoration: const BoxDecoration(
                              border: Border(bottom: BorderSide(width: 0.4)),
                            ),
                            child: Container(
                              decoration: BoxDecoration(
                                color: Colors.grey.shade200,
                                borderRadius: BorderRadius.circular(12),
                              ),
                              margin: const EdgeInsets.only(bottom: 10),
                              child: ListTile(
                                title: Text(
                                  'N: ${visitante.pessoa.nome}',
                                  style: const TextStyle(
                                      color: Colors.black,
                                      fontWeight: FontWeight.bold,
                                      fontSize: 14),
                                ),
                                subtitle: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      'Convidada por: ${visitante.convidadoPor}',
                                      style: const TextStyle(
                                        color: Colors.black,
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ),
                                    const SizedBox(width: 18),
                                    Text(
                                      'Data: ${visitante.dataUltimaVisita}',
                                      style: const TextStyle(
                                        color: Colors.black,
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ),
                                    const SizedBox(width: 18),
                                  ],
                                ),
                                trailing: Row(
                                  mainAxisSize: MainAxisSize.min,
                                  children: [
                                    IconButton(
                                      onPressed: () {
                                        novaLifeProvider.lifesSelected =
                                            visitante;
                                        novaLifeProvider.indexLifes = index;
                                        context.push('/createrVisitante');
                                      },
                                      icon: const Icon(Icons.edit,
                                          color: Colors.black),
                                      iconSize: 20,
                                    ),
                                    IconButton(
                                      onPressed: () {
                                        novaLifeProvider.lifesSelected =
                                            visitante;
                                        novaLifeProvider.indexLifes = index;
                                        context.push('/viewVisitante');
                                      },
                                      icon: const Icon(Icons.visibility,
                                          color: Colors.black),
                                      iconSize: 20,
                                    ),
                                  ],
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
            ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          novaLifeProvider.indexLifes = null;
          context.push('/createrVisitante');
        },
        backgroundColor: Colors.black,
        child: const Icon(
          Icons.edit,
          color: Colors.white,
        ),
      ),
    );
  }

  @override
  void dispose() {
    // Remover o listener sem acessar o contexto
    novaLifeProvider.removeListener(_updateVisitantesList);
    searchController.dispose();
    super.dispose();
  }

  void _updateVisitantesList() {
    setState(() {
      allVisitantes = novaLifeProvider.lifes;
      filteredVisitantes = allVisitantes; // Inicialmente, todos estão visíveis
    });
  }

  void _filterVisitantes(String query) {
    setState(() {
      if (query.isEmpty) {
        filteredVisitantes = allVisitantes;
      } else {
        filteredVisitantes = allVisitantes
            .where((visitante) => visitante.pessoa.nome
                .toLowerCase()
                .contains(query.toLowerCase()))
            .toList();
      }
    });
  }

  String corrigirTexto(String texto) {
    try {
      // Se a string estiver corrompida, tente corrigir a codificação
      return utf8.decode(texto.runes.toList());
    } catch (e) {
      return texto; // Retorna o texto original se não puder corrigir
    }
  }
}
