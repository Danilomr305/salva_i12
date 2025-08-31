class PessoasDiscipulosModels {
  final int totalGeral;
  final int totalDiretos;

  PessoasDiscipulosModels(
      {required this.totalGeral, required this.totalDiretos});

  factory PessoasDiscipulosModels.fromJson(Map<String, dynamic> json) {
    return PessoasDiscipulosModels(
        totalGeral: json['totalGeral'] ?? '',
        totalDiretos: json['totalDiretos']);
  }

  Map<String, dynamic> toJson() {
    return {
      'totalGeral': totalGeral,
      'toalDiretos': totalDiretos,
    };
  }

  static PessoasDiscipulosModels empty() {
    return PessoasDiscipulosModels(totalDiretos: 0, totalGeral: 0);
  }
}
