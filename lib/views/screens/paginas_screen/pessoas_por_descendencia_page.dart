import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../../data/provider/gestao_de_pessoas_providers/pessoas_provider.dart';
import '../../../domain/core/themes/global_colors.dart';
import '../../../domain/models/model/pessoas_models.dart';

class PessoasPorDescendenciaPage extends StatelessWidget {
  final String sigla;

  const PessoasPorDescendenciaPage({Key? key, required this.sigla})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    final pessoaProvider = Provider.of<PessoaProvider>(context);
    print(
        'Lista total de pessoas carregadas: ${pessoaProvider.pessoas.length}');

    List<PessoasModels> pessoas = pessoaProvider.pessoas
        .where((p) => p.descendencia.sigla.toLowerCase() == sigla.toLowerCase())
        .toList();

    pessoas.sort((a, b) {
      // Extrai apenas os números das siglas usando regex
      final int numA =
          int.tryParse(RegExp(r'\d+').stringMatch(a.nome) ?? '0') ?? 0;
      final int numB =
          int.tryParse(RegExp(r'\d+').stringMatch(b.nome) ?? '0') ?? 0;

      // Compara os números extraídos
      return numA.compareTo(numB);
    });

    pessoas = pessoas.map((pessoa) {
      pessoa.nome = corrigirTexto(pessoa.nome);
      return pessoa;
    }).toList();

    pessoas
        .sort((a, b) => a.nome.toLowerCase().compareTo(b.nome.toLowerCase()));

    print(pessoaProvider.pessoas); // Para verificar os dados carregados

    pessoaProvider.pessoas.forEach((p) {
      print('Nome: ${p.nome}, Descendência: ${p.descendencia.sigla}');
    });

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
