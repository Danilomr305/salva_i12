// ignore_for_file: avoid_print

import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

class PesquisaUtils extends SearchDelegate<String> {
  @override
  String get searchFieldLabel => "Pesquiser pelo nomes";

  @override
  List<Widget>? buildActions(BuildContext context) {
    return [
      IconButton(
          onPressed: () {
            query = '';
          },
          icon: const Icon(Icons.clear))
    ];
  }

  @override
  Widget? buildLeading(BuildContext context) {
    return IconButton(
        onPressed: () {
          close(context, '');
        },
        icon: const Icon(Icons.arrow_back));
  }

  @override
  Widget buildResults(BuildContext context) {
    return Container();
  }

  @override
  Widget buildSuggestions(BuildContext context) {
    return FutureBuilder<List>(
        future: sugestoes(),
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            return ListView.builder(
                itemCount: snapshot.data!.length,
                itemBuilder: (context, index) {
                  return ListTile(
                    title: Text(snapshot.data![index]['nome']),
                    subtitle: Row(
                      children: [
                        Text(
                          snapshot.data![index]['sexo'],
                          style: const TextStyle(fontWeight: FontWeight.bold),
                        ),
                        const SizedBox(
                          width: 15,
                        ),
                        Text(
                          snapshot.data![index]['descendencia'],
                          style: const TextStyle(fontWeight: FontWeight.bold),
                        )
                      ],
                    ),
                  );
                });
          } else if (snapshot.hasData) {
            return const Center(
              child: Text(
                'Erro ao pesquisar Produto!',
                style: TextStyle(fontWeight: FontWeight.bold, fontSize: 19),
              ),
            );
          }
          return const Center(
            child: CircularProgressIndicator(),
          );
        });
  }

  getTokenpessoas() async {
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    return sharedPreferences.get('token');
  }

  Future<List> sugestoes() async {
    var token = await getTokenpessoas();
    print('Token utilizado: $token');

    var url = Uri.parse('https://logos.eti.br/i12ws/comum/pessoas/find');
    Map<String, String> headers = {
      'Content-Type': 'application/json',
      'Authorization': token,
    };

    var response = await http.get(url, headers: headers);
    print(response.body);
    if (response.statusCode == 200) {
      return json.decode(response.body).map((produto) => produto).toList();
    }

    throw Exception('Erro ao solicitar o produto pesquisado');
  }
}
