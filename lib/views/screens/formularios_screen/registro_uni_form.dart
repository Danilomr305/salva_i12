import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:i12mobile/domain/core/themes/containers_all_estilo.dart';
import 'package:i12mobile/data/provider/escada_do_sucesso_provider/registros_aulas_providers/registros_aula_uni_provider.dart';
import 'package:i12mobile/domain/models/model/consolidar/univida_aula_models.dart';
import 'package:i12mobile/domain/models/model/consolidar/univida_licao_model.dart';
import 'package:i12mobile/domain/models/model/consolidar/univida_model.dart';
import 'package:i12mobile/domain/models/model/consolidar/univida_semana_model.dart';
import 'package:i12mobile/domain/models/model/descendencia.dart';
import 'package:i12mobile/domain/models/model/pessoas_models.dart';
import 'package:i12mobile/views/widgets/field_form_button.dart';
import 'package:provider/provider.dart';

import '../../../domain/core/themes/global_colors.dart';
import '../../../domain/models/model/igreja.dart';
import '../../../domain/models/model/pessoas_discipulos_models.dart';
import '../../../domain/models/shared/descrition_model.dart';
import '../../../domain/models/shared/endereco_model.dart';

class RegistroUniForm extends StatefulWidget {
  const RegistroUniForm({super.key});

  @override
  State<RegistroUniForm> createState() => _RegistroUniFormState();
}

class _RegistroUniFormState extends State<RegistroUniForm> {
  String title = 'Novo Registro';

  TextEditingController controllerUniVida = TextEditingController();
  TextEditingController controllerLicao = TextEditingController();
  TextEditingController controllerAulaTipo = TextEditingController();
  TextEditingController controllerProfessor = TextEditingController();
  //TextEditingController controllerAluno = TextEditingController();
  TextEditingController controllerId = TextEditingController();
  TextEditingController controllerDescritionDto = TextEditingController();
  TextEditingController controllerDataAula = TextEditingController();
  TextEditingController controllerDescendencia = TextEditingController();

  @override
  Widget build(BuildContext context) {
    RegistrosAulasUniProvider registrosAulasUniProvider =
        Provider.of<RegistrosAulasUniProvider>(context);

    int? index;

    if (registrosAulasUniProvider.indexRegistrosAula != null) {
      index = registrosAulasUniProvider.indexRegistrosAula;
      //controllerAluno.text = registrosAulasUniProvider.uniVidaAulaSelected!.aluno.toString();
      controllerAulaTipo.text =
          registrosAulasUniProvider.registrosUniSelected!.aulaTipo.descricao;
      controllerLicao.text =
          registrosAulasUniProvider.registrosUniSelected!.licao.descricao;
      controllerProfessor.text =
          registrosAulasUniProvider.registrosUniSelected!.professor.nome;

      setState(() {
        this.title = 'Edit Registro'; // Atualiza o título
      });
    }

    GlobalKey<FormState> _key = GlobalKey();

    void saveRegistroUni() {
      final isValidateRegistroUni = _key.currentState?.validate();

      if (isValidateRegistroUni == false) {
        return;
      }
      _key.currentState?.save();

      int totalAlunos = int.tryParse(controllerUniVida.text) ?? 0;

      UniVidaAula uniVidaAula = UniVidaAula(
        dataAula: controllerDataAula.text,
        id: controllerId.text, // Usando o controlador para o ID
        descritionDto: Descrition(id: '', descricao: ''),
        uniVida: UniVida(
          id: '', // Preencha conforme necessário ou use outro controlador
          descritionDto: Descrition(id: '', descricao: ''),
          igreja: IgrejaModels(
              razaoSocial: '',
              sigla: '',
              nomeFantasia: '',
              documento: '',
              id: controllerId.text,
              descritionDto: Descrition(
                  id: controllerId.text,
                  descricao: controllerDescritionDto.text)),
          descricao: '',
          licaoAtual: '',
          dataInicio: '',
          dataConclusao: '',
          totalAlunos: totalAlunos,
          localAula: '',
        ),
        aulaTipo: Descrition(id: '', descricao: ''),
        professor: PessoasModels(
            igreja: IgrejaModels.empty(),
            id: controllerId.text, // Usando o controlador para o ID
            descritionDto: controllerDescritionDto.text.isNotEmpty
                ? Descrition(id: '', descricao: '')
                : Descrition(descricao: '', id: ''),
            nome: controllerProfessor.text, // Usando o controlador para o nome
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
                PessoasDiscipulosModels.empty() // Preencha conforme necessário
            ),
        licao: UniVidaLicao(
          id: '',
          descritionDto: Descrition(id: '', descricao: ''),
          descricao: '',
          semana: UniVidaSemana(
            descricao: '',
            semanaNumero: 0,
            id: '',
            descritionDto: Descrition(id: '', descricao: ''),
          ),
          dia: 0,
          iD: '',
        ),
      );

      if (index != null) {
        registrosAulasUniProvider.uniAulasUnis[index] = uniVidaAula;
      } else {
        int registrosLength = registrosAulasUniProvider.uniAulasUnis.length;

        // Salva um novpo registro
        registrosAulasUniProvider.uniAulasUnis
            .insert(registrosLength, uniVidaAula);

        // Navegar para a pagina anterior
        Navigator.of(context).pop();
      }
    }

    return Scaffold(
      appBar: AppBar(
        iconTheme: const IconThemeData(color: Colors.white),
        backgroundColor: GlobalColor.AzulEscuroClaroColor,
        centerTitle: true,
        title: Text(this.title,
            style: const TextStyle(
                color: Colors.white,
                fontSize: 22,
                fontWeight: FontWeight.bold)),
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
                      label: 'Lição', controllerButton: controllerLicao),
                  const SizedBox(
                    height: 25,
                  ),
                  FieldFormButton(
                      label: 'Tipo de Aula',
                      controllerButton: controllerAulaTipo),
                  const SizedBox(
                    height: 25,
                  ),
                  FieldFormButton(
                      label: 'Professor',
                      controllerButton: controllerProfessor),
                  const SizedBox(
                    height: 25,
                  ),
                  FieldFormButton(
                      label: 'Data Aula', controllerButton: controllerDataAula),
                  const SizedBox(
                    height: 50,
                  ),
                  TextButton(
                    onPressed: saveRegistroUni,
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
        ),
      )),
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
