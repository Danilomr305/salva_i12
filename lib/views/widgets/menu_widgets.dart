import 'package:flutter/material.dart';
import 'package:i12mobile/domain/core/themes/global_colors.dart';

class PerfilMenuWidget extends StatelessWidget {
  const PerfilMenuWidget(
      {super.key,
      required this.title,
      required this.icon,
      required this.onPress,
      this.textColor,
      required this.buttonIcon});

  final String title;
  final IconData icon;
  final VoidCallback onPress;
  final IconData buttonIcon;
  final Color? textColor;

  @override
  Widget build(BuildContext context) {
    return ListTile(
      onTap: onPress,
      leading: Container(
        width: 40,
        height: 40,
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(100),
            // ignore: deprecated_member_use
            color: Colors.grey.withOpacity(0.1)),
        child: Icon(
          icon,
          color: GlobalColor.AzulEscuroColor,
        ),
      ),
      title: Text(
        title,
        style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 15),
      ),
      trailing: Container(
        width: 30,
        height: 30,
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(100),
            // ignore: deprecated_member_use
            color: Colors.grey.withOpacity(0.4)),
        child: Icon(
          buttonIcon,
          size: 30,
        ),
      ),
    );
  }
}
