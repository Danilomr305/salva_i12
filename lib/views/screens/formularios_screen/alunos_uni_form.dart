import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:i12mobile/data/provider/escada_do_sucesso_provider/alunos_providers/alunos_uni_vida_provider.dart';
import 'package:i12mobile/domain/models/model/consolidar/univida_aluno_model.dart';
import 'package:i12mobile/domain/models/model/consolidar/univida_model.dart';
import 'package:i12mobile/domain/core/themes/containers_all_estilo.dart';
import 'package:i12mobile/views/widgets/field_form_button.dart';
import 'package:provider/provider.dart';

import '../../../domain/models/model/descendencia.dart';
import '../../../domain/models/model/igreja.dart';
import '../../../domain/models/model/pessoas_discipulos_models.dart';
import '../../../domain/models/model/pessoas_models.dart';
import '../../../domain/models/shared/descrition_model.dart';
import '../../../domain/core/themes/global_colors.dart';
import '../../../domain/models/shared/endereco_model.dart';

class Alunos_Uni_form extends StatefulWidget {
  const Alunos_Uni_form({super.key});

  @override
  State<Alunos_Uni_form> createState() => _Alunos_Uni_formState();
}

class _Alunos_Uni_formState extends State<Alunos_Uni_form> {
  String title = 'Novo Aluno(a)';

  TextEditingController controllerIgreja = TextEditingController();
  TextEditingController controllerPessoa = TextEditingController();
  TextEditingController controllerUniversidadeDaVida = TextEditingController();
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
    AlunosUniVidaProvider alunosUniVidaProvider =
        Provider.of<AlunosUniVidaProvider>(context);

    int? index;

    if (alunosUniVidaProvider.indexUniVidaAluno != null) {
      index = alunosUniVidaProvider.indexUniVidaAluno;

      // Preenchendo os controladores com os valores do objeto selecionado
      controllerIgreja.text =
          alunosUniVidaProvider.uniVidaAlunoSelected!.igreja.sigla;
      controllerPessoa.text =
          alunosUniVidaProvider.uniVidaAlunoSelected!.pessoa.nome;
      controllerUniversidadeDaVida.text = alunosUniVidaProvider
          .uniVidaAlunoSelected!.universidadeDaVida.dataInicio;

      // Convertendo os valores booleanos para strings
      controllerComprouLivro.text =
          alunosUniVidaProvider.uniVidaAlunoSelected!.comprouLivro
              ? 'Sim'
              : 'Não';
      controllerComprouCamisa.text =
          alunosUniVidaProvider.uniVidaAlunoSelected!.comprouCamisa
              ? 'Sim'
              : 'Não';

      controllerValorLivro.text =
          alunosUniVidaProvider.uniVidaAlunoSelected!.valorLivro;
      controllervalorCamisa.text =
          alunosUniVidaProvider.uniVidaAlunoSelected!.valorPagoCamisa;
      controllerDataInscricao.text =
          alunosUniVidaProvider.uniVidaAlunoSelected!.dataInscricao;

      setState(() {
        this.title = 'Edit Aluno'; // Atualiza o título
      });
    }

    GlobalKey<FormState> _key = GlobalKey();
    void saveAlunoUniVida() {
      final isValidateAlunoUniVida = _key.currentState?.validate();

      if (isValidateAlunoUniVida == false) {
        return;
      }
      _key.currentState?.save();

      int totalAlunos = int.tryParse(controllerIgreja.text) ?? 0;

      UniVidaAluno uniVidaAluno = UniVidaAluno(
          id: controllerId.text,
          descritionDto: Descrition(id: '', descricao: ''),
          igreja: IgrejaModels(
              razaoSocial: '',
              sigla: '',
              nomeFantasia: controllerIgreja.text,
              documento: '',
              id: controllerId.text,
              descritionDto: Descrition(
                  id: controllerId.text,
                  descricao: controllerDescritionDto.text)),
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
          universidadeDaVida: UniVida(
            id: '',
            descritionDto: Descrition(id: '', descricao: ''),
            igreja: IgrejaModels(
                razaoSocial: '',
                sigla: '',
                nomeFantasia: controllerIgreja.text,
                documento: '',
                id: controllerId.text,
                descritionDto: Descrition(
                    id: controllerId.text,
                    descricao: controllerDescritionDto.text)),
            descricao: '',
            licaoAtual: '',
            dataInicio: '',
            dataConclusao: 'dataConclusao',
            totalAlunos: totalAlunos,
            localAula: '',
          ),
          comprouLivro:
              controllerComprouLivro.text.trim().toLowerCase() == 'true' ||
                  controllerComprouLivro.text.trim().toLowerCase() == 'sim',
          comprouCamisa:
              controllerComprouCamisa.text.trim().toLowerCase() == 'true' ||
                  controllerComprouCamisa.text.trim().toLowerCase() == 'sim',
          valorLivro: '',
          valorPagoCamisa: '',
          dataInscricao: '');

      if (index != null) {
        alunosUniVidaProvider.uniVidaAlunos[index] = uniVidaAluno;
      } else {
        int alunosUniLength = alunosUniVidaProvider.uniVidaAlunos.length;

        // Salva um novo aluno
        alunosUniVidaProvider.uniVidaAlunos
            .insert(alunosUniLength, uniVidaAluno);

        // Navegar para a página anterior
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
                    onPressed: saveAlunoUniVida,
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


// Organizar tudo novamente