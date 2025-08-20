import 'package:i12mobile/domain/models/model/base_model.dart';
import 'package:i12mobile/domain/models/model/discipular/ecd_aula_model.dart';
import '../../shared/descrition_model.dart';
import '../descendencia.dart';
import '../igreja.dart';
import '../pessoas_models.dart';
import 'ecd_licao_model.dart';
import 'ecd_model.dart';
import 'ecd_modulo_model.dart';

class EcdAlunoFrequencia extends BaseModel {
  final EcdAula aula;
  final EcdAula aluno;
  final bool presente;
  final String justificativa;

  EcdAlunoFrequencia({
    required super.id,
    required super.descritionDto,
    required this.aula,
    required this.aluno,
    required this.presente,
    required this.justificativa,
  });

  factory EcdAlunoFrequencia.fromJson(Map<String, dynamic> json) {
    return EcdAlunoFrequencia(
      id: json['id'] ?? '',
      descritionDto: json['descritionDto'],
      aula: json['aula'] != null
          ? EcdAula.fromJson(json['aula']) // Convertendo JSON para EcdAula
          : EcdAula(
              dataAula: '',
              id: '',
              descritionDto: Descrition(descricao: '', id: ''),
              escola: EcdModel(
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
              licao: EcdLicao(
                id: '',
                descritionDto: Descrition(descricao: '', id: ''),
                descricao: '',
                modulo: EcdModulo(
                    id: '',
                    descritionDto: Descrition(descricao: '', id: ''),
                    descricao: '',
                    nivel: 0,
                    livro: 0),
                capitulo: 0,
              ),
              aulaTipo: Descrition(descricao: '', id: ''),
              professor: PessoasModels(
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
                  lider: ''),
            ),
      aluno: json['aluno'] != null
          ? EcdAula.fromJson(json['aluno']) // Convertendo JSON para EcdAula
          : EcdAula(
              dataAula: '',
              id: '',
              descritionDto: Descrition(descricao: '', id: ''),
              escola: EcdModel(
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
              licao: EcdLicao(
                id: '',
                descritionDto: Descrition(descricao: '', id: ''),
                descricao: '',
                modulo: EcdModulo(
                    id: '',
                    descritionDto: Descrition(descricao: '', id: ''),
                    descricao: '',
                    nivel: 0,
                    livro: 0),
                capitulo: 0,
              ),
              aulaTipo: Descrition(descricao: '', id: ''),
              professor: PessoasModels(
                  nome: '',
                  id: json['id'] ?? '',
                  descritionDto: json['descritionDto'],
                  igreja: json['igreja'] != null
                      ? IgrejaModels.fromJson(json['igreja'])
                      : IgrejaModels.empty(),
                  sexo: '',
                  descendencia: DescendenciaModels(
                      lider1: PessoasModels.empty(),
                      lider2: PessoasModels.empty(),
                      descricao: '',
                      sigla: '',
                      id: '',
                      descritionDto: Descrition(id: '', descricao: ''),
                      igreja: IgrejaModels.empty()),
                  lider: ''),
            ),
      presente: json['presente'] ?? false,
      justificativa: json['justificativa'] ?? '',
    );
  }

  // Converter EcdAlunoFrequencia para Json
  Map<String, dynamic> toJson() {
    return {
      'descritionDto': descritionDto.toJson(),
      'id': id,
      'aula': aula.toJson(),
      'aluno': aluno.toJson(),
      'presente': presente,
      'justificativa': justificativa,
    };
  }
}
