import '../shared/descrition_model.dart';
import '../shared/endereco_model.dart';
import 'base_model.dart';
import 'descendencia.dart';
import 'igreja.dart';
import 'pessoas_discipulos_models.dart';

class PessoasModels extends BaseModel {
  late String nome;
  final String sexo;
  final String telefone;
  final DateTime dataNascimento;
  final int idade;
  final Endereco endereco;
  final DescendenciaModels descendencia;
  final IgrejaModels igreja;
  final int totalCelulas;
  final PessoasDiscipulosModels pessoasDiscipulos;
  final String lider;

  PessoasModels({
    required this.nome,
    required this.sexo,
    required this.descendencia,
    required this.lider,
    required this.igreja,
    required super.id,
    required super.descritionDto,
    required this.telefone,
    required this.dataNascimento,
    required this.idade,
    required this.endereco,
    required this.totalCelulas,
    required this.pessoasDiscipulos,
  });

  // Construtor que cria um objeto a partir de um JSON
  factory PessoasModels.fromJson(Map<String, dynamic> json) {
    // Função auxiliar para converter a data no formato DD/MM/YYYY para DateTime
    DateTime parseData(String? data) {
      if (data == null || data.isEmpty) return DateTime(1900, 1, 1);
      try {
        final partes = data.split('/');
        if (partes.length != 3) return DateTime(1900, 1, 1);
        return DateTime(
          int.parse(partes[2]), // ano
          int.parse(partes[1]), // mês
          int.parse(partes[0]), // dia
        );
      } catch (e) {
        return DateTime(1900, 1, 1);
      }
    }

    return PessoasModels(
      id: json['id'] ?? '',
      igreja: json['igreja'] != null
          ? IgrejaModels.fromJson(json['igreja'])
          : IgrejaModels.empty(),
      descritionDto: json['descritionDto'] != null &&
              json['descritionDto'] is Map<String, dynamic>
          ? Descrition.fromJson(json['descritionDto'])
          : Descrition(id: '', descricao: ''),
      descendencia: json['descendencia'] != null
          ? DescendenciaModels.fromJson(json['descendencia'])
          : DescendenciaModels.empty(),
      nome: json['nome'] ?? '',
      lider: '',
      sexo: json['sexo'] ?? '',
      telefone: json['telefone'] ?? '',
      dataNascimento: parseData(json['dataNascimento']),
      idade: json['idade'] ?? 0,
      endereco: json['endereco'] != null
          ? Endereco.fromJson(json['endereco'])
          : Endereco.empty(),
      totalCelulas: json['totalCelulas'] ?? 0,
      pessoasDiscipulos: json['pessoasDiscipulos'] != null
          ? PessoasDiscipulosModels.fromJson(json['pessoasDiscipulos'])
          : PessoasDiscipulosModels.empty(),
    );
  }

  // Converte o objeto para JSON
  Map<String, dynamic> toJson() {
    String formatData(DateTime data) {
      return '${data.day.toString().padLeft(2, '0')}/'
          '${data.month.toString().padLeft(2, '0')}/'
          '${data.year}';
    }

    return {
      if (id.isNotEmpty) 'id': id,
      'nome': nome,
      'sexo': sexo,
      'telefone': telefone,
      if (dataNascimento != DateTime(1900, 1, 1))
        'dataNascimento': formatData(dataNascimento), // formato DD/MM/YYYY
      'idade': idade,
      if (igreja.id.isNotEmpty) 'igreja': igreja.toJson(),
      if (descritionDto.id.isNotEmpty) 'descritionDto': descritionDto.toJson(),
      if (descendencia.id.isNotEmpty) 'descendencia': descendencia.toJson(),
      if (lider.isNotEmpty) 'lider': lider,
      'totalCelulas': totalCelulas,
      'endereco': endereco.toJson(),
      'pessoasDiscipulos': pessoasDiscipulos.toJson(),
    };
  }

  // retorna um objeto vazio
  static PessoasModels empty() {
    return PessoasModels(
      id: '',
      nome: '',
      sexo: '',
      telefone: '',
      dataNascimento: DateTime(1900, 1, 1),
      idade: 0,
      endereco: Endereco.empty(),
      descendencia: DescendenciaModels.empty(),
      lider: '',
      descritionDto: Descrition(id: '', descricao: ''),
      igreja: IgrejaModels.empty(),
      totalCelulas: 0,
      pessoasDiscipulos: PessoasDiscipulosModels.empty(),
    );
  }

  // clona um objeto existente
  factory PessoasModels.fromPessoa(PessoasModels detalhe) {
    return PessoasModels(
      id: detalhe.id,
      nome: detalhe.nome,
      sexo: detalhe.sexo,
      telefone: detalhe.telefone,
      dataNascimento: detalhe.dataNascimento,
      idade: detalhe.idade,
      endereco: detalhe.endereco,
      descendencia: detalhe.descendencia,
      lider: detalhe.lider,
      descritionDto: detalhe.descritionDto,
      igreja: detalhe.igreja,
      totalCelulas: detalhe.totalCelulas,
      pessoasDiscipulos: detalhe.pessoasDiscipulos,
    );
  }
}
