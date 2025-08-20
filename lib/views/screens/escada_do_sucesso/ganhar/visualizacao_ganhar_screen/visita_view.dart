// ignore_for_file: unnecessary_this

/*import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:i12mobile/views/widgets/field_form_button.dart';
import 'package:i12mobile/domain/core/themes/containers_all_estilo.dart';
import 'package:i12mobile/domain/core/themes/global_colors.dart';
import 'package:provider/provider.dart';

import '../../../data/provider/escada_do_sucesso_provider/visitas_provider.dart';

class NovaLifeView extends StatefulWidget {
  const NovaLifeView({super.key});

  @override
  State<NovaLifeView> createState() => _NovaLifeViewState();
}

class _NovaLifeViewState extends State<NovaLifeView> {
  String title = 'View Visitante';

  TextEditingController controllerPessoa = TextEditingController();
  TextEditingController controllerDataUltimaVisita = TextEditingController();
  TextEditingController controllerPedidoOracao = TextEditingController();
  TextEditingController controllerNumeroTelefone = TextEditingController();
  TextEditingController controllerDescendencia = TextEditingController();
  TextEditingController controllerIgreja = TextEditingController();
  TextEditingController controllerNomeLiderCelula = TextEditingController();
  TextEditingController controllerTipoEvento = TextEditingController();
  TextEditingController controllerConvidadoPor = TextEditingController();
  TextEditingController controllerEstaEmCelula = TextEditingController();
  TextEditingController controllerId = TextEditingController();
  TextEditingController controllerDescritionDto = TextEditingController();
  TextEditingController controllerEndereco = TextEditingController();
  TextEditingController controllerTipoConversao = TextEditingController();

  // Controladores de endereço
  final TextEditingController controllerLogradouro = TextEditingController();
  final TextEditingController controllerNumero = TextEditingController();
  final TextEditingController controllerBairro = TextEditingController();
  final TextEditingController controllerCidade = TextEditingController();
  final TextEditingController controllerEstado = TextEditingController();
  final TextEditingController controllerCep = TextEditingController();

  @override
  Widget build(BuildContext context) {
    //NovaLifeProvider novaLifeProvider = NovaLifeProvider.of(context) as NovaLifeProvider;
    VisitaProvider visitaProvider =
        Provider.of<VisitaProvider>(context);

    int? index;

    //Controlla oque vai ser ixibido na dela de View
    if (visitaProvider.indexLifes != null) {
      controllerPessoa.text = visitaProvider.lifesSelected!.pessoa.nome;
      controllerDataUltimaVisita.text =
          visitaProvider.lifesSelected!.dataUltimaVisita;
      controllerPedidoOracao.text = visitaProvider.lifesSelected!.pedidoOracao;
      controllerNumeroTelefone.text =
          visitaProvider.lifesSelected!.numeroTelefone;
      controllerDescendencia.text =
          visitaProvider.lifesSelected!.descendencia.descricao;
      controllerConvidadoPor.text = visitaProvider.lifesSelected!.convidadoPor;
      controllerTipoConversao.text =
          visitaProvider.lifesSelected!.tipoConversao.toString();
      controllerEstaEmCelula.text = visitaProvider.lifesSelected!.estaEmCelula;
    }

    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        iconTheme: const IconThemeData(color: Colors.white),
        backgroundColor: GlobalColor.AzulEscuroClaroColor,
        title: Text(
          this.title,
          style: const TextStyle(
              color: Colors.white, fontSize: 22, fontWeight: FontWeight.bold),
        ),
      ),
      body: ContainerAll(
        child: Center(
          child: SingleChildScrollView(
            child: SafeArea(
              child: Column(
                children: [
                  FieldFormButton(
                    label: 'Situação',
                    controllerButton: controllerTipoConversao,
                  ),
                  const SizedBox(
                    height: 25,
                  ),
                  FieldFormButton(
                    label: 'Nome',
                    controllerButton: controllerPessoa,
                  ),
                  const SizedBox(
                    height: 25,
                  ),
                  FieldFormButton(
                    label: 'Data',
                    controllerButton: controllerDataUltimaVisita,
                  ),
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
                            borderSide: BorderSide.none)),
                  ),
                  const SizedBox(
                    height: 25,
                  ),
                  FieldFormButton(
                    label: 'Descendência',
                    controllerButton: controllerDescendencia,
                  ),
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
                    label: 'EstaEmCelula?',
                    controllerButton: controllerEstaEmCelula,
                  ),
                  const SizedBox(
                    height: 25,
                  ),
                  FieldFormButton(
                    label: 'Pedido de Oração?',
                    controllerButton: controllerPedidoOracao,
                  ),
                  const SizedBox(
                    height: 50,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      TextButton(
                        onPressed: () {
                          context.push('/createrVisitante');
                        },
                        style: ButtonStyle(
                            backgroundColor: WidgetStatePropertyAll(
                                GlobalColor.AzulEscuroClaroColor)),
                        child: const Text(
                          'Edit',
                          style: TextStyle(
                              fontWeight: FontWeight.bold,
                              color: Colors.white,
                              fontSize: 19),
                        ),
                      ),
                      const SizedBox(
                        width: 15,
                      ),
                      TextButton(
                        onPressed: () {
                          visitaProvider.indexLifes = null;
                          visitaProvider.lifes.removeAt(index!);
                          context.push('/createrVisitante');
                        },
                        style: ButtonStyle(
                            backgroundColor: WidgetStatePropertyAll(
                                GlobalColor.AzulEscuroClaroColor)),
                        child: const Text(
                          'Deleter',
                          style: TextStyle(
                              fontWeight: FontWeight.bold,
                              color: Colors.white,
                              fontSize: 19),
                        ),
                      )
                    ],
                  )
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}*/
