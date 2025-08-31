import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:i12mobile/domain/core/themes/containers_all_estilo.dart';
import 'package:i12mobile/data/provider/escada_do_sucesso_provider/alunos_providers/alunos_ecd_provider.dart';
import 'package:i12mobile/domain/models/model/discipular/ecd_aluno_model.dart';
import 'package:i12mobile/domain/models/model/discipular/ecd_model.dart';
import 'package:i12mobile/domain/models/model/discipular/ecd_modulo_model.dart';
import 'package:i12mobile/domain/models/model/igreja.dart';
import 'package:provider/provider.dart';

import '../../../domain/core/themes/global_colors.dart';
import '../../../domain/models/model/descendencia.dart';
import '../../../domain/models/model/pessoas_discipulos_models.dart';
import '../../../domain/models/model/pessoas_models.dart';
import '../../../domain/models/shared/descrition_model.dart';
import '../../../domain/models/shared/endereco_model.dart';
import '../../widgets/field_form_button.dart';

class AlunosEcdForm extends StatefulWidget {
  const AlunosEcdForm({super.key});

  @override
  State<AlunosEcdForm> createState() => _AlunosEcdFormState();
}

class _AlunosEcdFormState extends State<AlunosEcdForm> {
  String title = 'Novo Aluno(a)';

  TextEditingController controllerPessoa = TextEditingController();
  TextEditingController controllerEscola = TextEditingController();
  TextEditingController controllerComprouLivro = TextEditingController();
  TextEditingController controllerValorLivro = TextEditingController();
  TextEditingController controllerComprouCamisa = TextEditingController();
  TextEditingController controllervalorCamisa = TextEditingController();
  TextEditingController controllerId = TextEditingController();
  TextEditingController controllerDescritionDto = TextEditingController();
  TextEditingController controllerDataInscricao = TextEditingController();
  TextEditingController controllerDescendencia = TextEditingController();

  @override
  Widget build(BuildContext context) {
    AlunosEcdProvider alunosEcdProvider =
        Provider.of<AlunosEcdProvider>(context);

    int? index;

    if (alunosEcdProvider.indexEcdAluno != null) {
      index = alunosEcdProvider.indexEcdAluno;

      controllerPessoa.text = alunosEcdProvider.ecdAlunosSelected!.pessoa.nome;
      controllerEscola.text =
          alunosEcdProvider.ecdAlunosSelected!.escola.descricao;
      controllerComprouLivro.text =
          alunosEcdProvider.ecdAlunosSelected!.comprouLivro ? 'Sim' : 'Não';
      controllerComprouCamisa.text =
          alunosEcdProvider.ecdAlunosSelected!.comprouCamisa ? 'Sim' : 'Não';
      controllerValorLivro.text =
          alunosEcdProvider.ecdAlunosSelected!.valorPagoLivro.toString();
      controllervalorCamisa.text =
          alunosEcdProvider.ecdAlunosSelected!.valorPagoCamisa.toString();
      controllerDataInscricao.text =
          alunosEcdProvider.ecdAlunosSelected!.dataInscricao;
      setState(() {
        this.title = 'Edit Aluno';
      });
    }

    GlobalKey<FormState> _key = GlobalKey();

    void saveAlunoEcd() {
      final isValidateAlunoEcd = _key.currentState?.validate();

      if (isValidateAlunoEcd == false) {
        return;
      }

      _key.currentState?.save();

      int modulo = int.tryParse(controllerEscola.text) ?? 0;
      int totalAlunos = int.tryParse(controllerEscola.text) ?? 0;
      int valorLivro = int.tryParse(controllerValorLivro.text) ?? 0;
      int valorCamisa = int.tryParse(controllervalorCamisa.text) ?? 0;

      EcdAluno ecdAluno = EcdAluno(
          id: controllerId.text,
          descritionDto: Descrition(id: '', descricao: ''),
          escola: EcdModel(
            dataConclusao: '',
            dataInicio: '',
            descricao: '',
            descritionDto: Descrition(id: '', descricao: ''),
            id: controllerId.text,
            igreja: IgrejaModels(
                razaoSocial: '',
                sigla: '',
                nomeFantasia: '',
                documento: '',
                id: controllerId.text,
                descritionDto: Descrition(
                    id: controllerId.text,
                    descricao: controllerDescritionDto.text)),
            localAula: '',
            modulo: EcdModulo(
                id: controllerId.text,
                descritionDto: Descrition(id: '', descricao: ''),
                descricao: '',
                nivel: modulo,
                livro: modulo),
            totalAlunos: totalAlunos,
          ),
          comprouLivro:
              controllerComprouLivro.text.trim().toLowerCase() == 'true' ||
                  controllerComprouLivro.text.trim().toLowerCase() == 'sim',
          valorPagoLivro: valorLivro,
          comprouCamisa:
              controllerComprouCamisa.text.trim().toLowerCase() == 'true' ||
                  controllerComprouCamisa.text.trim().toLowerCase() == 'sim',
          pessoa: PessoasModels(
              igreja: IgrejaModels.empty(),
              id: controllerId.text, // Usando o controller para pegar o valor
              descritionDto: Descrition(
                  id: '',
                  descricao: ''), // Usando o controller para o descrition
              nome: '',
              sexo: '',
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
                  igreja: IgrejaModels.empty()),
              lider: '',
              telefone: '',
              dataNascimento: DateTime(1900, 1, 1),
              idade: 0,
              endereco: Endereco.empty(),
              totalCelulas: 0,
              pessoasDiscipulos: PessoasDiscipulosModels.empty()),
          valorPagoCamisa: valorCamisa,
          dataInscricao: '');

      if (index != null) {
        alunosEcdProvider.ecdAlunos[index] = ecdAluno;
      } else {
        int alunosEcdLength = alunosEcdProvider.ecdAlunos.length;

        // Salva um novo Aluno
        alunosEcdProvider.ecdAlunos.insert(alunosEcdLength, ecdAluno);

        // Navegar para pagina anterior
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
                      label: 'Aluno', controllerButton: controllerPessoa),
                  const SizedBox(
                    height: 25,
                  ),
                  FieldFormButton(
                      label: 'ComprouLivro?',
                      controllerButton: controllerComprouLivro),
                  const SizedBox(
                    height: 25,
                  ),
                  FieldFormButton(
                      label: 'ComprouCamisa',
                      controllerButton: controllerComprouCamisa),
                  const SizedBox(
                    height: 25,
                  ),
                  FieldFormButton(
                      label: 'Data da Inscrição',
                      controllerButton: controllerDataInscricao),
                  const SizedBox(
                    height: 50,
                  ),
                  TextButton(
                    onPressed: saveAlunoEcd,
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
