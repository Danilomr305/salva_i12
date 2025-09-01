// ignore_for_file: library_private_types_in_public_api

import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:provider/provider.dart';
import '../../../../../data/provider/gestao_de_pessoas_providers/pessoas_provider.dart';
import '../../../../../domain/models/model/pessoas_models.dart';
import '../../../../../domain/core/themes/global_colors.dart';

class PessoaPage extends StatefulWidget {
  final String? igrejaId;
  const PessoaPage({super.key, this.igrejaId});

  @override
  _PessoaPageState createState() => _PessoaPageState();
}

class _PessoaPageState extends State<PessoaPage> {
  List<PessoasModels> allMembros = [];
  List<PessoasModels> filteredMembros = [];
  TextEditingController searchController = TextEditingController();
  late PessoaProvider pessoaProvider;

  /*@override
  void initState() {
    super.initState();
    pessoaProvider = context.read<PessoaProvider>();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      pessoaProvider.listPessoas();
      _loadPessoas();
    });
  }*/

  @override
  void initState() {
    super.initState();

    pessoaProvider = context.read<PessoaProvider>();
    // escuta mudanças no provider
    pessoaProvider.addListener(_updateMembrosList);
    WidgetsBinding.instance.addPostFrameCallback((_) async {
      await pessoaProvider.listPessoas();
      _updateMembrosList();
    });
  }

  @override
  Widget build(BuildContext context) {
    final pessoasProvider = Provider.of<PessoaProvider>(context);
    List<PessoasModels> pessoas = pessoasProvider.pessoas;

    pessoas = pessoas.map((pessoaNome) {
      pessoaNome.nome = corrigirTexto(pessoaNome.nome);
      return pessoaNome;
    }).toList();

    return Scaffold(
      appBar: AppBar(
        backgroundColor: GlobalColor.AzulEscuroClaroColor,
        centerTitle: true,
        iconTheme: IconThemeData(color: Colors.white),
        title: const Text(
          'Pessoas',
          style: TextStyle(
            fontSize: 22,
            fontWeight: FontWeight.bold,
            color: Colors.white,
          ),
        ),
      ),
      body: pessoasProvider.pessoas.isEmpty
          ? Center(
              child: CircularProgressIndicator(
              color: GlobalColor.backGroudPrincipal,
            ))
          : Padding(
              padding:
                  const EdgeInsets.only(right: 8, left: 8, top: 10, bottom: 4),
              child: Column(
                children: [
                  SizedBox(
                    width: MediaQuery.of(context).size.width,
                    height: 50,
                    child: TextField(
                      controller: searchController,
                      decoration: InputDecoration(
                        prefixIcon: const Icon(Icons.search_outlined),
                        labelText: 'Pesquisar',
                        labelStyle: const TextStyle(
                          fontWeight: FontWeight.bold,
                          color: Colors.black,
                          fontSize: 15,
                        ),
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(30),
                          borderSide: const BorderSide(color: Colors.black),
                        ),
                      ),
                      onChanged: (query) {
                        _filterMembros(query); // Atualiza a lista filtrada
                      },
                    ),
                  ),
                  const SizedBox(height: 20),
                  Expanded(
                    child: ListView.builder(
                      itemCount: filteredMembros.length,
                      itemBuilder: (BuildContext contextBuilder, indexBuilder) {
                        final pessoa = filteredMembros[indexBuilder];
                        return Container(
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
                              title: Text(
                                pessoa.nome,
                                style: const TextStyle(
                                    fontWeight: FontWeight.bold, fontSize: 13),
                              ),
                              subtitle: Row(
                                children: [
                                  Text(
                                    'Sexo: ${pessoa.sexo}',
                                    style: const TextStyle(
                                        fontWeight: FontWeight.bold,
                                        color: Colors.black),
                                  ),
                                  const SizedBox(width: 15),
                                  Text(
                                    'Desc: ${pessoa.descendencia.sigla}',
                                    style: const TextStyle(
                                        fontWeight: FontWeight.bold,
                                        color: Colors.black),
                                  ),
                                ],
                              ),
                              trailing: Row(
                                mainAxisSize: MainAxisSize.min,
                                children: [
                                  IconButton(
                                    onPressed: () {
                                      pessoasProvider.pessoaSelected = pessoa;
                                      pessoasProvider.indexPessoa =
                                          indexBuilder;
                                      context.push('/createrPessoa');
                                    },
                                    icon: const Icon(Icons.edit,
                                        color: Colors.black),
                                    iconSize: 20,
                                  ),
                                  IconButton(
                                    onPressed: () {
                                      pessoasProvider.pessoaSelected = pessoa;
                                      pessoasProvider.indexPessoa =
                                          indexBuilder;
                                      context.push('/viewPessoas');
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
      floatingActionButton: FloatingActionButton.extended(
          onPressed: () {
            pessoasProvider.indexPessoa = null;
            context.push('/createrMembro/${widget.igrejaId}');
          },
          label: Text(
            'Nova Visita',
            style: TextStyle(color: Colors.white),
          ),
          icon: Icon(Icons.add, color: Colors.white),
          backgroundColor: HexColor('#2684b4')),
    );
  }

  @override
  void dispose() {
    // Remover o listener sem acessar o contexto
    pessoaProvider.removeListener(_updateMembrosList);
    searchController.dispose();
    super.dispose();
  }

  void _updateMembrosList() {
    if (!mounted) return;

    setState(() {
      // Usa o provider para preencher a lista
      allMembros = pessoaProvider.pessoas.map((p) {
        // Corrige nomes corrompidos
        p.nome = corrigirTexto(p.nome);
        return p;
      }).toList();

      // Ordena por nome
      allMembros.sort((a, b) =>
          a.nome.trim().toLowerCase().compareTo(b.nome.trim().toLowerCase()));

      // Inicialmente, todos visíveis
      filteredMembros = List.from(allMembros);
    });
  }

  // Função para filtrar a lista com base na pesquisa
  void _filterMembros(String query) {
    setState(() {
      if (query.isEmpty) {
        filteredMembros = List.from(allMembros);
      } else {
        filteredMembros = allMembros
            .where((p) => p.nome.toLowerCase().contains(query.toLowerCase()))
            .toList();
      }
    });
  }

  // Função de correção de texto com caracteres
  String corrigirTexto(String texto) {
    try {
      return utf8.decode(texto.runes.toList());
    } catch (e) {
      return texto;
    }
  }
}
