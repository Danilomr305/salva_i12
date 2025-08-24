import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';

import '../../../../../data/provider/gestao_de_pessoas_providers/pessoas_provider.dart';
import '../../../../../domain/core/themes/global_colors.dart';
import '../../../../../domain/models/model/pessoas_models.dart';

class MembrosPage extends StatefulWidget {
  const MembrosPage({super.key});

  @override
  State<MembrosPage> createState() => _MembrosPageState();
}

class _MembrosPageState extends State<MembrosPage> {
  List<PessoasModels> allMembros = [];
  List<PessoasModels> filteredMembros = [];
  TextEditingController searchController = TextEditingController();
  late PessoaProvider pessoaProvider;

  @override
  void initState() {
    super.initState();

    pessoaProvider = context.read<PessoaProvider>();
    // escuta mudanças no provider
    pessoaProvider.addListener(_updateMembrosList);
    WidgetsBinding.instance.addPostFrameCallback((_) {
      pessoaProvider.listPessoas();
    });
  }

  @override
  Widget build(BuildContext context) {
    final pessoasProvider = Provider.of<PessoaProvider>(context);
    List<PessoasModels> membros = pessoasProvider.pessoas;

    membros = membros.map((membrosNome) {
      membrosNome.nome = corrigirTexto(membrosNome.nome);
      return membrosNome;
    }).toList();

    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        iconTheme: const IconThemeData(color: Colors.white),
        backgroundColor: GlobalColor.backGroudPrincipal,
        title: Text(
          'Membros',
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
          : SafeArea(
              child: Column(
              children: [
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
                          labelText: 'Pesquisar Membros',
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
                          _filterMembros(query);
                        },
                      ),
                    ),
                  ),
                ),
                Expanded(
                    child: Container(
                  color: Colors.white,
                  child: Padding(
                    padding: EdgeInsetsGeometry.all(13),
                    child: ListView.builder(
                        itemCount: filteredMembros.length,
                        itemBuilder: (context, index) {
                          final membros = filteredMembros[index];
                          return Container(
                            decoration: const BoxDecoration(
                              border: Border(bottom: BorderSide(width: 0.4)),
                            ),
                            child: Container(
                              decoration: BoxDecoration(
                                color: Colors.grey.shade300,
                                borderRadius: BorderRadius.circular(12),
                              ),
                              margin: const EdgeInsets.only(bottom: 10),
                              child: ListTile(
                                subtitle: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      'Nome ${membros.nome}',
                                      style: const TextStyle(
                                          color: Colors.black,
                                          fontWeight: FontWeight.bold,
                                          fontSize: 14),
                                    ),
                                    Text(
                                      'Sexo: ${membros.sexo}',
                                      style: const TextStyle(
                                          fontWeight: FontWeight.bold,
                                          color: Colors.black),
                                    ),
                                    const SizedBox(width: 15),
                                    Text(
                                      'Desc: ${membros.descendencia.sigla}',
                                      style: const TextStyle(
                                          fontWeight: FontWeight.bold,
                                          color: Colors.black),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          );
                        }),
                  ),
                ))
              ],
            )),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          pessoasProvider.indexPessoa = null;
          context.push('/createrMembro');
        },
        backgroundColor: Colors.black,
        child: const Icon(Icons.edit, color: Colors.white),
      ),
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
    if (!mounted) return; // Verifica se o widget ainda está montado
    setState(() {
      allMembros = pessoaProvider.pessoas;
      allMembros.sort((a, b) => a.nome
          .trim()
          .toLowerCase()
          .compareTo(b.nome.trim().toLowerCase())); // Ordena aqui
      filteredMembros = allMembros; // Inicialmente, todos estão visíveis
    });
  }

  // Função para filtrar a lista com base na pesquisa
  void _filterMembros(String query) {
    setState(() {
      if (query.isEmpty) {
        filteredMembros = allMembros;
      } else {
        filteredMembros = allMembros
            .where((pessoa) =>
                pessoa.nome.toLowerCase().contains(query.toLowerCase()))
            .toList();
      }
    });
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
