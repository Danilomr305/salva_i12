import 'package:i12mobile/domain/models/model/base_model.dart';
import 'package:i12mobile/domain/models/model/consolidar/univida_model.dart';
import 'package:i12mobile/domain/models/model/igreja.dart';
import 'package:i12mobile/domain/models/model/pessoas_models.dart';

import '../../shared/descrition_model.dart';
import '../../shared/endereco_model.dart';
import '../descendencia.dart';
import '../pessoas_discipulos_models.dart';

class UniVidaAluno extends BaseModel {
  final IgrejaModels igreja;
  final PessoasModels pessoa;
  final UniVida universidadeDaVida;
  final bool comprouLivro;
  final String valorLivro;
  final bool comprouCamisa;
  final String valorPagoCamisa;
  final String dataInscricao;

  UniVidaAluno(
      {required super.id,
      required super.descritionDto,
      required this.igreja,
      required this.pessoa,
      required this.universidadeDaVida,
      required this.comprouLivro,
      required this.comprouCamisa,
      required this.valorLivro,
      required this.valorPagoCamisa,
      required this.dataInscricao});

  factory UniVidaAluno.fromJson(Map<String, dynamic> json) {
    print('JSON recebido: $json');
    // Verificar os valores de "comprouLivro" e "comprouCamisa" antes da conversão
    print('Valor original de comprouLivro: ${json['comprouLivro']}');
    print('Valor original de comprouCamisa: ${json['comprouCamisa']}');
    return UniVidaAluno(
      descritionDto: json['descritionDto'],
      id: json['id'] ?? '',
      igreja: json['igreja'] != null
          ? IgrejaModels.fromJson(json['igreja'])
          : IgrejaModels(
              razaoSocial: '',
              sigla: '',
              nomeFantasia: '',
              documento: '',
              id: '',
              descritionDto: Descrition(id: '', descricao: '')),
      pessoa: json['pessoa'] != null
          ? PessoasModels.fromJson(json['pessoa'])
          : PessoasModels(
              igreja: IgrejaModels.empty(),
              id: json['id'] ?? '',
              descritionDto: json['descritionDto'],
              nome: '',
              sexo: '',
              descendencia: DescendenciaModels(
                  lider1: PessoasModels.empty(),
                  lider2: PessoasModels.empty(),
                  descricao: '',
                  sigla: '',
                  igreja: IgrejaModels.empty(),
                  descritionDto: Descrition(id: '', descricao: ''),
                  id: ''),
              lider: '',
              telefone: '',
              dataNascimento: DateTime(1900, 1, 1),
              idade: 0,
              endereco: Endereco.empty(),
              totalCelulas: 0,
              pessoasDiscipulos: PessoasDiscipulosModels.empty()),
      universidadeDaVida: json['universidadeDaVida'] != null
          ? UniVida.fromJson(json['universidadeDaVida'])
          : UniVida(
              id: '',
              descritionDto: Descrition(id: '', descricao: ''),
              igreja: IgrejaModels(
                  razaoSocial: '',
                  sigla: '',
                  nomeFantasia: '',
                  documento: '',
                  id: '',
                  descritionDto: Descrition(id: '', descricao: '')),
              descricao: '',
              licaoAtual: '',
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
      valorLivro: json['valorLivro'] ?? '',
      valorPagoCamisa: json['valorPagoCamisa'] ?? '',
      dataInscricao: json['dataInscricao'] ?? '',
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'descritionDto': descritionDto.toJson(),
      'id': id,
      'igreja': igreja.toJson(),
      'pessoa': pessoa,
      'universidadeDaVida': universidadeDaVida.toJson(),
      'comprouLivro': comprouLivro,
      'comprouCamisa': comprouCamisa,
      'valorLivro': valorLivro,
      'valorPagoCamisa': valorPagoCamisa,
      'dataInscricao': dataInscricao
    };
  }
}
