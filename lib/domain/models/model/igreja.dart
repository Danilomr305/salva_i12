class IgrejaModels {
  late String razaoSocial;
  late String sigla;
  late String nomeFantasia;
  late String documento;
  

  IgrejaModels({
    required this.razaoSocial,
    required this.sigla,
    required this.nomeFantasia,
    required this.documento,
    
  });

  factory IgrejaModels.fromJson(Map<String, dynamic> json) {
  return IgrejaModels(
    razaoSocial: json['razaoSocial']?.toString() ?? '', // Converte para String ou usa string vazia se for null
    sigla: json['sigla']?.toString() ?? '', // Converte para String ou usa string vazia se for null
    nomeFantasia: json['nomeFantasia']?.toString() ?? '', // Converte para String ou usa string vazia se for null
    documento: json['documento']?.toString() ?? '', // Converte para String ou usa string vazia se for null
  );
}


  Map<String, dynamic> toJson() {
    return {
      'razaoSocial': razaoSocial,
      'sigla': sigla,
      'nomeFantasia': nomeFantasia,
      'documento': documento,
    };
  }
}