class SituacaoModel {
  final String id;
  final String descricao;

  SituacaoModel({required this.id, required this.descricao});

  factory SituacaoModel.fromJson(Map<String, dynamic> json) {
    return SituacaoModel(
      id: json['id'],
      descricao: json['descricao'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'descricao': descricao,
    };
  }
}
