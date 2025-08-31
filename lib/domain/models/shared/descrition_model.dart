// ignore_for_file: camel_case_types

class Descrition {
  final String descricao;
  final String id;

  Descrition({required this.descricao, required this.id});

  factory Descrition.fromJson(Map<String, dynamic> json) {
    return Descrition(
      id: json['id'] ?? '',
      descricao: json['descricao'] ?? '',
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'descricao': descricao,
    };
  }

  // Método para verificar se a descrição é vazia
  bool isEmpty() {
    return descricao.isEmpty && id.isEmpty;
  }
}
