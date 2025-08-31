import 'package:flutter/material.dart';

import '../../domain/core/themes/global_colors.dart' show GlobalColor;

class EventosScreen extends StatefulWidget {
  const EventosScreen({super.key});

  @override
  State<EventosScreen> createState() => _EventosScreenState();
}

class _EventosScreenState extends State<EventosScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: GlobalColor.backGroudPrincipal,
    );
  }
}
