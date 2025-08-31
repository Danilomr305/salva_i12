import 'package:i12mobile/domain/models/model/base_model.dart';
import 'package:i12mobile/domain/models/model/pessoas_models.dart';
import 'package:i12mobile/domain/models/shared/descrition_model.dart';
import '../../shared/endereco_model.dart';
import '../descendencia.dart';
import '../igreja.dart';
import '../pessoas_discipulos_models.dart';

class RotaDaVidaModels extends BaseModel {
  final PessoasModels pessoa;
  final String estaEmCelula;
  final String dataInscricaoUniVida;

  RotaDaVidaModels({
    required this.pessoa,
    required this.estaEmCelula,
    required this.dataInscricaoUniVida,
    required super.id,
    required super.descritionDto,
  });

  factory RotaDaVidaModels.fromJson(Map<String, dynamic> json) {
    return RotaDaVidaModels(
        descritionDto:
            json['descritionDto'] ?? '', // Garantindo que não seja nulo
        id: json['id'] ?? '', // Garante que não seja nulo
        pessoa: json['pessoa'] != null
            ? PessoasModels.fromJson(json['pessoa'])
            : PessoasModels(
                igreja: IgrejaModels.empty(),
                id: json['id'] ?? '',
                descritionDto: json['descritionDto'],
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
        estaEmCelula:
            json['estaEmCelula'] ?? '', // Garantindo que não seja nulo
        dataInscricaoUniVida:
            json['dataInscricaoUniVida'] ?? '' // Garantindo que não seja nulo
        );
  }

  Map<String, dynamic> toJson() {
    return {
      'descritionDto': descritionDto,
      'id': id,
      'pessoa': pessoa,
      'estaEmCelula': estaEmCelula,
      'dataInscricaoUniVida': dataInscricaoUniVida,
    };
  }
}
