// ignore_for_file: deprecated_member_use

import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

class WhatsAppButton extends StatelessWidget {
  final String phoneNumber;
  final String message;

  // Construtor para passar o número do WhatsApp e a mensagem
  WhatsAppButton({required this.phoneNumber, required this.message});

  // Função que abre o WhatsApp com a mensagem pronta
  void _openWhatsApp() async {
    // Codifica a mensagem para a URL
    final encodedMessage = Uri.encodeComponent(message);
    final whatsappUrl = "https://wa.me/$phoneNumber?text=$encodedMessage";
    await launch(whatsappUrl);
    /*if (await canLaunch(whatsappUrl)) {
      //await launch(whatsappUrl);
    } else {
      throw 'Não foi possível abrir o WhatsApp';
    }*/
  }

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: _openWhatsApp,
      child: Text('Enviar Mensagem no WhatsApp'),
    );
  }
}
