// ignore_for_file: unnecessary_this, unnecessary_new, no_leading_underscores_for_local_identifiers

import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:i12mobile/domain/models/model/igreja.dart';
import 'package:i12mobile/domain/models/shared/descrition_model.dart';
import 'package:i12mobile/data/provider/cadastros_provides/pessoas_provider.dart';
import 'package:i12mobile/domain/core/themes/global_colors.dart';
import 'package:provider/provider.dart';
import '../../../../../domain/models/model/descendencia.dart';
import '../../../../../domain/models/model/pessoas_models.dart';
import '../../../../../domain/core/themes/containers_all_estilo.dart';
import '../../../../widgets/field_form.dart';

class PessoaForm extends StatefulWidget {
  const PessoaForm({super.key});

  @override
  State<PessoaForm> createState() => _PessoaFormState();
}

class _PessoaFormState extends State<PessoaForm> {
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
}
