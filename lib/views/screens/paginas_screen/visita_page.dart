import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:i12mobile/data/provider/escada_do_sucesso_provider/visitas_provider.dart';
import 'package:provider/provider.dart';
import '../../../domain/core/themes/global_colors.dart';
import '../../../domain/models/model/ganhar/visita_detalhe_models.dart';

class NovaLifePage extends StatefulWidget {
  const NovaLifePage({super.key});

  @override
  _NovaLifePageState createState() => _NovaLifePageState();
}

class _NovaLifePageState extends State<NovaLifePage> {
  List<VisitaDetalheModels> allVisitantes = [];
  List<VisitaDetalheModels> filteredVisitantes = [];
  TextEditingController searchController = TextEditingController();

  late VisitaDetalheProvider visitaProvider;

  @override
  void initState() {
    super.initState();

    // Salvar a referência do provider no initState
    WidgetsBinding.instance.addPostFrameCallback((_) {
      visitaProvider =
          Provider.of<VisitaDetalheProvider>(context, listen: false);
      visitaProvider.listVisita("", "", "", "", "", "", "", "", "");
      visitaProvider.addListener(_updateVisitantesList);
    });
  }

  @override
  Widget build(BuildContext context) {
    VisitaDetalheProvider visitaProvider =
        Provider.of<VisitaDetalheProvider>(context);
    List<VisitaDetalheModels> lifes = visitaProvider.lifes;

    lifes = lifes.map((lifesNome) {
      lifesNome.pessoa.nome = corrigirTexto(lifesNome.pessoa.nome);
      lifesNome.convidadoPor = corrigirTexto(lifesNome.convidadoPor);
      return lifesNome;
    }).toList();

    return Scaffold(
        backgroundColor: Colors.white,
        appBar: AppBar(
          iconTheme: const IconThemeData(color: Colors.white),
          backgroundColor: GlobalColor.backGroudPrincipal,
          title: Text(
            'Nova Vida',
            style: TextStyle(
              fontSize: 22,
              fontWeight: FontWeight.bold,
              color: Colors.white,
            ),
          ),
        ),
        body: visitaProvider.lifes.isEmpty
            ? Center(
                child: CircularProgressIndicator(
                color: GlobalColor.backGroudPrincipal,
              ))
            : SafeArea(
                child: Column(
                  children: [
                    // Campo de busca
                    Container(
                      decoration: BoxDecoration(
                        borderRadius:
                            BorderRadius.vertical(bottom: Radius.circular(20)),
                        // borderRadius: BorderRadius.circular(25),
                        color: GlobalColor.backGroudPrincipal,
                      ),
                      padding: const EdgeInsets.all(16.0),
                      child: Container(
                        decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(25)),
                        child: SizedBox(
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
                                borderSide:
                                    const BorderSide(color: Colors.black),
                              ),
                            ),
                            onChanged: (query) {
                              _filterVisitantes(query);
                            },
                          ),
                        ),
                      ),
                    ),

                    Expanded(
                      child: Container(
                        color: Colors.white,
                        child: Padding(
                          padding: const EdgeInsets.all(13),
                          child: ListView.builder(
                            itemCount: filteredVisitantes.length,
                            itemBuilder: (context, index) {
                              filteredVisitantes.sort((a, b) => a.pessoa.nome
                                  .trim()
                                  .toLowerCase()
                                  .compareTo(
                                      b.pessoa.nome.trim().toLowerCase()));

                              final visitante = filteredVisitantes[index];
                              return Container(
                                decoration: const BoxDecoration(
                                  border:
                                      Border(bottom: BorderSide(width: 0.4)),
                                ),
                                child: Container(
                                  decoration: BoxDecoration(
                                    color: Colors.grey.shade300,
                                    borderRadius: BorderRadius.circular(12),
                                  ),
                                  margin: const EdgeInsets.only(bottom: 10),
                                  child: ListTile(
                                    subtitle: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Text(
                                          'Nome: ${visitante.pessoa.nome}',
                                          style: const TextStyle(
                                              color: Colors.black,
                                              fontWeight: FontWeight.bold,
                                              fontSize: 14),
                                        ),
                                        Text(
                                          'Data Visita: ${visitante.dataUltimaVisita}',
                                          style: const TextStyle(
                                            color: Colors.black,
                                            fontWeight: FontWeight.bold,
                                          ),
                                        ),
                                        _buildStatusTag(
                                            visitante.tipoConversao.descricao),
                                      ],
                                    ),
                                    trailing: IconButton(
                                      onPressed: () {
                                        visitaProvider.lifesSelected =
                                            visitante;
                                        visitaProvider.indexLifes = index;
                                        context.push('/createrVisitante');
                                      },
                                      icon: const Icon(Icons.edit,
                                          color: Colors.black),
                                      iconSize: 20,
                                    ),
                                  ),
                                ),
                              );
                            },
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
        floatingActionButton: FloatingActionButton.extended(
          onPressed: () {
            visitaProvider.indexLifes = null;
            context.push('/createrVisitante');
          },
          label: Text(
            'Nova Visita',
            style: TextStyle(color: Colors.white),
          ),
          icon: Icon(Icons.add, color: Colors.white),
          backgroundColor: HexColor('#2684b4'),
        ));
  }

  @override
  void dispose() {
    // Remover o listener sem acessar o contexto
    visitaProvider.removeListener(_updateVisitantesList);
    searchController.dispose();
    super.dispose();
  }

  void _updateVisitantesList() {
    setState(() {
      allVisitantes = visitaProvider.lifes;
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

  // Widget para construir a tag de situação
  Widget _buildStatusTag(String? situacao) {
    if (situacao == null || situacao.isEmpty) {
      return const SizedBox
          .shrink(); // Não mostra nada se a situação for nula ou vazia
    }

    Color bgColor;
    Color textColor;
    String tagText;

    // Lógica para definir cores com base na situação (adaptar conforme suas categorias)
    if (situacao.toLowerCase().contains('novo convertido')) {
      // Exemplo de condição
      bgColor = Colors.green[100]!;
      textColor = Colors.green[800]!;
      tagText = 'NOVO CONVERTIDO';
    } else if (situacao.toLowerCase().contains('visitante')) {
      // Exemplo de condição
      bgColor = Colors.orange[100]!;
      textColor = Colors.orange[800]!;
      tagText = 'VISITANTE';
    } else {
      // Cores padrão para outras situações
      bgColor = GlobalColor.backGroudPrincipal;
      textColor = Colors.white;
      tagText = situacao.toUpperCase(); // Mostra o texto da situação como tag
    }

    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 8.0, vertical: 4.0),
      decoration: BoxDecoration(
        color: bgColor,
        borderRadius: BorderRadius.circular(12.0),
      ),
      child: Text(
        tagText,
        style: TextStyle(
          color: textColor,
          fontSize: 12.0,
          fontWeight: FontWeight.bold,
        ),
      ),
    );
  }
}
