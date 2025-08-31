// ignore_for_file: prefer_const_constructors, avoid_unnecessary_containers, prefer_const_constructors_in_immutables

import 'package:flutter/material.dart';

class CarouselWidgets extends StatelessWidget {
  CarouselWidgets({super.key, required this.titulo, required this.texto});
  final String titulo;
  final String texto;

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.blue,
      child: Column(
        children: [
          Row(
            children: [
              Text(
                titulo, 
                style: TextStyle(
                  fontSize: 25,
                  fontWeight: FontWeight.bold,
                  letterSpacing: 1
                ),
              ),

              SizedBox(
                height: 10,
              ),

              Text(
                texto, 
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                  letterSpacing: 1
                ),
              ),
            ],
          )
        ],
      ),
    );
  }
}