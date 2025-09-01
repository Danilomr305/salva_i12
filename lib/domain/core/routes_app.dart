import 'package:go_router/go_router.dart';
import 'package:i12mobile/domain/core/home_lib.dart';
import 'package:i12mobile/views/screens/boas_vinda_screen.dart';
import 'package:i12mobile/views/screens/esqueci_senha_screen.dart';
import 'package:i12mobile/views/screens/gestao_de_pessoas/descendencia/formularios_descendencia_screen/descendencia_form.dart';
import 'package:i12mobile/views/screens/gestao_de_pessoas/membros/formularios_membros_screen/membro_form.dart';
import 'package:i12mobile/views/screens/home/membros_page_wrapper.dart';
import 'package:i12mobile/views/screens/paginas_screen/pessoas_por_descendencia_page.dart';
import 'package:i12mobile/views/screens/paginas_screen/aluno_uni_page.dart';
import 'package:i12mobile/views/screens/formularios_screen/alunos_uni_form.dart';
import 'package:i12mobile/views/screens/formularios_screen/registro_uni_form.dart';
import 'package:i12mobile/views/screens/paginas_screen/minha_descendencia_page.dart';
import 'package:i12mobile/views/screens/paginas_screen/registro_uni_page.dart';
import 'package:i12mobile/views/screens/formularios_screen/uni_vida_form.dart';
import 'package:i12mobile/views/screens/paginas_screen/uni_vida_page.dart';
import 'package:i12mobile/views/screens/visualizacao_screen/uni_vida_view.dart';
import 'package:i12mobile/views/screens/formularios_screen/aluno_ecd_form.dart';
import 'package:i12mobile/views/screens/formularios_screen/ecd_form.dart';
import 'package:i12mobile/views/screens/paginas_screen/ecd_page.dart';
import 'package:i12mobile/views/screens/visualizacao_screen/ecd_view.dart';
import 'package:i12mobile/views/screens/visualizacao_screen/registros_ecd_view.dart';
import 'package:i12mobile/views/screens/escada_do_sucesso/ganhar/formularios_ganhar_screen/visita_form.dart';
import 'package:i12mobile/views/screens/escada_do_sucesso/ganhar/formularios_ganhar_screen/rota_da_vida_form.dart';
import 'package:i12mobile/views/screens/escada_do_sucesso/ganhar/paginas_ganhar_screen/rota_da_vida_page.dart';
import 'package:i12mobile/views/screens/login/login_screen.dart';
import 'package:i12mobile/views/screens/home/home_screen.dart';
import 'package:i12mobile/views/screens/gestao_de_pessoas/membros/visualizacao_membros_screen/pessoa_view.dart';
import 'package:i12mobile/views/screens/perfil_screen.dart';
import '../../views/screens/gestao_de_pessoas/descendencia/paginas_descendencia_screen/descendencia_page.dart';
import '../../views/screens/gestao_de_pessoas/descendencia/visualizacao_descendencia_screen/descendencia_view.dart';
import '../../views/screens/gestao_de_pessoas/membros/paginas_membros_screen/membros_page.dart';
import '../../views/screens/home/nova_life_page_wrapper.dart';
import '../../views/screens/visualizacao_screen/alunos_uni_view.dart';
import '../../views/screens/visualizacao_screen/registro_uni_view.dart';
import '../../views/screens/paginas_screen/aluno_ecd_page.dart';
import '../../views/screens/visualizacao_screen/aluno_ecd_view.dart';
import '../../views/screens/paginas_screen/registro_ecd_page.dart';
import '../../views/screens/formularios_screen/registro_ecd_form.dart';
import '../../views/screens/notificacoes_screen.dart';

final routes = GoRouter(initialLocation: '/boasVindas', routes: [
  //Paginas de inicio
  GoRoute(
    path: '/boasVindas',
    builder: (context, state) => const BoasVindasPage(),
  ),
  GoRoute(
    path: '/login',
    builder: (context, state) => const LoginScreen(),
  ),

  //Paginas de BarNavigator
  GoRoute(
    path: '/homeLib',
    builder: (context, state) => const HomeLib(),
  ),

  GoRoute(
    path: '/home',
    builder: (context, state) => const HomeScreen(),
  ),
  GoRoute(
    path: '/pessoas',
    //builder: (context, state) => const PessoaPage(),
    builder: (context, state) => const MembrosPage(),
  ),
  GoRoute(
    path: '/perfil',
    builder: (context, state) => const PerfilScreen(),
  ),
  GoRoute(
      path: '/alunoUni/:idUniVida',
      builder: (context, state) {
        final String? id = state.pathParameters['idUniVida'];
        print('$id');
        return AlunoUniPage(idUniVida: id);
      } //const AlunoUniPage(),
      ),
  GoRoute(
    path: '/pessoasDescendencia',
    builder: (context, state) {
      final sigla = state.extra as String;
      return PessoasPorDescendenciaPage(sigla: sigla);
    },
  ),

  GoRoute(
    path: '/esqueciSenha',
    builder: (context, state) => const EsqueciSenha(),
  ),

  GoRoute(
    path: '/registroUni/:idUniVida',
    builder: (context, state) {
      final String? id = state.pathParameters['idUniVida'];
      print('$id');
      return RegistroUniPage(idUniVida: id);
    },
  ),
  GoRoute(
    path: '/alunoEcd/:idEcd',
    builder: (context, state) {
      final String? id = state.pathParameters['idEcd'];
      print('$id');
      return AlunoEcdPage(
        idEcd: id,
      );
    },
  ),

  GoRoute(
      path: '/registroEcd/:idEcd',
      builder: (context, state) {
        final String? id = state.pathParameters['idEcd'];
        print('$id');
        return RegistroEcdPage(idEcd: id);
      }),

  //Paginas de criação de um nova pessoa
  GoRoute(
    path: '/createrMembro/:igrejaId',
    builder: (context, state) {
      // Pega o ID da URL e o passa para a NovaVidaForm
      final String? igrejaId = state.pathParameters['igrejaId'];
      return MembroForm(igrejaId: igrejaId);
    },
  ),
  GoRoute(
    path: '/createrVisitante/:igrejaId',
    builder: (context, state) {
      // Pega o ID da URL e o passa para a NovaVidaForm
      final String? igrejaId = state.pathParameters['igrejaId'];
      return NovaVidaForm(igrejaId: igrejaId);
    },
  ),

  GoRoute(
    path: '/createrDescendencia',
    builder: (context, state) => const DescendenciaForm(),
  ),
  GoRoute(
    path: '/createrRota',
    builder: (context, state) => const RotaDaVidaForm(),
  ),
  GoRoute(
    path: '/createrUniVida',
    builder: (context, state) => const UniVidaForm(),
  ),
  GoRoute(
    path: '/createrEcd',
    builder: (context, state) => const EcdForm(),
  ),
  GoRoute(
    path: '/createrAlunoUni',
    builder: (context, state) => const Alunos_Uni_form(),
  ),
  GoRoute(
    path: '/createrAlunoEcd',
    builder: (context, state) => const AlunosEcdForm(),
  ),

  GoRoute(
    path: '/createrRegistroUni',
    builder: (context, state) => const RegistroUniForm(),
  ),
  GoRoute(
    path: '/createrRegistroEcd',
    builder: (context, state) => const RegistroEcdForm(),
  ),

  //Paginas de visialização dos dados das pessoas
  GoRoute(
    path: '/viewPessoas',
    builder: (context, state) => const PessoaView(),
  ),
  /*GoRoute(
    path: '/viewVisitante',
    builder: (context, state) => const NovaLifeView(),
  ),*/
  GoRoute(
    path: '/viewDescendencia',
    builder: (context, state) => const DescendenciaView(),
  ),
  GoRoute(
    path: '/viewUniVida',
    builder: (context, state) => const UniVidaView(),
  ),
  GoRoute(
    path: '/viewEcd',
    builder: (context, state) => const EcdView(),
  ),
  GoRoute(
    path: '/viewAlunoUni',
    builder: (context, state) => AlunoUniView(),
  ),
  GoRoute(
    path: '/viewAlunoEcd',
    builder: (context, state) => AlunoEcdView(),
  ),
  GoRoute(
    path: '/viewregistroUni',
    builder: (context, state) => RegistroUniView(),
  ),
  GoRoute(
    path: '/viewAlunoEcd',
    builder: (context, state) => RegistrosEcdView(),
  ),

  //Pagina de notificação
  GoRoute(
    path: '/notification',
    builder: (context, state) => const NotificacoesPage(),
  ),

  //Paginas do Drawer

  GoRoute(
    path: '/minhaDescendencia',
    builder: (context, state) {
      final sigla = state.extra as String;
      return MinhaDescendenciaPage(sigla: sigla);
    },
  ),

  GoRoute(
    path: '/membros',
    builder: (context, state) {
      return const MembrosPageWrapper();
    },
  ),
  GoRoute(
    path: '/novaVida',
    builder: (context, state) {
      return const NovaLifePageWrapper();
    },
  ),

  GoRoute(
    path: '/descendencia',
    builder: (context, state) => const DescendenciaPage(),
  ),
  GoRoute(
    path: '/rota',
    builder: (context, state) => const RotaDaVidaPage(),
  ),
  GoRoute(
    path: '/uniVida',
    builder: (context, state) => const UniVidaPage(),
  ),
  GoRoute(
    path: '/ecd',
    builder: (context, state) => const EcdPage(),
  ),
]);
