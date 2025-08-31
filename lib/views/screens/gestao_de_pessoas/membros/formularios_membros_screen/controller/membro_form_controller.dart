/*import 'package:flutter/material.dart';

import '../../../../../../domain/models/model/descendencia.dart';
import '../../../../../../domain/models/model/igreja.dart';
import '../../../../../../domain/models/model/pessoas_models.dart';
import '../../../../../../domain/models/shared/descrition_model.dart';

class MembroFormController {
  //Isso vai formatar a data ja colocando 00/00/0000
  final dateMaskFormatter = MaskTextInputFormatter(
      mask: '##/##/####', filter: {"#": RegExp(r'[0-9]')});

  //-----------------------------------------------------------------------------------

  // Adicione esta linha para armazenar o ID da igreja
  String? _igrejaId;

  // Adicione uma propriedade para a lista de situações
  late List<Descrition> situacoes;

  // Adicione este método para definir o ID
  void setIgrejaId(String? id) {
    _igrejaId = id;
  }

  void setSituacoes(List<Descrition> lista) {
    situacoes = lista;
  }

  //Responsavel por salva cada visita nova
  final GlobalKey<FormState> formKey = GlobalKey<FormState>();
  // Controllers dos campos
  final TextEditingController controllerId = TextEditingController();
  final TextEditingController controllerPessoa = TextEditingController();
  final TextEditingController controllerDataUltimaVisita =
      TextEditingController();
  final TextEditingController controllerPedidoOracao = TextEditingController();
  final TextEditingController controllerNumeroTelefone =
      TextEditingController();
  final TextEditingController controllerNomeLiderCelula =
      TextEditingController();
  final TextEditingController controllerRazaoSocial = TextEditingController();
  final TextEditingController controllerSigla = TextEditingController(); //
  final TextEditingController controllerConvidadoPor = TextEditingController();
  final TextEditingController controllerDescendencia = TextEditingController();
  final TextEditingController controllerEstaEmCelula = TextEditingController();
  final TextEditingController controllerTipoConversao = TextEditingController();
  final TextEditingController controllerDescritionDto = TextEditingController();
  final TextEditingController controllerTotalVisitas = TextEditingController();
  final TextEditingController controllerGenero = TextEditingController();
  final TextEditingController controllerDataNascimento =
      TextEditingController();
  final TextEditingController controllerIdDescendencia =
      TextEditingController();

  void save(BuildContext context, VisitaProvider visitaProvider,
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
    final descendenciaSelecionada = visitaProvider.descendencias.firstWhere(
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
      descendencia: descendenciaSelecionada, // Use a instância de descendência
    );

    // Encontre o ID da situação a partir da descrição
    final situacaoSelecionada = situacoes.firstWhere(
      (s) => s.descricao == controllerTipoConversao.text,
      orElse: () => Descrition(
          id: '', descricao: ''), // Retorna um objeto vazio se não encontrar
    );

    final tipoConversao = Descrition(
      id: situacaoSelecionada.id,
      descricao: situacaoSelecionada.descricao,
    );

    final novaVisita = PessoasModels(
      id: '',
      pessoa: pessoa,
      dataUltimaVisita: controllerDataUltimaVisita.text,
      totalVisitas: int.tryParse(controllerTotalVisitas.text) ?? 0,
      pedidoOracao: controllerPedidoOracao.text,
      numeroTelefone: controllerNumeroTelefone.text,
      nomeLiderCelula: controllerNomeLiderCelula.text,
      convidadoPor: controllerConvidadoPor.text,
      descendencia: descendenciaSelecionada,
      descritionDto: pessoa.descritionDto,
      estaEmCelula: controllerEstaEmCelula.text,
      tipoConversao: tipoConversao,
    );

    // Criar nova visita
    final visitaForm = VisitaFormModel.fromDetalhe(novaVisita);
    await visitaProvider.createVisitaForm(visitaForm);
    context.pop('/visitante');
  }

  void loadFromSelected(VisitaProvider visitaProvider) {
    if (visitaProvider.indexVisitas != null &&
        visitaProvider.visitasSelected != null) {
      final selected = visitaProvider.visitasSelected!;

      controllerPessoa.text = selected.pessoa.nome;
      controllerDataUltimaVisita.text = selected.dataUltimaVisita;
      controllerPedidoOracao.text = selected.pedidoOracao;
      controllerNumeroTelefone.text = selected.numeroTelefone;
      controllerDescendencia.text = selected.descendencia.sigla;
      controllerIdDescendencia.text = selected.descendencia.id;
      controllerConvidadoPor.text = selected.convidadoPor;
      controllerTipoConversao.text = selected.tipoConversao.descricao;
      controllerEstaEmCelula.text = selected.estaEmCelula;
      controllerTotalVisitas.text = selected.totalVisitas.toString();
    }
  }
}*/
