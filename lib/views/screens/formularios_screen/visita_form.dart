// ignore_for_file: unnecessary_null_comparison

import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:i12mobile/data/provider/escada_do_sucesso_provider/visitas_provider.dart';
import 'package:provider/provider.dart';
import '../../../domain/core/themes/containers_all_estilo.dart';
import '../../../domain/core/themes/global_colors.dart';
import '../../../domain/models/model/descendencia.dart';
import '../../../domain/models/model/ganhar/visita_detalhe_models.dart';
import '../../../domain/models/model/pessoas_models.dart';
import '../../../domain/models/shared/descrition_model.dart';
import '../../widgets/field_form_button.dart';

class NovaVidaForm extends StatefulWidget {
  const NovaVidaForm({super.key});

  @override
  State<NovaVidaForm> createState() => _NovaVidaFormState();
}

class _NovaVidaFormState extends State<NovaVidaForm> {
  String title = 'Novo Visitante';

  final List<String> situacao = [
    'Não Converteu',
    'Visitante',
    'Novo Convertido',
    'Reconciliação',
    'Outra igreja'
  ];

  // Valor selecionado
  String? situacaoSelecionada;

  // Controladores de texto
  TextEditingController controllerPessoa = TextEditingController();
  TextEditingController controllerDataUltimaVisita = TextEditingController();
  TextEditingController controllerPedidoOracao = TextEditingController();
  TextEditingController controllerNumeroTelefone = TextEditingController();
  TextEditingController controllerDescendencia = TextEditingController();
  TextEditingController controllerNomeLiderCelula = TextEditingController();
  TextEditingController controllerTipoEvento = TextEditingController();
  TextEditingController controllerConvidadoPor = TextEditingController();
  TextEditingController controllerEstaEmCelula = TextEditingController();
  TextEditingController controllerId = TextEditingController();
  TextEditingController controllerDescritionDto = TextEditingController();
  TextEditingController controllerTipoConversao = TextEditingController();
  TextEditingController controllerTotalVisitas = TextEditingController();

  @override
  Widget build(BuildContext context) {
    VisitaDetalheProvider visitaProvider =
        Provider.of<VisitaDetalheProvider>(context);
    int? index;

    if (visitaProvider.indexLifes != null) {
      controllerPessoa.text = visitaProvider.lifesSelected!.pessoa.nome;
      controllerDataUltimaVisita.text =
          visitaProvider.lifesSelected!.dataUltimaVisita;
      controllerPedidoOracao.text = visitaProvider.lifesSelected!.pedidoOracao;
      controllerNumeroTelefone.text =
          visitaProvider.lifesSelected!.numeroTelefone;
      controllerDescendencia.text =
          visitaProvider.lifesSelected!.descendencia.sigla;
      controllerConvidadoPor.text = visitaProvider.lifesSelected!.convidadoPor;
      controllerTipoConversao.text =
          visitaProvider.lifesSelected!.tipoConversao.descricao;
      controllerEstaEmCelula.text = visitaProvider.lifesSelected!.estaEmCelula;
      controllerTotalVisitas.text =
          visitaProvider.lifesSelected!.totalVisitas.toString();

      setState(() {
        this.title = 'Edit Visitante';
      });
    }

    GlobalKey<FormState> _key = GlobalKey();

    void savenovalifes() {
      final isValidateVisitante = _key.currentState?.validate();

      if (isValidateVisitante == false) {
        return;
      }

      _key.currentState?.save();

      VisitaDetalheModels novaVisita = VisitaDetalheModels(
          pessoa: PessoasModels(
            id: controllerId.text, // Usando o controller para pegar o valor
            descritionDto: Descrition(
                /*controllerDescritionDto.text*/
                id: '',
                descricao: ''), // Usando o controller para o descrition
            nome: controllerPessoa.text,
            sexo: '',
            descendencia: DescendenciaModels(
              descricao: controllerDescendencia.text,
              sigla: '',
            ),
            lider: '',
          ),
          dataUltimaVisita: controllerDataUltimaVisita.text,
          totalVisitas: 0,
          pedidoOracao: controllerPedidoOracao.text,
          numeroTelefone: controllerNumeroTelefone.text,
          nomeLiderCelula: controllerNomeLiderCelula.text,
          convidadoPor: controllerConvidadoPor.text,
          descendencia: DescendenciaModels(
            descricao: controllerDescendencia.text,
            sigla: controllerDescendencia.text,
          ),
          descritionDto: Descrition(id: '', descricao: ''),
          estaEmCelula: controllerEstaEmCelula.text,
          id: '',
          tipoConversao: Descrition(
              id: '',
              descricao: controllerTipoConversao
                  .text) /*Descrition(id: '', descricao: controllerTipoConversao.text)*/);

      if (index != null) {
        visitaProvider.lifes[index] = novaVisita;
      } else {
        //quantidades de visitante
        int visitantesLength = visitaProvider.lifes.length;

        // Salva um novo visitante
        visitaProvider.lifes.insert(visitantesLength, novaVisita);

        // navegar para a pagina visitante
        context.pop('/visitante');
      }
    }

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
              key: _key,
              child: SingleChildScrollView(
                padding: const EdgeInsets.all(15),
                child: Column(
                  children: [
                    /*DropdownButtonFormField<String>(
                      decoration: InputDecoration(
                        filled: true,
                        fillColor: Colors.white,
                        labelText: 'Situação',
                        labelStyle: const TextStyle(
                            color: Colors.black, fontWeight: FontWeight.bold),
                        border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(25),
                            borderSide: BorderSide.none),
                      ),
                      hint: Text('Selecione uma opção'),
                      value: controllerTipoConversao.text,
                      onChanged: (String? newValue) {
                        setState(() {
                          situacaoSelecionada = newValue!;
                        });
                      },
                      items: situacao.map((String valor) {
                        return DropdownMenuItem<String>(
                          value: valor,
                          child: Text(valor),
                        );
                      }).toList(),
                    ),
                    const SizedBox(
                      height: 25,
                    ),*/
                    FieldFormButton(
                      label: 'Nome',
                      controllerButton: controllerPessoa,
                      validator: (value) {
                        // Adicione isso
                        if (value == null || value.isEmpty) {
                          return 'O nome não pode estar em branco!';
                        }
                        return null;
                      },
                    ),
                    const SizedBox(
                      height: 25,
                    ),
                    FieldFormButton(
                        label: 'Data',
                        controllerButton: controllerDataUltimaVisita),
                    const SizedBox(
                      height: 25,
                    ),
                    TextFormField(
                      controller: controllerNumeroTelefone,
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
                      validator: validarNumeroTelefone,
                    ),
                    const SizedBox(
                      height: 25,
                    ),
                    FieldFormButton(
                        label: 'Descrição',
                        controllerButton: controllerTipoConversao),
                    const SizedBox(
                      height: 25,
                    ),
                    FieldFormButton(
                        label: 'Está em Célula?',
                        controllerButton: controllerEstaEmCelula),
                    const SizedBox(
                      height: 25,
                    ),
                    FieldFormButton(
                      label: 'Convidado Por?',
                      controllerButton: controllerConvidadoPor,
                    ),
                    const SizedBox(
                      height: 25,
                    ),
                    FieldFormButton(
                      label: 'Observção',
                      controllerButton: controllerTipoConversao,
                    ),
                    const SizedBox(height: 50),
                    ElevatedButton(
                      style: ButtonStyle(
                          backgroundColor: WidgetStatePropertyAll(
                              GlobalColor.AzulEscuroClaroColor)),
                      onPressed: savenovalifes,
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

  String? validarNumeroTelefone(String? value) {
    if (value == null || value.isEmpty) {
      return 'O campo não pode ficaem branco';
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
