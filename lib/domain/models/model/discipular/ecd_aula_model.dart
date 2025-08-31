import 'package:i12mobile/domain/models/model/base_model.dart';
import 'package:i12mobile/domain/models/model/discipular/ecd_licao_model.dart';
import 'package:i12mobile/domain/models/model/pessoas_models.dart';
import 'package:i12mobile/domain/models/shared/descrition_model.dart';
import '../../shared/endereco_model.dart';
import '../descendencia.dart';
import '../igreja.dart';
import '../pessoas_discipulos_models.dart';
import 'ecd_aluno_frequencia.dart';
import 'ecd_model.dart';
import 'ecd_modulo_model.dart';

class EcdAula extends BaseModel {
  final EcdModel escola;
  final EcdLicao licao;
  final Descrition aulaTipo;
  final PessoasModels professor;
  final List<EcdAlunoFrequencia> alunos;
  final String dataAula;

  EcdAula(
      {required super.id,
      required super.descritionDto,
      required this.escola,
      required this.licao,
      required this.aulaTipo,
      required this.professor,
      this.alunos = const [],
      required this.dataAula});

  factory EcdAula.fromJson(Map<String, dynamic> json) {
    return EcdAula(
      id: json['id'] ?? '',
      descritionDto: json['descritionDto'],
      /*!= null
          ? Descrition(json['descritionDto'], id: '', descricao: '')
          : Descrition('', descricao: '', id: ''),*/
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
              localAula: ''),
      licao: json['licao'] != null
          ? EcdLicao.fromJson(json['licao'])
          : EcdLicao(
              id: '',
              descritionDto: Descrition(descricao: '', id: ''),
              descricao: '',
              modulo: EcdModulo(
                  id: '',
                  descritionDto: Descrition(descricao: '', id: ''),
                  descricao: '',
                  nivel: 0,
                  livro: 0),
              capitulo: 0),
      aulaTipo: json['aulaTipo'] is Map<String, dynamic>
          ? Descrition.fromJson(json['aulaTipo'])
          : Descrition(descricao: '', id: ''),
      professor: json['professor'] != null
          ? PessoasModels.fromJson(json['professor'])
          : PessoasModels(
              igreja: json['igreja'] != null
                  ? IgrejaModels.fromJson(json['igreja'])
                  : IgrejaModels.empty(),
              id: json['id'] ?? '',
              descritionDto: json['descritionDto'],
              nome: '',
              sexo: '',
              descendencia: DescendenciaModels(
                  lider1: PessoasModels.empty(),
                  lider2: PessoasModels.empty(),
                  descricao: '',
                  sigla: '',
                  id: '',
                  descritionDto: Descrition(id: '', descricao: ''),
                  igreja: IgrejaModels.empty()),
              lider: '',
              telefone: '',
              dataNascimento: DateTime(1900, 1, 1),
              idade: 0,
              endereco: Endereco.empty(),
              totalCelulas: 0,
              pessoasDiscipulos: PessoasDiscipulosModels.empty()),
      alunos: json['alunos'] != null
          ? (json['alunos'] as List)
              .map((aluno) => EcdAlunoFrequencia.fromJson(aluno))
              .toList()
          : [],
      dataAula: json['dataAula'] ?? '',
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'descritionDto': descritionDto.toJson(),
      'id': id,
      'escola': escola.toJson(),
      'licao': licao.toJson(),
      'aulaTipo': aulaTipo.toJson(),
      'professor': professor.toJson(),
      'alunos': alunos.map((aluno) => aluno.toJson()).toList(),
      'dataAula': dataAula
    };
  }
}
