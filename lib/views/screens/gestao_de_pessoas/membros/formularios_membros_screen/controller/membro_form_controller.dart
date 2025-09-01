import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:i12mobile/data/provider/gestao_de_pessoas_providers/pessoas_provider.dart';
import 'package:i12mobile/domain/models/shared/descrition_model.dart';
import 'package:mask_text_input_formatter/mask_text_input_formatter.dart';

import '../../../../../../domain/models/model/descendencia.dart';
import '../../../../../../domain/models/model/igreja.dart';
import '../../../../../../domain/models/model/pessoas_discipulos_models.dart';
import '../../../../../../domain/models/model/pessoas_models.dart';
import '../../../../../../domain/models/shared/endereco_model.dart';

class MembroFormController {
  //Isso vai formatar a data ja colocando 00/00/0000
  final dateMaskFormatter = MaskTextInputFormatter(
      mask: '##/##/####', filter: {"#": RegExp(r'[0-9]')});

  //-----------------------------------------------------------------------------------

  // Adicione esta linha para armazenar o ID da igreja
  String? _igrejaId;

  // Adicione este método para definir o ID
  void setIgrejaId(String? id) {
    _igrejaId = id;
  }

  //Responsavel por salva cada visita nova
  final GlobalKey<FormState> formKey = GlobalKey<FormState>();
  // Controllers dos campos
  final TextEditingController controllerDescritionDto = TextEditingController();
  final TextEditingController controllerId = TextEditingController();
  final TextEditingController controllerPessoa = TextEditingController();
  final TextEditingController controllerDataNascimento =
      TextEditingController();
  final TextEditingController controllerTelefone = TextEditingController();
  final TextEditingController controllerSigla = TextEditingController(); //
  final TextEditingController controllerConvidadoPor = TextEditingController();
  final TextEditingController controllerDescendencia = TextEditingController();
  final TextEditingController controllerGenero = TextEditingController();
  final TextEditingController controllerIdDescendencia =
      TextEditingController();
  final TextEditingController controllerIdade = TextEditingController();
  final TextEditingController controllerEndereco = TextEditingController();
  final TextEditingController controllerIgreja = TextEditingController();
  final TextEditingController controllerTotalCelulas = TextEditingController();
  final TextEditingController controllerDiscipulos = TextEditingController();
  final TextEditingController controllerLider = TextEditingController();

  void save(BuildContext context, PessoaProvider pessoaProvider,
      {int? index}) async {
    final isValid = formKey.currentState?.validate() ?? false;
    if (!isValid) return;

    formKey.currentState?.save();

    // Verifique se o ID da igreja está disponível. Se não, mostre um erro.
    if (_igrejaId == null || _igrejaId!.isEmpty) {
      // Você pode mostrar um SnackBar ou outro tipo de notificação
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('ID da igreja não disponível. Tente novamente.'),
        ),
      );
      return;
    }

    // Mapear o valor do gênero para o formato esperado pelo servidor
    final sexo = controllerGenero.text;
    String sexoServidor = '';

    if (sexo == 'Masculino') {
      sexoServidor = 'M';
    } else if (sexo == 'Feminino') {
      sexoServidor = 'F';
    } else {
      sexoServidor = '';
    }
    // Crie uma única instância de IgrejaModels com o ID correto
    final igrejaDoFormulario = IgrejaModels(
      id: _igrejaId!,
      descritionDto: Descrition(id: _igrejaId!, descricao: ''),
      razaoSocial: '',
      sigla: '',
      nomeFantasia: '',
      documento: '',
    );

    print('ID da Descendência no Controller: ${controllerDescendencia.text}');

// Encontre o objeto DescendenciaModels completo a partir do ID selecionado
    final descendenciaSelecionada = pessoaProvider.descendencias.firstWhere(
      (desc) => desc.id == controllerIdDescendencia.text,
      orElse: () => DescendenciaModels
          .empty(), // Retorna um objeto vazio se não encontrar
    );

    // Adicione esta linha para ver o valor que está sendo enviado
    print('Valor do Gênero antes de enviar: ${controllerGenero.text}');

    // Agora, monte o objeto PessoasModels
    final pessoa = PessoasModels(
        id: controllerId.text,
        nome: controllerPessoa.text,
        sexo: sexoServidor,
        lider: '',
        igreja: igrejaDoFormulario, // Use a instância de igreja criada
        descritionDto: Descrition(
          id: controllerId.text,
          descricao: controllerDescritionDto.text,
        ),
        descendencia: descendenciaSelecionada,
        telefone: '',
        dataNascimento: DateTime(1900, 1, 1),
        idade: 0,
        endereco: Endereco.empty(),
        totalCelulas: 0,
        pessoasDiscipulos:
            PessoasDiscipulosModels.empty() // Use a instância de descendência
        );

    // Criar novo membro
    //final membrosForm = PessoasModels.fromDetalhe(novaVisita);
    final membrosForm = PessoasModels.fromPessoa(pessoa);
    await pessoaProvider.createMembroForm(membrosForm);
    context.pop('/membro');
  }

  void loadFromSelected(PessoaProvider pessoaProvider) {
    if (pessoaProvider.indexPessoa != null &&
        pessoaProvider.pessoaSelected != null) {
      final selected = pessoaProvider.pessoaSelected!;

      controllerPessoa.text = selected.nome;
      controllerDataNascimento.text = selected.dataNascimento.toString();
      controllerTelefone.text = selected.telefone;
      controllerDescendencia.text = selected.descendencia.sigla;
      controllerIdDescendencia.text = selected.descendencia.id;
      controllerGenero.text = selected.sexo;
      controllerIdade.text = selected.idade.toString();
      controllerIgreja.text = selected.igreja.razaoSocial;
      controllerTotalCelulas.text = selected.totalCelulas.toString();
      controllerDiscipulos.text = selected.pessoasDiscipulos.toString();
      controllerEndereco.text = selected.endereco.toString();
      controllerLider.text = selected.lider;
    }
  }
}
