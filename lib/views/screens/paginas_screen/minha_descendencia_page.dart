import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../../data/provider/gestao_de_pessoas_providers/pessoas_provider.dart';
import '../../../domain/core/themes/global_colors.dart';

class MinhaDescendenciaPage extends StatelessWidget {
  final String sigla;

  const MinhaDescendenciaPage({Key? key, required this.sigla})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    final pessoaProvider = Provider.of<PessoaProvider>(context);

    final pessoas = pessoaProvider.pessoas
        .where((p) => p.descendencia.sigla.toLowerCase() == sigla.toLowerCase())
        .map((p) {
      p.nome = corrigirTexto(p.nome);
      return p;
    }).toList()
      ..sort((a, b) => a.nome.toLowerCase().compareTo(b.nome.toLowerCase()));

    return Scaffold(
      appBar: AppBar(
        iconTheme: const IconThemeData(color: Colors.white),
        backgroundColor: GlobalColor.AzulEscuroClaroColor,
        centerTitle: true,
        title: Text(
          'Descendência $sigla',
          style: TextStyle(
              fontSize: 22, fontWeight: FontWeight.bold, color: Colors.white),
        ),
      ),
      body: pessoas.isEmpty
          ? const Center(child: Text('Nenhuma pessoa encontrada.'))
          : ListView.builder(
              itemCount: pessoas.length,
              itemBuilder: (context, index) {
                final pessoa = pessoas[index];
                return Padding(
                  padding: const EdgeInsets.only(left: 10, right: 10),
                  child: Column(
                    children: [
                      const SizedBox(height: 10),
                      Container(
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
                              'N: ${pessoa.nome}',
                              style: const TextStyle(
                                  fontWeight: FontWeight.bold,
                                  color: Colors.black),
                            ),
                            subtitle: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  'Sexo: ${pessoa.sexo}',
                                  style: const TextStyle(
                                      fontWeight: FontWeight.bold,
                                      color: Colors.black),
                                ),
                                Text(
                                  'Descndência: ${pessoa.descendencia.sigla}',
                                  style: const TextStyle(
                                      fontWeight: FontWeight.bold,
                                      color: Colors.black),
                                ),
                              ],
                            ),
                            onTap: () {
                              // Implementar navegação para detalhes da pessoa, se necessário
                            },
                          ),
                        ),
                      ),
                    ],
                  ),
                );
              },
            ),
    );
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
