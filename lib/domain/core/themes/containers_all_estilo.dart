// ignore_for_file: prefer_const_constructors, unnecessary_this

import 'package:flutter/material.dart';

//import '../cores/global_colors.dart';

class ContainerAll extends StatelessWidget {
  final Widget child;
  const ContainerAll({super.key, required this.child});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.all(15),
      padding: EdgeInsets.all(15),
      decoration: BoxDecoration(
        //color: GlobalColor.AzulEscuroClaroColor,
        //color: Color.fromRGBO(235, 229, 229, 0.5),
        color: Colors.grey.shade500,
        borderRadius: BorderRadius.circular(20)
      ),
      child: this.child,
    );
  }
}