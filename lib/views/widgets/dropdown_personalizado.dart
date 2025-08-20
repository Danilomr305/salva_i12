import 'package:flutter/material.dart';

class DropdownPersonalizado extends StatelessWidget {
  final String label;
  final String hint;
  final String? valorSeleconado;
  final List<String> itens;
  final void Function(String?)? onChanged;
  final String? Function(String?)? validator;

  const DropdownPersonalizado(
      {super.key,
      required this.label,
      required this.hint,
      this.valorSeleconado,
      required this.itens,
      this.onChanged,
      this.validator});

  @override
  Widget build(BuildContext context) {
    return DropdownButtonFormField(
      decoration: InputDecoration(
        filled: true,
        fillColor: Colors.white,
        labelText: label, // Usando o parâmetro
        labelStyle:
            const TextStyle(color: Colors.black, fontWeight: FontWeight.bold),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(25),
          borderSide: BorderSide.none,
        ),
      ),
      value: valorSeleconado,
      hint: Text(hint), // Usando o parâmetro
      items: itens.map((String valor) {
        return DropdownMenuItem<String>(
          value: valor,
          child: Text(valor),
        );
      }).toList(),
      onChanged: onChanged,
      validator: validator,
      isExpanded: true,
      iconSize: 24.0,
      iconEnabledColor: Colors.black54,
      style: TextStyle(color: Colors.black54, fontSize: 16.0),
    );
  }
}
