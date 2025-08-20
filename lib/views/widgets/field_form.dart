// ignore_for_file: must_be_immutable, unnecessary_this

import 'package:flutter/material.dart';

class FieldForm extends StatelessWidget {
  String label;
  bool isPassword;
  TextEditingController controller;
  bool? isForm = true;
  bool isEmail = false;

  FieldForm({
    required this.label,
      required this.isPassword,
      required this.controller,
      this.isForm,
      required this.isEmail,
    super.key});

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      enabled: this.isForm,
      controller: controller,
      obscureText: isPassword,
      decoration: InputDecoration(
        filled: true,
        fillColor: Colors.white,
        labelText: label,
        labelStyle: const TextStyle(color: Colors.black,fontWeight: FontWeight.bold),
        border: OutlineInputBorder(borderRadius: BorderRadius.circular(25), borderSide: BorderSide.none)
      ),
      validator: (value) {
        if (value!.length < 3) {
          return 'Digite pelo menos 3 caracteres';
        }
        return null;
      },
    );
  }
}