// ignore_for_file: no_leading_underscores_for_local_identifiers, unnecessary_this

import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:i12mobile/data/provider/escada_do_sucesso_provider/ganhar/rota_da_vida_provider.dart';
import 'package:i12mobile/domain/models/model/ganhar/rota_da_vida_models.dart';
import 'package:i12mobile/domain/core/themes/containers_all_estilo.dart';
import 'package:provider/provider.dart';

import '../../../../../domain/models/model/descendencia.dart';
import '../../../../../domain/models/model/igreja.dart';
import '../../../../../domain/models/model/pessoas_discipulos_models.dart';
import '../../../../../domain/models/model/pessoas_models.dart';
import '../../../../../domain/models/shared/descrition_model.dart';
import '../../../../../domain/core/themes/global_colors.dart';
import '../../../../../domain/models/shared/endereco_model.dart';
import '../../../../widgets/field_form_button.dart';

class RotaDaVidaForm extends StatefulWidget {
  const RotaDaVidaForm({super.key});

  @override
  State<RotaDaVidaForm> createState() => _RotaDaVidaFormState();
}

class _RotaDaVidaFormState extends State<RotaDaVidaForm> {
  String title = "Rota Da Vida";

  TextEditingController controllerPessoa = TextEditingController();
  TextEditingController controllerEstaEmCelula = TextEditingController();
  TextEditingController controllerDataInscricaoUniVida =
      TextEditingController();
  TextEditingController controllerId = TextEditingController();
  TextEditingController controllerDescritionDto = TextEditingController();
  TextEditingController controllerDescendencia = TextEditingController();

  @override
  Widget build(BuildContext context) {
    // RotaDaVidaProvider rotaDaVidaProvider = RotaDaVidaProvider.of(context);
    RotaDaVidaProvider rotaDaVidaProvider =
        Provider.of<RotaDaVidaProvider>(context);

    int? index;

    if (rotaDaVidaProvider.indexRotas != null) {
      index = rotaDaVidaProvider.indexRotas;
      controllerPessoa.text = rotaDaVidaProvider.rotasSelected!.pessoa.nome;
      controllerEstaEmCelula.text =
          rotaDaVidaProvider.rotasSelected!.estaEmCelula;
      controllerDataInscricaoUniVida.text =
          rotaDaVidaProvider.rotasSelected!.dataInscricaoUniVida;

      setState(() {
        this.title = 'Edit Rota da Vida';
      });
    }

    GlobalKey<FormState> _key = GlobalKey();

    void saveRota() {
      final isValidateRotas = _key.currentState?.validate();

      if (isValidateRotas == false) {
        return;
      }

      _key.currentState?.save();

      // instancia de classe RotaDaVidaModels

      RotaDaVidaModels rotaModel = RotaDaVidaModels(
        pessoa: PessoasModels(
          igreja: IgrejaModels.empty(),
          id: controllerId.text, // Usando o controller para pegar o valor
          nome: controllerPessoa.text, // Usando o controller para pegar o nome
          sexo: '', // Preencha conforme necessário
          descendencia: DescendenciaModels(
              lider1: PessoasModels.empty(),
              lider2: PessoasModels.empty(),
              descricao: '',
              sigla: '',
              id: controllerId.text,
              descritionDto: Descrition(
                id: controllerId.text,
                descricao: controllerDescendencia.text,
              ),
              igreja: IgrejaModels.empty()), // Preencha conforme necessário
          lider: '',
          telefone: '',
          dataNascimento: DateTime(1900, 1, 1),
          idade: 0,
          endereco: Endereco.empty(),
          totalCelulas: 0,
          pessoasDiscipulos:
              PessoasDiscipulosModels.empty(), // Preencha conforme necessário
          descritionDto: Descrition(
              id: '', descricao: ''), // Usando o controller para o descrition
        ),
        estaEmCelula:
            controllerEstaEmCelula.text, // Usando o controller para o valor
        dataInscricaoUniVida: controllerDataInscricaoUniVida
            .text, // Usando o controller para o valor
        id: controllerId.text, // Usando o controller para o id
        descritionDto: Descrition(
            id: '', descricao: ''), // Usando o controller para o descrition
      );

      if (index != null) {
        rotaDaVidaProvider.rotas[index] = rotaModel;
      } else {
        //quantidades de pessoas
        int rotasLength = rotaDaVidaProvider.rotas.length;

        // Salva um novo visitante
        rotaDaVidaProvider.rotas.insert(rotasLength, rotaModel);

        // navegar para a pagina novalife
        context.pop('/rota');
      }
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
                    FieldFormButton(
                      label: 'Nome',
                      controllerButton: controllerPessoa,
                    ),
                    const SizedBox(
                      height: 25,
                    ),
                    FieldFormButton(
                      label: 'Inscrição Uni Vida',
                      controllerButton: controllerDataInscricaoUniVida,
                    ),
                    const SizedBox(
                      height: 25,
                    ),
                    FieldFormButton(
                      label: 'Esta em Celula',
                      controllerButton: controllerEstaEmCelula,
                    ),
                    const SizedBox(
                      height: 50,
                    ),
                    TextButton(
                      onPressed: saveRota,
                      style: const ButtonStyle(
                          backgroundColor:
                              WidgetStatePropertyAll(Colors.black)),
                      child: const Text(
                        'Salva',
                        style: TextStyle(
                            fontWeight: FontWeight.bold, color: Colors.white),
                      ),
                    )
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
