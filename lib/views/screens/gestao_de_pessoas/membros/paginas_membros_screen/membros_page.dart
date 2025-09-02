import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:provider/provider.dart';
import '../../../../../data/provider/gestao_de_pessoas_providers/pessoas_provider.dart';
import '../../../../../domain/models/model/pessoas_models.dart';
import '../../../../../domain/models/model/descendencia.dart';
import '../../../../../domain/core/themes/global_colors.dart';

class MembrosPage extends StatefulWidget {
  final String? igrejaId;
  const MembrosPage({super.key, this.igrejaId});

  @override
  _MembrosPageState createState() => _MembrosPageState();
}

class _MembrosPageState extends State<MembrosPage> {
  List<PessoasModels> allMembros = [];
  List<PessoasModels> filteredMembros = [];
  TextEditingController searchController = TextEditingController();
  late PessoaProvider pessoaProvider;

  @override
  void initState() {
    super.initState();
    print("📍 IgrejaId recebido em MembrosPage: ${widget.igrejaId}");
    pessoaProvider = context.read<PessoaProvider>();
    pessoaProvider.addListener(_updateMembrosList);

    WidgetsBinding.instance.addPostFrameCallback((_) async {
      // Carrega a lista de membros
      await pessoaProvider.listPessoas();
      _updateMembrosList();

      // Carrega descendências da igreja, se o ID existir
      if (widget.igrejaId != null && widget.igrejaId!.isNotEmpty) {
        await pessoaProvider.listDescendencia(widget.igrejaId);
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    List<PessoasModels> membros = pessoaProvider.pessoas;
    // ignore: unused_local_variable
    final List<DescendenciaModels> descendencias = pessoaProvider.descendencias;

    membros = membros.map((m) {
      m.nome = corrigirTexto(m.nome);
      return m;
    }).toList();

    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        iconTheme: const IconThemeData(color: Colors.white),
        backgroundColor: GlobalColor.backGroudPrincipal,
        title: const Text(
          'Membros',
          style: TextStyle(
              fontSize: 22, fontWeight: FontWeight.bold, color: Colors.white),
        ),
      ),
      body: membros.isEmpty
          ? Center(
              child: CircularProgressIndicator(
              color: GlobalColor.backGroudPrincipal,
            ))
          : SafeArea(
              child: Column(
                children: [
                  // Campo de pesquisa
                  Container(
                    decoration: BoxDecoration(
                      borderRadius:
                          BorderRadius.vertical(bottom: Radius.circular(20)),
                      color: GlobalColor.backGroudPrincipal,
                    ),
                    padding: const EdgeInsets.all(16),
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
                            labelText: 'Pesquisar Membro',
                            labelStyle: const TextStyle(
                                fontWeight: FontWeight.bold, fontSize: 15),
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(30),
                            ),
                          ),
                          onChanged: _filterMembros,
                        ),
                      ),
                    ),
                  ),

                  // Lista de membros
                  Expanded(
                    child: Container(
                      color: Colors.white,
                      child: Padding(
                        padding: const EdgeInsets.all(13),
                        child: ListView.builder(
                          itemCount: filteredMembros.length,
                          itemBuilder: (context, index) {
                            final membro = filteredMembros[index];
                            return Container(
                              decoration: const BoxDecoration(
                                  border:
                                      Border(bottom: BorderSide(width: 0.4))),
                              child: Container(
                                decoration: BoxDecoration(
                                  color: Colors.grey.shade300,
                                  borderRadius: BorderRadius.circular(12),
                                ),
                                margin: const EdgeInsets.only(bottom: 10),
                                child: ListTile(
                                  title: Text(
                                    membro.nome,
                                    style: const TextStyle(
                                        fontWeight: FontWeight.bold,
                                        fontSize: 14),
                                  ),
                                  subtitle: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Text(
                                        'Sexo: ${membro.sexo}',
                                        style: const TextStyle(
                                            fontWeight: FontWeight.bold),
                                      ),
                                      Text(
                                        'Descendência: ${membro.descendencia.sigla}',
                                        style: const TextStyle(
                                            fontWeight: FontWeight.bold),
                                      ),
                                    ],
                                  ),
                                  trailing: Row(
                                    mainAxisSize: MainAxisSize.min,
                                    children: [
                                      IconButton(
                                        onPressed: () {
                                          pessoaProvider.pessoaSelected =
                                              membro;
                                          pessoaProvider.indexPessoa = index;
                                          context.push('/createrPessoa');
                                        },
                                        icon: const Icon(Icons.edit),
                                      ),
                                      IconButton(
                                        onPressed: () {
                                          pessoaProvider.pessoaSelected =
                                              membro;
                                          pessoaProvider.indexPessoa = index;
                                          context.push('/viewPessoas');
                                        },
                                        icon: const Icon(Icons.visibility),
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
                  ),
                ],
              ),
            ),
      floatingActionButton: FloatingActionButton.extended(
        onPressed: () {
          pessoaProvider.indexPessoa = null;
          context.push('/createrMembro/${widget.igrejaId}');
        },
        label: const Text(
          'Novo Membro',
          style: TextStyle(color: Colors.white),
        ),
        icon: const Icon(Icons.add, color: Colors.white),
        backgroundColor: HexColor('#2684b4'),
      ),
    );
  }

  @override
  void dispose() {
    pessoaProvider.removeListener(_updateMembrosList);
    searchController.dispose();
    super.dispose();
  }

  void _updateMembrosList() {
    if (!mounted) return;
    setState(() {
      allMembros = List.from(pessoaProvider.pessoas);
      allMembros.sort((a, b) =>
          a.nome.trim().toLowerCase().compareTo(b.nome.trim().toLowerCase()));
      filteredMembros = List.from(allMembros);
    });
  }

  void _filterMembros(String query) {
    setState(() {
      if (query.isEmpty) {
        filteredMembros = List.from(allMembros);
      } else {
        filteredMembros = allMembros
            .where((m) => m.nome.toLowerCase().contains(query.toLowerCase()))
            .toList();
      }
    });
  }

  String corrigirTexto(String texto) {
    try {
      return utf8.decode(texto.runes.toList());
    } catch (_) {
      return texto;
    }
  }
}
