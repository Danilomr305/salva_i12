// ignore_for_file: must_be_immutable

import 'package:community_material_icon/community_material_icon.dart';
import 'package:flutter/material.dart';
import 'package:google_nav_bar/google_nav_bar.dart';
import 'package:fluttericon/elusive_icons.dart';
import 'themes/global_colors.dart';

class MyBottomGnavBar extends StatelessWidget {
  MyBottomGnavBar({super.key, required this.onTabChange});

  void Function(int)? onTabChange;

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.all(1),
      child: GNav(
          padding: const EdgeInsets.all(18),
          backgroundColor: GlobalColor.buttonsColors,
          tabBorderRadius: 50,
          mainAxisAlignment: MainAxisAlignment.center,
          activeColor: Colors.white,
          tabBackgroundColor: GlobalColor.buttonsColors,
          tabMargin: const EdgeInsets.only(bottom: 5),
          duration: const Duration(seconds: 2),
          onTabChange: (value) => onTabChange!(value),
          gap: 8,
          tabs: const [
            GButton(
              icon: Elusive.home_circled,
              text: 'Home',
            ),
            GButton(
              icon: Icons.event,
              text: 'Eventos',
            ),
            GButton(
              icon: CommunityMaterialIcons.account_cog,
              text: 'Perfil',
            )
          ]),
    );
  }
}
