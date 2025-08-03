// ignore_for_file: must_be_immutable

import 'package:flutter/material.dart';

class FieldFormButton extends StatelessWidget {
  String label;
  TextEditingController controllerButton;
  final String? Function(String?)? validator;

  FieldFormButton(
      {super.key,
      required this.label,
      required this.controllerButton,
      this.validator});

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: controllerButton,
      validator: validator,
      decoration: InputDecoration(
          filled: true,
          fillColor: Colors.white,
          labelText: label,
          labelStyle:
              const TextStyle(color: Colors.black, fontWeight: FontWeight.bold),
          border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(25),
              borderSide: BorderSide.none)),
    );
  }
}
