import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:i12mobile/data/provider/cadastros_provides/descendencia_provider.dart';
import 'package:provider/provider.dart';
import '../../../../../data/provider/gestao_de_pessoas_providers/pessoas_provider.dart';
import '../../../../../domain/models/model/descendencia.dart';
import '../../../../../domain/core/themes/global_colors.dart';

class DescendenciaPage extends StatefulWidget {
  const DescendenciaPage({super.key});

  @override
  _DescendenciaPageState createState() => _DescendenciaPageState();
}

class _DescendenciaPageState extends State<DescendenciaPage> {
  @override
  void initState() {
    super.initState();
    _loadDescendencias();
  }

  Future<void> _loadDescendencias() async {
    final userDescendencia =
        Provider.of<DescendenciaProvider>(context, listen: false);
    String descricao = ""; // Substitua por valores apropriados
    String siglas = ""; // Substitua por valores apropriados
    try {
      await userDescendencia.listDescendecia(descricao, siglas);
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Erro ao carregar descendências: $e')),
      );
    }
  }

  String corrigirTexto(String texto) {
    try {
      // Se a string estiver corrompida, tente corrigir a codificação
      return utf8.decode(texto.runes.toList());
    } catch (e) {
      return texto; // Retorna o texto original se não puder corrigir
    }
  }

  @override
  Widget build(BuildContext context) {
    final userDescendencia = Provider.of<DescendenciaProvider>(context);
    List<DescendenciaModels> descendencias = userDescendencia.descendencias;

    // Ordena a lista numericamente pela propriedade `sigla`
    descendencias.sort((a, b) {
      // Extrai apenas os números das siglas usando regex
      final int numA =
          int.tryParse(RegExp(r'\d+').stringMatch(a.sigla) ?? '0') ?? 0;
      final int numB =
          int.tryParse(RegExp(r'\d+').stringMatch(b.sigla) ?? '0') ?? 0;

      // Compara os números extraídos
      return numA.compareTo(numB);
    });

    descendencias = descendencias.map((descendencia) {
      //descendencia. = corrigirTexto(descendencia.descricao);
      return descendencia;
    }).toList();

    return Scaffold(
      appBar: AppBar(
        iconTheme: const IconThemeData(color: Colors.white),
        backgroundColor: GlobalColor.AzulEscuroClaroColor,
        centerTitle: true,
        title: const Text(
          'Descendências',
          style: TextStyle(
              fontSize: 22, fontWeight: FontWeight.bold, color: Colors.white),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(15),
        child: Column(
          children: [
            const SizedBox(height: 10),
            Expanded(
              child: ListView.builder(
                itemCount: descendencias.length,
                itemBuilder: (BuildContext context, int index) {
                  final descendencia = descendencias[index];
                  return InkWell(
                    onTap: () async {
                      final pessoaProvider =
                          Provider.of<PessoaProvider>(context, listen: false);
                      await pessoaProvider.listPessoas();
                      context.push('/pessoasDescendencia',
                          extra: descendencia.sigla);
                    },
                    child: Container(
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
                            'Descrição: ${descendencia.descricao}',
                            style: const TextStyle(
                                fontWeight: FontWeight.bold, fontSize: 14),
                          ),
                          subtitle: Text(
                            'Sigla: ${descendencia.sigla}',
                            style: const TextStyle(
                                fontWeight: FontWeight.bold,
                                color: Colors.black),
                          ),
                          trailing: Row(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              IconButton(
                                onPressed: () {
                                  userDescendencia.descendenciaSelected =
                                      descendencia;
                                  userDescendencia.indexDescendencia = index;
                                  context.push('/createrDescendencia');
                                },
                                icon:
                                    const Icon(Icons.edit, color: Colors.black),
                                iconSize: 20,
                              ),
                              IconButton(
                                onPressed: () {
                                  userDescendencia.descendenciaSelected =
                                      descendencia;
                                  userDescendencia.indexDescendencia = index;
                                  context.push('/viewDescendencia');
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
                  );
                },
              ),
            ),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          userDescendencia.indexDescendencia = null;
          context.push('/createrDescendencia');
        },
        backgroundColor: Colors.black,
        child: const Icon(Icons.edit, color: Colors.white),
      ),
    );
  }
}
