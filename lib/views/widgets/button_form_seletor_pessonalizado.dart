import 'package:flutter/material.dart';
import 'package:i12mobile/domain/models/shared/select_item_personalisado.dart';

class ButtonFormSeletorPessonalizado extends StatefulWidget {
  final String label;
  final String tituloModal;
  final String value;
  final TextEditingController controller;
  final List<SelectItemPersonalisado> itens;
  final String? Function(String?)? validator;
  final void Function(String?)? onChanged;

  const ButtonFormSeletorPessonalizado(
      {super.key,
      required this.value,
      required this.label,
      required this.controller,
      required this.itens,
      this.tituloModal = 'Selecione uma opção', // Valor padrão
      this.validator,
      this.onChanged});

  @override
  State<ButtonFormSeletorPessonalizado> createState() =>
      _ButtonFormSeletorPessonalizadoState();
}

class _ButtonFormSeletorPessonalizadoState
    extends State<ButtonFormSeletorPessonalizado> {
  Map<String, String>? valorSelecionado;
  @override
  void initState() {
    super.initState();
    // Aqui garantimos que o controller comece com o valor correto
    widget.controller.text = widget.value;
  }

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: widget.controller,
      readOnly: true, // Essencial para o comportamento de toque
      decoration: InputDecoration(
        filled: true,
        fillColor: Colors.white,
        labelText: widget.label, // Usando o parâmetro
        labelStyle:
            const TextStyle(color: Colors.black, fontWeight: FontWeight.bold),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(25),
          borderSide: BorderSide.none,
        ),
      ),
      validator: widget.validator, // Usando o parâmetro

      // A mágica acontece aqui!
      onTap: () {
        FocusScope.of(context).unfocus();

        showModalBottomSheet(
          context: context,
          builder: (BuildContext context) {
            return Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Text(
                    widget.tituloModal, // Usando o título dinâmico
                    style: const TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 18,
                    ),
                  ),
                ),
                const Divider(height: 1),
                // Limita a altura da lista para não ocupar a tela toda
                LimitedBox(
                  maxHeight: MediaQuery.of(context).size.height * 0.4,
                  child: ListView.builder(
                    itemCount: widget.itens.length,
                    itemBuilder: (context, index) {
                      final item = widget.itens[index];
                      return ListTile(
                        title: Center(child: Text(widget.itens[index].label)),
                        onTap: () {
                          // Ao tocar, atualiza o controller e fecha a modal
                          // widget.controller.text = item.label;
                          widget.onChanged?.call(item.value);
                          Navigator.pop(context);
                        },
                      );
                    },
                  ),
                ),
              ],
            );
          },
        );
      },
    );
  }
}
