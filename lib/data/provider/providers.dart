import 'package:i12mobile/data/provider/cadastros_provides/descendencia_provider.dart';
import 'package:i12mobile/data/provider/cadastros_provides/pessoas_provider.dart';
import 'package:i12mobile/data/provider/escada_do_sucesso_provider/alunos_providers/alunos_ecd_provider.dart';
import 'package:i12mobile/data/provider/escada_do_sucesso_provider/alunos_providers/alunos_uni_vida_provider.dart';
import 'package:i12mobile/data/provider/escada_do_sucesso_provider/ecd_provider.dart';
import 'package:i12mobile/data/provider/escada_do_sucesso_provider/nova_vida_provider.dart';
import 'package:i12mobile/data/provider/escada_do_sucesso_provider/registros_aulas_providers/registros_aula_ecd_provider.dart';
import 'package:i12mobile/data/provider/escada_do_sucesso_provider/registros_aulas_providers/registros_aula_uni_provider.dart';
import 'package:i12mobile/data/provider/escada_do_sucesso_provider/rota_da_vida_provider.dart';
import 'package:i12mobile/data/provider/escada_do_sucesso_provider/univida_provider.dart';
import 'package:i12mobile/data/provider/usuario_provider/usuario_provider.dart';
import 'package:provider/provider.dart';
import '../../domain/services/auth_service.dart';

final authService = AuthService();

final providers = [
  ChangeNotifierProvider<PessoaProvider>(
    create: (context) => PessoaProvider(),
  ),
  ChangeNotifierProvider<DescendenciaProvider>(
    create: (context) => DescendenciaProvider(),
  ),
  ChangeNotifierProvider<RotaDaVidaProvider>(
    create: (context) => RotaDaVidaProvider(),
  ),
  ChangeNotifierProvider<NovaLifeProvider>(
    create: (context) => NovaLifeProvider(),
  ),
  ChangeNotifierProvider<UsuarioProvider>(
    create: (context) => UsuarioProvider(),
  ),
  ChangeNotifierProvider<UniVidaProvider>(
    create: (context) => UniVidaProvider(),
  ),
  ChangeNotifierProvider<EcdProvider>(
    create: (context) => EcdProvider(),
  ),
  ChangeNotifierProvider<AlunosUniVidaProvider>(
    create: (context) => AlunosUniVidaProvider(),
  ),
  ChangeNotifierProvider<RegistrosAulasUniProvider>(
    create: (context) => RegistrosAulasUniProvider(),
  ),
  ChangeNotifierProvider<AlunosEcdProvider>(
    create: (context) => AlunosEcdProvider(),
  ),
  ChangeNotifierProvider<RegistroAulaEcdProvider>(
    create: (context) => RegistroAulaEcdProvider(),
  ),
  ChangeNotifierProvider<AuthService>.value(value: authService),
];
