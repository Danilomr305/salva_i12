import 'package:flutter/material.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:i12mobile/data/provider/gestao_de_pessoas_providers/pessoas_provider.dart';
import 'package:i12mobile/views/screens/gestao_de_pessoas/membros/formularios_membros_screen/controller/membro_form_controller.dart';
import 'package:i12mobile/views/widgets/button_form_seletor_pessonalizado.dart';
import 'package:provider/provider.dart';
import '../../../../../domain/core/themes/containers_all_estilo.dart';
import '../../../../../domain/core/themes/global_colors.dart';
import '../../../../../domain/models/shared/select_item_personalisado.dart';
import '../../../../widgets/field_form_button.dart';

class MembroForm extends StatefulWidget {
  final String? igrejaId;
  const MembroForm({super.key, this.igrejaId});

  @override
  State<MembroForm> createState() => _MembroFormState();
}

class _MembroFormState extends State<MembroForm> {
  String title = 'Novo Membro';

  final MembroFormController membroController = MembroFormController();

  late PessoaProvider pessoaProvider;

  @override
  void initState() {
    super.initState();
    pessoaProvider = context.read<PessoaProvider>();

    // Carrega dados caso seja edição
    membroController.loadFromSelected(pessoaProvider);

    if (pessoaProvider.indexPessoa != null) {
      title = 'Editar Membro';
    }

    membroController.setIgrejaId(widget.igrejaId);

    WidgetsBinding.instance.addPostFrameCallback((_) async {
      print('ID da Igreja: ${widget.igrejaId}');

      await pessoaProvider.listPessoas();

      if (widget.igrejaId != null && widget.igrejaId!.isNotEmpty) {
        await pessoaProvider.listDescendencia(widget.igrejaId);
      } else {
        print('⚠️ IgrejaId é nulo ou vazio. Descendência não será carregada.');
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    pessoaProvider = context.watch<PessoaProvider>();
    //final controller = Provider.of<ForController>(context);

    return Scaffold(
      backgroundColor: HexColor('#2684b4'),
      appBar: AppBar(
        iconTheme: const IconThemeData(color: Colors.white),
        backgroundColor: HexColor('#2684b4'),
        centerTitle: true,
        title: Text(
          title,
          style: const TextStyle(
              color: Colors.white, fontSize: 22, fontWeight: FontWeight.bold),
        ),
      ),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: ContainerAll(
            child: Form(
              key: membroController.formKey,
              child: SingleChildScrollView(
                padding: const EdgeInsets.all(15),
                child: Column(
                  children: [
                    const SizedBox(height: 25),

                    // Seleção de Descendência
                    ButtonFormSeletorPessonalizado(
                      tituloModal: 'Selecione a Descendência',
                      value: 'Escolha',
                      label: 'Descendência',
                      controller: membroController.controllerDescendencia,
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'A descendência não pode \nestar em branco!';
                        }
                        return null;
                      },
                      itens: pessoaProvider.descendencias.map((desc) {
                        return SelectItemPersonalisado(
                          label: desc.descricao,
                          value: desc.id,
                        );
                      }).toList(),
                      onChanged: (selectedId) {
                        membroController.controllerIdDescendencia.text =
                            selectedId ?? '';
                        membroController.controllerDescendencia.text =
                            selectedId != null
                                ? pessoaProvider.descendencias
                                    .firstWhere((d) => d.id == selectedId)
                                    .descricao
                                : '';
                      },
                    ),
                    const SizedBox(height: 25),

                    // Nome do Membro
                    FieldFormButton(
                      label: 'Nome',
                      controllerButton: membroController.controllerPessoa,
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'O nome não pode \nestar em branco!';
                        }
                        return null;
                      },
                    ),
                    const SizedBox(height: 25),

                    // Seleção de Sexo
                    ButtonFormSeletorPessonalizado(
                      tituloModal: 'Selecione o Gênero',
                      value: 'Escolha',
                      label: 'Sexo',
                      controller: membroController.controllerGenero,
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
                      onChanged: (selectedValue) {
                        membroController.controllerGenero.text =
                            selectedValue ?? '';
                      },
                    ),
                    const SizedBox(height: 25),

                    // Data de Nascimento
                    TextField(
                      controller: membroController.controllerDataNascimento,
                      keyboardType: TextInputType.number,
                      inputFormatters: [membroController.dateMaskFormatter],
                      decoration: InputDecoration(
                        labelText: 'Data de Nascimento',
                        fillColor: Colors.white,
                        filled: true,
                        hintText: 'DD/MM/YYYY',
                        labelStyle: const TextStyle(
                            color: Colors.black, fontWeight: FontWeight.bold),
                        border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(25),
                            borderSide: BorderSide.none),
                      ),
                    ),
                    const SizedBox(height: 25),

                    // Telefone
                    TextFormField(
                      controller: membroController.controllerTelefone,
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
                    const SizedBox(height: 25),

                    // Nome do Líder
                    FieldFormButton(
                        label: 'Nome do Líder',
                        controllerButton: membroController.controllerLider),
                    const SizedBox(height: 25),
                    TextFormField(
                      controller: membroController.cepController,
                      decoration: InputDecoration(
                        filled: true,
                        fillColor: Colors.white,
                        labelText: 'Cep',
                        labelStyle: const TextStyle(
                            color: Colors.black, fontWeight: FontWeight.bold),
                        border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(25),
                            borderSide: BorderSide.none),
                      ),
                      keyboardType: TextInputType.number,
                      maxLength: 8,
                      onChanged: (value) {
                        if (value.length == 8) {
                          membroController.buscarEndereco(context, value);
                        }
                      },
                    ),
                    const SizedBox(height: 25),
                    TextFormField(
                      controller: membroController.logradouroController,
                      decoration: InputDecoration(
                        filled: true,
                        fillColor: Colors.white,
                        labelText: 'Logradouro',
                        labelStyle: const TextStyle(
                            color: Colors.black, fontWeight: FontWeight.bold),
                        border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(25),
                            borderSide: BorderSide.none),
                      ),
                    ),
                    const SizedBox(height: 25),
                    TextFormField(
                      controller: membroController.bairroController,
                      decoration: InputDecoration(
                        filled: true,
                        fillColor: Colors.white,
                        labelText: 'Bairro',
                        labelStyle: const TextStyle(
                            color: Colors.black, fontWeight: FontWeight.bold),
                        border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(25),
                            borderSide: BorderSide.none),
                      ),
                    ),
                    const SizedBox(height: 25),
                    TextFormField(
                      controller: membroController.cidadeController,
                      decoration: InputDecoration(
                        filled: true,
                        fillColor: Colors.white,
                        labelText: 'Cidade',
                        labelStyle: const TextStyle(
                            color: Colors.black, fontWeight: FontWeight.bold),
                        border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(25),
                            borderSide: BorderSide.none),
                      ),
                    ),
                    const SizedBox(height: 25),
                    TextFormField(
                      controller: membroController.estadoController,
                      decoration: InputDecoration(
                        filled: true,
                        fillColor: Colors.white,
                        labelText: 'Estado',
                        labelStyle: const TextStyle(
                            color: Colors.black, fontWeight: FontWeight.bold),
                        border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(25),
                            borderSide: BorderSide.none),
                      ),
                    ),

                    const SizedBox(height: 50),

                    // Botão Salvar
                    ElevatedButton(
                      style: ButtonStyle(
                          backgroundColor: WidgetStatePropertyAll(
                              GlobalColor.AzulEscuroClaroColor)),
                      onPressed: () {
                        membroController.save(context, pessoaProvider,
                            index: pessoaProvider.indexPessoa);
                      },
                      child: const Text(
                        'Salvar',
                        style: TextStyle(
                            fontWeight: FontWeight.bold,
                            color: Colors.white,
                            fontSize: 20),
                      ),
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
}
