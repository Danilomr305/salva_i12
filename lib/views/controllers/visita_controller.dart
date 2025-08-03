import 'package:i12mobile/domain/models/model/ganhar/visita_detalhe_models.dart';

import '../../domain/models/model/descendencia.dart';
import '../../domain/models/model/pessoas_models.dart';
import '../../domain/models/shared/descrition_model.dart';

class VisitaController {
  VisitaDetalheModels mostarVisita(
    String id,
    String nome,
    String dataUltimaVisita,
    String pedidoOracao,
    String numeroTelefone,
    String nomeLiderCelula,
    String convidadoPor,
    String descendencia,
    String estaEmCelula,
  ) {
    return VisitaDetalheModels(
        pessoa: PessoasModels(
          id: id, // Usando o controller para pegar o valor
          descritionDto: Descrition(
              /*controllerDescritionDto.text*/
              id: '',
              descricao: ''), // Usando o controller para o descrition
          nome: nome,
          sexo: '',
          descendencia: DescendenciaModels(
            descricao: descendencia,
            sigla: '',
          ),
          lider: '',
        ),
        dataUltimaVisita: dataUltimaVisita,
        totalVisitas: 0,
        pedidoOracao: pedidoOracao,
        numeroTelefone: numeroTelefone,
        nomeLiderCelula: nomeLiderCelula,
        convidadoPor: convidadoPor,
        descendencia: DescendenciaModels(
          descricao: descendencia,
          sigla: '',
        ),
        descritionDto: Descrition(id: '', descricao: ''),
        estaEmCelula: estaEmCelula,
        id: '',
        tipoConversao: Descrition(id: '', descricao: ''));
  }

  String? validarNumeroTelefone(String? value) {
    if (value == null || value.isEmpty) {
      return null;
    }

    // Remove espaços, traços e parênteses para validar somente os dígitos
    final sanitizedValue = value.replaceAll(RegExp(r'[\s\-\(\)]'), '');

    // Verifica se contém apenas números
    if (!RegExp(r'^\d+$').hasMatch(sanitizedValue)) {
      return 'O número de telefone \ndeve conter apenas números!';
    }

    // Verifica se tem exatamente 11 dígitos (2 do DDD + 9 do número)
    if (sanitizedValue.length != 11) {
      return 'O número de telefone \ndeve ter 11 dígitos (DDD + número)!';
    }

    // Verifica se começa com o DDD válido (01 a 99)
    final ddd = sanitizedValue.substring(0, 2);
    if (int.parse(ddd) < 11 || int.parse(ddd) > 99) {
      return 'O DDD informado é inválido!';
    }

    // Verifica se o número inicia com 9 (padrão para celulares no Brasil)
    if (!sanitizedValue.startsWith('9', 2)) {
      return 'O número deve começar \ncom 9 após o DDD!';
    }

    return null; // Número válido
  }
}
