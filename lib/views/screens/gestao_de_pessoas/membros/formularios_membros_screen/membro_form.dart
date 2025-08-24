// ignore_for_file: unnecessary_this, unnecessary_new, no_leading_underscores_for_local_identifiers

/*import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:i12mobile/domain/models/model/igreja.dart';
import 'package:i12mobile/domain/models/shared/descrition_model.dart';
import 'package:i12mobile/domain/core/themes/global_colors.dart';
import 'package:provider/provider.dart';
import '../../../../../data/provider/gestao_de_pessoas_providers/pessoas_provider.dart';
import '../../../../../domain/models/model/descendencia.dart';
import '../../../../../domain/models/model/pessoas_models.dart';
import '../../../../../domain/core/themes/containers_all_estilo.dart';
import '../../../../widgets/field_form.dart';

class MembroForm extends StatefulWidget {
  final String? igrejaId;
  const MembroForm({super.key, this.igrejaId});

  @override
  State<MembroForm> createState() => _MembroFormState();
}

class _MembroFormState extends State<MembroForm> {
  String title = 'Nova Vida';

  TextEditingController controllerName = TextEditingController();
  TextEditingController controllerDescendencia = TextEditingController();
  TextEditingController controllerLider = TextEditingController();
  TextEditingController controllerSexo = TextEditingController();
  TextEditingController controllerId = TextEditingController();
  TextEditingController controllerDescritionDto = TextEditingController();

  @override
  Widget build(BuildContext context) {
    //PessoaProvider pessoaProvider = PessoaProvider.of(context) as PessoaProvider;
    PessoaProvider pessoaProvider = Provider.of<PessoaProvider>(context);

    int? index;

    if (pessoaProvider.indexPessoa != null) {
      index = pessoaProvider.indexPessoa;
      controllerName.text = pessoaProvider.pessoaSelected!.nome;
      controllerDescendencia.text =
          pessoaProvider.pessoaSelected!.descendencia.descricao;
      controllerLider.text = pessoaProvider.pessoaSelected!.lider;
      controllerSexo.text = pessoaProvider.pessoaSelected!.sexo;

      setState(() {
        this.title = 'Edit Vida';
      });
    }

    GlobalKey<FormState> _key = GlobalKey();

    void savepessoa() {
      final isValidate = _key.currentState?.validate();

      if (isValidate == false) {
        return;
      }

      _key.currentState?.save();

      // instancia de classe user um novo usuario
      PessoasModels pessoaModel = PessoasModels(
        igreja: IgrejaModels.empty(),
        id: controllerId.text, // Usando o controller para pegar o valor
        descritionDto: Descrition(
            id: '', descricao: ''), // Usando o controller para o descrition
        nome: controllerName.text,
        descendencia: new DescendenciaModels(
            lider1: PessoasModels.empty(),
            lider2: PessoasModels.empty(),
            descricao: controllerDescendencia.text,
            sigla: '',
            id: controllerId.text,
            descritionDto: Descrition(
              id: controllerId.text,
              descricao: controllerDescendencia.text,
            ),
            igreja: IgrejaModels.empty()),
        lider: controllerLider.text,
        sexo: controllerSexo.text,
      );

      if (index != null) {
        pessoaProvider.pessoas[index] = pessoaModel;
      } else {
        // quantidade de pessoa
        int usersLength = pessoaProvider.pessoas.length;

        // salva um novo pessoa
        pessoaProvider.pessoas.insert(usersLength, pessoaModel);
      }

      // navegar para pagina home
      context.pop('/HomeLib');
    }

    return Scaffold(
      appBar: AppBar(
        iconTheme: const IconThemeData(color: Colors.white),
        backgroundColor: GlobalColor.AzulEscuroClaroColor,
        centerTitle: true,
        title: Text(
          this.title,
          style: const TextStyle(
              color: Colors.white, fontSize: 22, fontWeight: FontWeight.bold),
        ),
      ),
      body: ContainerAll(
        child: Center(
            child: Padding(
          padding: const EdgeInsets.all(15),
          child: Form(
            key: _key,
            child: SingleChildScrollView(
              child: Column(
                children: [
                  FieldForm(
                      isEmail: false,
                      label: 'Name',
                      isPassword: false,
                      controller: controllerName),
                  const SizedBox(
                    height: 25,
                  ),
                  FieldForm(
                      isEmail: true,
                      label: 'Descendência',
                      isPassword: false,
                      controller: controllerDescendencia),
                  const SizedBox(
                    height: 25,
                  ),
                  FieldForm(
                      isEmail: false,
                      label: 'Lider',
                      isPassword: false,
                      controller: controllerLider),
                  const SizedBox(
                    height: 25,
                  ),
                  FieldForm(
                      isEmail: false,
                      label: 'Sexo',
                      isPassword: false,
                      controller: controllerSexo),
                  const SizedBox(
                    height: 50,
                  ),
                  TextButton(
                    onPressed: savepessoa,
                    style: const ButtonStyle(
                        backgroundColor: WidgetStatePropertyAll(Colors.black)),
                    child: const Text(
                      'Salva',
                      style: TextStyle(
                          fontWeight: FontWeight.bold,
                          color: Colors.white,
                          fontSize: 20),
                    ),
                  )
                ],
              ),
            ),
          ),
        )),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          ;
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
}*/

// ignore_for_file: unnecessary_null_comparison

/*import 'package:flutter/material.dart';
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
                    TextFormField(
                      controller: visitaController.controllerNumeroTelefone,
                      decoration: InputDecoration(
                        filled: true,
                        fillColor: Colors.white,
                        labelText: 'Telefone',
                        labelStyle: const TextStyle(
                            color: Colors.black, fontWeight: FontWeight.bold),
                        border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(25),
                            borderSide: BorderSide.none),
                      ),
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
      
    );
  }
}*/
