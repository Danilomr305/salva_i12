// ignore_for_file: library_private_types_in_public_api

import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';
import '../../../../../data/provider/gestao_de_pessoas_providers/pessoas_provider.dart';
import '../../../../../domain/models/model/pessoas_models.dart';
import '../../../../../domain/core/themes/global_colors.dart';

class PessoaPage extends StatefulWidget {
  const PessoaPage({super.key});

  @override
  _PessoaPageState createState() => _PessoaPageState();
}

class _PessoaPageState extends State<PessoaPage> {
  late Future<List<PessoasModels>> futurePessoas;
  List<PessoasModels> allPessoas = [];
  List<PessoasModels> filteredPessoas = [];
  TextEditingController searchController = TextEditingController();
  late PessoaProvider pessoaProvider;

  @override
  void initState() {
    super.initState();
    pessoaProvider = context.read<PessoaProvider>();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      pessoaProvider.listPessoas();
      _loadPessoas();
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
      body: FutureBuilder<List<PessoasModels>>(
          future: futurePessoas, // Usar o Future inicializado no initState
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return const Center(child: CircularProgressIndicator());
            } else if (snapshot.hasError) {
              return Center(child: Text('Erro: ${snapshot.error}'));
            } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
              return const Center(child: Text('Nenhuma pessoa encontrada.'));
            } else {
              // Ordenar os dados alfabeticamente
              List<PessoasModels> pessoas = snapshot.data!;
              pessoas.sort((a, b) => a.nome
                  .trim()
                  .toLowerCase()
                  .compareTo(b.nome.trim().toLowerCase()));

              return Padding(
                padding: const EdgeInsets.only(
                    right: 8, left: 8, top: 10, bottom: 4),
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
                          _filterPessoas(query); // Atualiza a lista filtrada
                        },
                      ),
                    ),
                    const SizedBox(height: 20),
                    Expanded(
                      child: RefreshIndicator(
                        onRefresh:
                            _refreshData, // Função chamada ao arrastar para recarregar
                        child: ListView.builder(
                          itemCount: filteredPessoas.length,
                          itemBuilder:
                              (BuildContext contextBuilder, indexBuilder) {
                            final pessoa = filteredPessoas[indexBuilder];
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
                                        fontWeight: FontWeight.bold,
                                        fontSize: 13),
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
                                          pessoasProvider.pessoaSelected =
                                              pessoa;
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
                                          pessoasProvider.pessoaSelected =
                                              pessoa;
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
                    ),
                  ],
                ),
              );
            }
          }),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          pessoasProvider.indexPessoa = null;
          context.push('/createrPessoa');
        },
        backgroundColor: Colors.black,
        child: const Icon(Icons.edit, color: Colors.white),
      ),
    );
  }

  // Função para carregar os dados das pessoas
  void _loadPessoas() async {
    final userProvider = Provider.of<PessoaProvider>(context, listen: false);
    await userProvider.listPessoas(); // Chamada assíncrona
    futurePessoas.then((pessoas) {
      setState(() {
        allPessoas = pessoas;
        filteredPessoas = pessoas; // No início, todos os itens estão visíveis
      });
    });
  }

  // Função para filtrar a lista com base na pesquisa
  void _filterPessoas(String query) {
    setState(() {
      if (query.isEmpty) {
        filteredPessoas = allPessoas;
      } else {
        filteredPessoas = allPessoas
            .where((pessoa) =>
                pessoa.nome.toLowerCase().contains(query.toLowerCase()))
            .toList();
      }
    });
  }

  // Função chamada ao recarregar a página
  Future<void> _refreshData() async {
    // Aqui você pode recarregar os dados da API
    _loadPessoas(); // Recarrega os dados
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
