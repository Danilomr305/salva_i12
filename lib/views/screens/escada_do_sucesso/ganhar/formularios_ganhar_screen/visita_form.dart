// ignore_for_file: unnecessary_null_comparison

import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:i12mobile/data/provider/escada_do_sucesso_provider/ganhar/visitas_provider.dart';
import 'package:i12mobile/domain/models/shared/descrition_model.dart';
import 'package:i12mobile/views/widgets/button_form_seletor_pessonalizado.dart';
import 'package:provider/provider.dart';
import '../../../../../domain/core/themes/containers_all_estilo.dart';
import '../../../../../domain/core/themes/global_colors.dart';
import '../../../../../domain/models/shared/select_item_personalisado.dart';
import '../../../../widgets/field_form_button.dart';

import 'controllers/visita_form_controller.dart';

class NovaVidaForm extends StatefulWidget {
  final String? igrejaId;
  const NovaVidaForm({
    super.key,
    this.igrejaId,
  });

  @override
  State<NovaVidaForm> createState() => _NovaVidaFormState();
}

class _NovaVidaFormState extends State<NovaVidaForm> {
  //String? _situacaoSelecionada;
  String title = 'Novo Visitante';

  final List<SelectItemPersonalisado> confirmacoes = [
    SelectItemPersonalisado(label: 'Sim', value: 'S'),
    SelectItemPersonalisado(label: 'Não', value: 'N'),
  ];

  final VisitaFormController visitaController = VisitaFormController();
  late VisitaProvider visitaProvider;

  @override
  void initState() {
    super.initState();
    visitaProvider = context.read<VisitaProvider>();
    visitaController.loadFromSelected(visitaProvider);
    if (visitaProvider.indexVisitas != null) {
      title = 'Edit Visitante';
    }

    // Converta a lista de SituacaoModel para Descrition e passe para o controller
    if (visitaProvider.situacoes.isNotEmpty) {
      final List<Descrition> situacoesConvertidas =
          visitaProvider.situacoes.map((s) {
        // Mapeie SituacaoModel para Descrition
        return Descrition(id: s.id, descricao: s.descricao);
      }).toList();
      visitaController.setSituacoes(situacoesConvertidas);
    }

    // Passe o ID da igreja para o controller assim que o widget for inicializado
    visitaController.setIgrejaId(widget.igrejaId);

    WidgetsBinding.instance.addPostFrameCallback((_) {
      print('ID da Igrejaaaaaaaaaaaaaaaa: ${widget.igrejaId}');
      context.read<VisitaProvider>().listSituacao();
      context.read<VisitaProvider>().listDescendencia(widget.igrejaId);
    });
  }

  @override
  Widget build(BuildContext context) {
    //VisitaProvider visitaProvider = Provider.of<VisitaProvider>(context);
    VisitaProvider visitaProvider = context.watch<VisitaProvider>();
    return Scaffold(
      backgroundColor: HexColor('#2684b4'),
      appBar: AppBar(
        iconTheme: IconThemeData(
          color: Colors.white,
        ),
        backgroundColor: HexColor('#2684b4'),
        centerTitle: true,
        title: Text(title,
            style: const TextStyle(
                color: Colors.white,
                fontSize: 22,
                fontWeight: FontWeight.bold)),
      ),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: ContainerAll(
            child: Form(
              key: visitaController.formKey,
              child: SingleChildScrollView(
                padding: const EdgeInsets.all(15),
                child: Column(
                  children: [
                    const SizedBox(
                      height: 25,
                    ),
                    const SizedBox(
                      height: 25,
                    ),
                    ButtonFormSeletorPessonalizado(
                      tituloModal: 'Selecione a Situação',
                      value: 'Escolha',
                      label: 'Situação',
                      controller: visitaController.controllerTipoConversao,
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'A situação não pode \nestar em branco!';
                        }
                        return null;
                      },
                      itens: visitaProvider.situacoes.map((situacao) {
                        return SelectItemPersonalisado(
                          label: situacao.descricao,
                          value: situacao.id,
                        );
                      }).toList(),
                      onChanged: (String? selectedId) {
                        if (selectedId != null) {
                          // 1. Salve o ID no controller específico (se tiver) ou use-o diretamente
                          // para buscar a descrição e salvar no controller principal.
                          // O código no seu VisitaFormController.save já usa a descrição para buscar o ID.
                          // Você pode simplificar isso ajustando a lógica para usar o ID.
                          final selectedDescricao = visitaProvider.situacoes
                              .firstWhere((s) => s.id == selectedId)
                              .descricao;
                          visitaController.controllerTipoConversao.text =
                              selectedDescricao;
                        }
                      },
                    ),
                    const SizedBox(
                      height: 25,
                    ),
                    ButtonFormSeletorPessonalizado(
                      tituloModal: 'Selecione a Descendência',
                      value: 'Escolha',
                      label: 'Descendência',
                      controller: visitaController.controllerDescendencia,
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'A descendência não pode \nestar em branco!';
                        }
                        return null;
                      },
                      itens: visitaProvider.descendencias.map((descendencias) {
                        return SelectItemPersonalisado(
                          label: descendencias.descricao,
                          value: descendencias.id,
                        );
                      }).toList(),
                      onChanged: (selectedId) {
                        visitaController.controllerIdDescendencia.text =
                            selectedId ?? '';
                        visitaController.controllerDescendencia.text =
                            selectedId != null
                                ? visitaProvider.descendencias
                                    .firstWhere((desc) => desc.id == selectedId)
                                    .descricao
                                : '';
                      },
                    ),
                    const SizedBox(
                      height: 25,
                    ),
                    FieldFormButton(
                      label: 'Nome',
                      controllerButton: visitaController.controllerPessoa,
                      validator: (value) {
                        // Adicione isso
                        if (value == null || value.isEmpty) {
                          return 'O nome não pode \nestar em branco!';
                        }
                        return null;
                      },
                    ),
                    const SizedBox(
                      height: 25,
                    ),
                    ButtonFormSeletorPessonalizado(
                      tituloModal: 'Selecione o Gênero',
                      value: 'Escolha',
                      label: 'Sexo',
                      controller: visitaController.controllerGenero,
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Gênero não pode \nestar em branco!';
                        }
                        return null;
                      },
                      itens: [
                        SelectItemPersonalisado(label: 'Masculino', value: 'M'),
                        SelectItemPersonalisado(label: 'Feminino', value: 'F'),
                      ],
                    ),
                    const SizedBox(
                      height: 25,
                    ),
                    TextField(
                      controller: visitaController.controllerDataNascimento,
                      keyboardType: TextInputType.number,
                      inputFormatters: [visitaController.dateMaskFormatter],
                      decoration: InputDecoration(
                          labelText: 'Data da Nascimento',
                          fillColor: Colors.white,
                          filled: true,
                          hintText: 'DD/MM/YYYY',
                          labelStyle: const TextStyle(
                              color: Colors.black, fontWeight: FontWeight.bold),
                          border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(25),
                              borderSide: BorderSide.none)),
                      // ... outras propriedades
                    ),
                    const SizedBox(
                      height: 25,
                    ),
                    TextField(
                      controller: visitaController.controllerNumeroTelefone,
                      keyboardType: TextInputType.number,
                      inputFormatters: [visitaController.telefoneMaskFormatter],
                      decoration: InputDecoration(
                          labelText: 'Telefone',
                          fillColor: Colors.white,
                          filled: true,
                          hintText: '(99) 99999-9999',
                          labelStyle: const TextStyle(
                              color: Colors.black, fontWeight: FontWeight.bold),
                          border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(25),
                              borderSide: BorderSide.none)),
                      // ... outras propriedades
                    ),
                    const SizedBox(
                      height: 25,
                    ),
                    FieldFormButton(
                      label: 'Quem Convidou?',
                      controllerButton: visitaController.controllerConvidadoPor,
                    ),
                    const SizedBox(
                      height: 25,
                    ),
                    ButtonFormSeletorPessonalizado(
                        tituloModal: 'Está em Célula?',
                        value: 'Escolha',
                        label: 'Está em Célula?',
                        controller: visitaController.controllerEstaEmCelula,
                        itens: [
                          SelectItemPersonalisado(label: 'Sim', value: 'S'),
                          SelectItemPersonalisado(label: 'Não', value: 'N')
                        ]),
                    const SizedBox(
                      height: 25,
                    ),
                    FieldFormButton(
                      label: 'Nome do Líder Célula',
                      controllerButton:
                          visitaController.controllerNomeLiderCelula,
                    ),
                    const SizedBox(
                      height: 25,
                    ),
                    FieldFormButton(
                      label: 'Pedido de Oração',
                      controllerButton: visitaController.controllerPedidoOracao,
                    ),
                    const SizedBox(
                      height: 25,
                    ),
                    const SizedBox(height: 50),
                    ElevatedButton(
                      style: ButtonStyle(
                          backgroundColor: WidgetStatePropertyAll(
                              GlobalColor.AzulEscuroClaroColor)),
                      onPressed: () {
                        visitaController.save(context, visitaProvider,
                            index: visitaProvider.indexVisitas);
                      },
                      child: const Text('Salvar',
                          style: TextStyle(
                              fontWeight: FontWeight.bold,
                              color: Colors.white,
                              fontSize: 20)),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          context.pop('/homeLib');
        },
        backgroundColor: GlobalColor.AzulEscuroColor,
        child: const Icon(
          Icons.home,
          size: 35,
          color: Colors.white,
        ),
      ),
    );
  }
}
