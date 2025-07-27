// ignore_for_file: unnecessary_null_comparison

import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:i12mobile/data/provider/escada_do_sucesso_provider/nova_vida_provider.dart';
import 'package:provider/provider.dart';

import '../../../domain/core/themes/containers_all_estilo.dart';
import '../../../domain/core/themes/global_colors.dart';
import '../../../domain/models/model/descendencia.dart';
import '../../../domain/models/model/ganhar/visita_models.dart';
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
    NovaLifeProvider novaLifeProvider = Provider.of<NovaLifeProvider>(context);
    int? index;

    if (novaLifeProvider.indexLifes != null) {
      controllerPessoa.text = novaLifeProvider.lifesSelected!.pessoa.nome;
      controllerDataUltimaVisita.text =
          novaLifeProvider.lifesSelected!.dataUltimaVisita;
      controllerPedidoOracao.text =
          novaLifeProvider.lifesSelected!.pedidoOracao;
      controllerNumeroTelefone.text =
          novaLifeProvider.lifesSelected!.numeroTelefone;
      controllerDescendencia.text =
          novaLifeProvider.lifesSelected!.descendencia.sigla;
      controllerConvidadoPor.text =
          novaLifeProvider.lifesSelected!.convidadoPor;
      controllerTipoConversao.text =
          novaLifeProvider.lifesSelected!.tipoConversao;
      controllerEstaEmCelula.text =
          novaLifeProvider.lifesSelected!.estaEmCelula;
      controllerTotalVisitas.text =
          novaLifeProvider.lifesSelected!.totalVisitas.toString();

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

      VisitaModels novaVisita = VisitaModels(
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
          tipoConversao: controllerTipoConversao
              .text /*Descrition(id: '', descricao: controllerTipoConversao.text)*/);

      if (index != null) {
        novaLifeProvider.lifes[index] = novaVisita;
      } else {
        //quantidades de visitante
        int visitantesLength = novaLifeProvider.lifes.length;

        // Salva um novo visitante
        novaLifeProvider.lifes.insert(visitantesLength, novaVisita);

        // navegar para a pagina visitante
        context.pop('/visitante');
      }
    }

    return Scaffold(
      appBar: AppBar(
        iconTheme: const IconThemeData(color: Colors.white),
        backgroundColor: GlobalColor.AzulEscuroClaroColor,
        centerTitle: true,
        title: Text(title,
            style: const TextStyle(
                color: Colors.white,
                fontSize: 22,
                fontWeight: FontWeight.bold)),
      ),
      body: ContainerAll(
        child: Form(
          key: _key,
          child: SingleChildScrollView(
            padding: const EdgeInsets.all(15),
            child: Column(
              children: [
                FieldFormButton(
                    label: 'Nome', controllerButton: controllerPessoa),
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
