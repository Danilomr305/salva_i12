// ignore_for_file: camel_case_types

class Descrition {
  final String descricao;
  final String id;

  Descrition({required this.descricao, required this.id});

  // Método para criar um objeto a partir de um JSON
  factory Descrition.fromJson(Map<String, dynamic> json) {
    return Descrition(
      // O parâmetro 'text' não parece ter um propósito específico
      id: json['id'] ?? '', // Garante que 'id' nunca será null
      descricao:
          json['descricao'] ?? '', // Garante que 'descricao' nunca será null
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'descrition': descricao,
    };
  }
}
