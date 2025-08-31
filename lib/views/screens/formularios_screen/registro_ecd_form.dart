import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:i12mobile/domain/core/themes/containers_all_estilo.dart';
import 'package:i12mobile/data/provider/escada_do_sucesso_provider/registros_aulas_providers/registros_aula_ecd_provider.dart';
import 'package:i12mobile/domain/models/model/descendencia.dart';
import 'package:i12mobile/domain/models/model/discipular/ecd_aula_model.dart';
import 'package:i12mobile/domain/models/model/discipular/ecd_licao_model.dart';
import 'package:i12mobile/domain/models/model/discipular/ecd_model.dart';
import 'package:i12mobile/domain/models/model/discipular/ecd_modulo_model.dart';
import 'package:provider/provider.dart';

import '../../../domain/core/themes/global_colors.dart';
import '../../../domain/models/model/igreja.dart';
import '../../../domain/models/model/pessoas_discipulos_models.dart';
import '../../../domain/models/model/pessoas_models.dart';
import '../../../domain/models/shared/descrition_model.dart';
import '../../../domain/models/shared/endereco_model.dart';
import '../../widgets/field_form_button.dart';

class RegistroEcdForm extends StatefulWidget {
  const RegistroEcdForm({super.key});

  @override
  State<RegistroEcdForm> createState() => _RegistroEcdFormState();
}

class _RegistroEcdFormState extends State<RegistroEcdForm> {
  String title = 'Novo Registro';

  TextEditingController controllerEscola = TextEditingController();
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
    RegistroAulaEcdProvider registroAulaEcdProvider =
        Provider.of<RegistroAulaEcdProvider>(context);

    int? index;

    if (registroAulaEcdProvider.indexRegistrosEcd != null) {
      index = registroAulaEcdProvider.indexRegistrosEcd;
      controllerAulaTipo.text =
          registroAulaEcdProvider.registrosEcdSelected!.aulaTipo.descricao;
      controllerLicao.text =
          registroAulaEcdProvider.registrosEcdSelected!.licao.descricao;
      controllerProfessor.text =
          registroAulaEcdProvider.registrosEcdSelected!.professor.nome;

      setState(() {
        this.title = 'Edit Registro'; // Atualiza o título
      });
    }

    GlobalKey<FormState> _key = GlobalKey();

    void saveRegistrosEcd() {
      final isValidateRegistroEcd = _key.currentState?.validate();

      if (isValidateRegistroEcd == false) {
        return;
      }
      _key.currentState?.save();

      int totalAlunos = int.tryParse(controllerEscola.text) ?? 0;

      EcdAula ecdAula = EcdAula(
        id: controllerId
            .text, // Use o valor do controlador ou inicialize de outra forma
        descritionDto: Descrition(id: '', descricao: ''),

        escola: EcdModel(
          id: controllerId.text,
          descritionDto: Descrition(id: '', descricao: ''),
          igreja: IgrejaModels.empty(),
          descricao: '',
          modulo: EcdModulo(
            id: controllerId.text,
            descritionDto: Descrition(id: '', descricao: ''),
            descricao: '',
            nivel: 0,
            livro: 0,
          ),
          dataInicio: '',
          dataConclusao: '',
          totalAlunos: totalAlunos, // Total de alunos obtido de algum lugar
          localAula: '',
        ),

        licao: EcdLicao(
          id: controllerId.text,
          descritionDto: Descrition(id: '', descricao: ''),
          descricao: '',
          modulo: EcdModulo(
            id: controllerId.text,
            descritionDto: Descrition(id: '', descricao: ''),
            descricao: '',
            nivel: 0,
            livro: 0,
          ),
          capitulo: 0,
        ),

        aulaTipo: Descrition(
            id: '',
            descricao:
                ''), // Valor de aulaTipo vazio ou ajustado conforme necessário

        professor: PessoasModels(
            igreja: IgrejaModels.empty(),
            id: controllerId
                .text, // Garantir que json seja passado corretamente
            descritionDto: Descrition(
                id: '', descricao: ''), // Usando o controller para o descrition
            nome: '', // Caso não haja valor para nome, inicialize como vazio
            sexo: '', // Caso não haja valor para sexo, inicialize como vazio
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
                igreja: IgrejaModels.empty()), // Inicializa com valores vazios
            lider: '',
            telefone: '',
            dataNascimento: DateTime(1900, 1, 1),
            idade: 0,
            endereco: Endereco.empty(),
            totalCelulas: 0,
            pessoasDiscipulos:
                PessoasDiscipulosModels.empty() // Inicialize com string vazia
            ),

        dataAula: controllerDataAula
            .text, // Use o controlador de data ou algum valor padrão
      );

      if (index != null) {
        registroAulaEcdProvider.ecdAulas[index] = ecdAula;
      } else {
        int registrosLengthEcd = registroAulaEcdProvider.ecdAulas.length;

        // Salva um novo registro
        registroAulaEcdProvider.ecdAulas.insert(registrosLengthEcd, ecdAula);

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
            padding: EdgeInsets.all(15),
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
                        label: 'Data Aula',
                        controllerButton: controllerDataAula),
                    const SizedBox(
                      height: 50,
                    ),
                    TextButton(
                      onPressed: saveRegistrosEcd,
                      style: const ButtonStyle(
                          backgroundColor:
                              WidgetStatePropertyAll(Colors.black)),
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
