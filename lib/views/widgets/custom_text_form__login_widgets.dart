// ignore_for_file: prefer_typing_uninitialized_variables

import 'package:flutter/material.dart';

class CustomTextFormLogin extends StatelessWidget {
  final controller;
  final String label;
  final bool obscureText;
  final hitText;
  final validator;
  final Widget? suffixIconWidget;

  const CustomTextFormLogin({
    super.key,
    required this.controller,
    required this.label,
    required this.obscureText,
    required this.hitText,
    required this.validator,
    this.suffixIconWidget,
  });

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      validator: validator,
      controller: controller,
      decoration: InputDecoration(
        filled: true,
        fillColor: Colors.white, // Fundo branco
        suffixIcon: suffixIconWidget,
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(25),
          borderSide: BorderSide(
            color: Colors.transparent, // Sem borda colorida
            width: 0,
          ),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(25),
          borderSide: BorderSide(
            color: Colors.transparent, // Continua sem borda ao focar
            width: 0,
          ),
        ),
        labelText: label,
        labelStyle: TextStyle(
          color: Colors.blue.shade700, // Label azul
          fontSize: 16,
          fontWeight: FontWeight.bold,
        ),
        hintText: hitText,
        hintStyle: TextStyle(
          color: Colors.blue.shade400, // Hint azul clarinho
        ),
      ),
      obscureText: obscureText,
      cursorColor: Colors.blue.shade700,
      style: TextStyle(
        color: Colors.blue.shade700, // Texto azul
      ),
    );
  }
}
