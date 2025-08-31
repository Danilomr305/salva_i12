import 'package:flutter/material.dart';

import 'package:i12mobile/data/provider/providers.dart';
import 'package:i12mobile/my_app.dart';
import 'package:provider/provider.dart';

void main() {
  runApp(MultiProvider(
    providers: providers,
    child: const MyApp(),
  ));
}
