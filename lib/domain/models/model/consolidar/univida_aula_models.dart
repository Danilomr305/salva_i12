import 'package:i12mobile/domain/models/model/base_model.dart';
import 'package:i12mobile/domain/models/model/consolidar/univida_licao_model.dart';
import 'package:i12mobile/domain/models/model/consolidar/univida_model.dart';
import 'package:i12mobile/domain/models/model/consolidar/univida_semana_model.dart';
import 'package:i12mobile/domain/models/model/pessoas_models.dart';
import 'package:i12mobile/domain/models/shared/descrition_model.dart';
import '../../shared/endereco_model.dart';
import '../descendencia.dart';
import '../igreja.dart';
import '../pessoas_discipulos_models.dart';

class UniVidaAula extends BaseModel {
  final UniVida uniVida;
  final UniVidaLicao licao;
  final Descrition aulaTipo;
  final PessoasModels professor;
  final String dataAula;

  UniVidaAula({
    required super.id,
    required super.descritionDto,
    required this.uniVida,
    required this.aulaTipo,
    required this.professor,
    required this.dataAula,
    required this.licao,
  });

  factory UniVidaAula.fromJson(Map<String, dynamic> json) {
    return UniVidaAula(
      dataAula: json['dataAula'] ??
          '', // Valor padrão vazio caso 'dataAula' seja null
      descritionDto: json['descritionDto'] != null
          ? Descrition.fromJson(json['descritionDto'])
          : Descrition(id: '', descricao: ''),
      id: json['id'] ?? '',
      uniVida: json['uniVida'] != null
          ? UniVida.fromJson(json['uniVida'])
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
      aulaTipo: json['aulaTipo'] != null
          ? (json['aulaTipo'] is String
              ? Descrition(
                  descricao: json['aulaTipo'], id: '') // Caso seja uma String
              : Descrition.fromJson(
                  json['aulaTipo'] as Map<String, dynamic>)) // Caso seja um Map
          : Descrition(descricao: '', id: ''),
      professor: json['professor'] != null
          ? PessoasModels.fromJson(json['professor'])
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
      licao: json['licao'] != null
          ? UniVidaLicao.fromJson(json['licao'])
          : UniVidaLicao(
              iD: '',
              id: '',
              descricao: '',
              descritionDto: Descrition(id: '', descricao: ''),
              dia: 0,
              semana: UniVidaSemana(
                id: '',
                descricao: '',
                descritionDto: Descrition(id: '', descricao: ''),
                semanaNumero: 0,
              ),
            ),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'dataAula': dataAula,
      'descritionDto': descritionDto.toJson(),
      'id': id,
      'professor': professor.toJson(),
      'aulaTipo': aulaTipo.toJson(),
      'uniVida': uniVida.toJson(),
      'licao': licao.toJson(),
    };
  }
}
