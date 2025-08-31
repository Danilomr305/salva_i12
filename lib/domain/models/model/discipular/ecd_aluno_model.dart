import 'package:i12mobile/domain/models/model/base_model.dart';
import 'package:i12mobile/domain/models/model/pessoas_models.dart';
import '../../shared/descrition_model.dart';
import '../../shared/endereco_model.dart';
import '../descendencia.dart';
import '../igreja.dart';
import '../pessoas_discipulos_models.dart';
import 'ecd_model.dart';
import 'ecd_modulo_model.dart';

class EcdAluno extends BaseModel {
  final PessoasModels pessoa;
  final EcdModel escola;
  final bool comprouLivro;
  final num valorPagoLivro;
  final bool comprouCamisa;
  final num valorPagoCamisa;
  final String dataInscricao;

  EcdAluno(
      {required super.id,
      required super.descritionDto,
      required this.escola,
      required this.comprouLivro,
      required this.valorPagoLivro,
      required this.comprouCamisa,
      required this.pessoa,
      required this.valorPagoCamisa,
      required this.dataInscricao});

  factory EcdAluno.fromJson(Map<String, dynamic> json) {
    return EcdAluno(
        id: json['id'] ?? '',
        descritionDto: json['descritionDto'],
        escola: json['escola'] != null
            ? EcdModel.fromJson(json['escola'])
            : EcdModel(
                id: '',
                descritionDto: Descrition(descricao: '', id: ''),
                igreja: IgrejaModels(
                    razaoSocial: '',
                    sigla: '',
                    nomeFantasia: '',
                    documento: '',
                    id: '',
                    descritionDto: Descrition(id: '', descricao: '')),
                descricao: '',
                modulo: EcdModulo(
                    id: '',
                    descritionDto: Descrition(descricao: '', id: ''),
                    descricao: '',
                    nivel: 0,
                    livro: 0),
                dataInicio: '',
                dataConclusao: '',
                totalAlunos: 0,
                localAula: '',
              ),
        comprouLivro: json['comprouLivro'] != null
            ? (json['comprouLivro'] == 'S') // Tratar valor "S" como true
            : false,
        comprouCamisa: json['comprouCamisa'] != null
            ? (json['comprouCamisa'] == 'S') // Tratar valor "S" como true
            : false,
        valorPagoLivro: json['valorPagoLivro'] != null
            ? num.tryParse(json['valorPagoLivro'].toString()) ?? 0
            : 0,
        pessoa: json['pessoa'] != null
            ? PessoasModels.fromJson(json['pessoa'])
            : PessoasModels(
                id: json['id'] ?? '',
                descritionDto: json['descritionDto'],
                igreja: json['igreja'] != null
                    ? IgrejaModels.fromJson(json['igreja'])
                    : IgrejaModels.empty(),
                nome: '',
                sexo: '',
                descendencia: DescendenciaModels(
                    descricao: '',
                    sigla: '',
                    id: '',
                    descritionDto: Descrition(id: '', descricao: ''),
                    igreja: IgrejaModels.empty(),
                    lider1: PessoasModels.empty(),
                    lider2: PessoasModels.empty()),
                lider: '',
                telefone: '',
                dataNascimento: DateTime(1900, 1, 1),
                idade: 0,
                endereco: Endereco.empty(),
                totalCelulas: 0,
                pessoasDiscipulos: PessoasDiscipulosModels.empty()),
        valorPagoCamisa: json['valorPagoCamisa'] != null
            ? num.tryParse(json['valorPagoCamisa'].toString()) ?? 0
            : 0,
        dataInscricao: json['dataInscricao'] ?? '');
  }

  // Converter VisitaModel para Json
  Map<String, dynamic> toJson() {
    return {
      'descritionDto': descritionDto,
      'id': id,
      'pessoa': pessoa.toJson(),
      'escola': escola.toJson(),
      'comprouLivro': comprouLivro,
      'valorPagoCamisa': valorPagoCamisa,
      'comprouCamisa': comprouCamisa,
      'valorPagoLivro': valorPagoLivro,
      'dataInscricao': dataInscricao
    };
  }
}
