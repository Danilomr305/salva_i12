// ignore_for_file: must_be_immutable

import 'package:flutter/material.dart';

class FieldFormButton extends StatelessWidget {

  String label;
  TextEditingController controllerButton;

  FieldFormButton({
    super.key,
    required this.label,
    required this.controllerButton,
  });

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: controllerButton,
      decoration: InputDecoration(
        filled: true,
        fillColor: Colors.white,
        labelText: label,
        labelStyle: const TextStyle(color: Colors.black,fontWeight: FontWeight.bold),
        border: OutlineInputBorder(borderRadius: BorderRadius.circular(25),borderSide: BorderSide.none)
      ),
      
    );
  }
}