import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:http/http.dart' as http;
import 'package:i12mobile/data/provider/gestao_de_pessoas_providers/pessoas_provider.dart';
import 'package:i12mobile/domain/models/shared/descrition_model.dart';
import 'package:mask_text_input_formatter/mask_text_input_formatter.dart';

import '../../../../../../domain/models/model/descendencia.dart';
import '../../../../../../domain/models/model/igreja.dart';
import '../../../../../../domain/models/model/pessoas_discipulos_models.dart';
import '../../../../../../domain/models/model/pessoas_models.dart';
import '../../../../../../domain/models/shared/endereco_model.dart';

class MembroFormController extends ChangeNotifier {
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
  final TextEditingController cepController = TextEditingController();
  final TextEditingController logradouroController = TextEditingController();
  final TextEditingController bairroController = TextEditingController();
  final TextEditingController cidadeController = TextEditingController();
  final TextEditingController estadoController = TextEditingController();
  final TextEditingController logradouroNumeroController =
      TextEditingController();

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
    //final sexo = controllerGenero.text;
    //String sexoServidor = '';

    /*if (sexo == 'Masculino') {
      sexoServidor = 'M';
    } else if (sexo == 'Feminino') {
      sexoServidor = 'F';
    } else {
      sexoServidor = '';
    }*/
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

    // Função para converter a data de String para DateTime
    DateTime parseData(String value) {
      try {
        final parts = value.split('/');
        if (parts.length != 3) return DateTime(1900, 1, 1);
        final day = int.parse(parts[0]);
        final month = int.parse(parts[1]);
        final year = int.parse(parts[2]);
        return DateTime(year, month, day);
      } catch (e) {
        return DateTime(1900, 1, 1);
      }
    }

    // Crie o objeto Endereco com os dados do formulário
    final enderecoPessoa = Endereco(
      id: controllerEndereco.text, // se você tiver o ID
      logradouro: logradouroController.text,
      bairro: bairroController.text,
      cidade: cidadeController.text,
      uf: estadoController.text,
      cep: cepController.text,
      descritionDto: Descrition(
          descricao: controllerDescritionDto.text, id: controllerId.text),
      logradouroNumero: logradouroNumeroController.text,
    );

    final pessoa = PessoasModels(
      id: controllerId.text,
      nome: controllerPessoa.text,
      sexo: controllerGenero.text,
      lider: controllerLider.text,
      igreja: igrejaDoFormulario,
      descritionDto: Descrition(
        id: controllerId.text,
        descricao: controllerDescritionDto.text,
      ),
      descendencia: descendenciaSelecionada,
      telefone: controllerTelefone.text,
      dataNascimento: controllerDataNascimento.text.isNotEmpty
          ? parseData(controllerDataNascimento.text)
          : DateTime(1900, 1, 1),
      idade: int.tryParse(controllerIdade.text) ?? 0,
      endereco: enderecoPessoa,
      totalCelulas: int.tryParse(controllerTotalCelulas.text) ?? 0,
      pessoasDiscipulos: PessoasDiscipulosModels.empty(),
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
      //controllerEndereco.text = selected.endereco.toString();
      controllerLider.text = selected.lider;
      cepController.text = selected.endereco.cep;
      logradouroController.text = selected.endereco.logradouro;
      bairroController.text = selected.endereco.bairro;
      cidadeController.text = selected.endereco.cidade;
      estadoController.text = selected.endereco.uf;
    }
  }

  Future<void> buscarEndereco(BuildContext context, String cep) async {
    if (cep.isEmpty || cep.length < 8) return;

    try {
      final url = Uri.parse("https://viacep.com.br/ws/$cep/json/");
      final response = await http.get(url);

      if (response.statusCode == 200) {
        final data = jsonDecode(response.body);

        if (data["erro"] == true) {
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(content: Text("CEP não encontrado")),
          );
          return;
        }

        // Preenche os controllers com os dados retornados
        cepController.text = cep;
        logradouroController.text = data["logradouro"] ?? "";
        bairroController.text = data["bairro"] ?? "";
        cidadeController.text = data["localidade"] ?? "";
        estadoController.text = data["uf"] ?? "";

        notifyListeners(); // Atualiza quem estiver ouvindo
      } else {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text("Erro ao buscar CEP: ${response.statusCode}")),
        );
      }
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text("Erro: $e")),
      );
    }
  }
}
