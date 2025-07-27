import 'package:flutter/material.dart';
import 'package:fluttericon/elusive_icons.dart';
import 'package:go_router/go_router.dart';
import '../../domain/models/ganha_vidas_models.dart';
import '../../domain/core/themes/global_colors.dart';

class CadastrosDrawer extends StatefulWidget {
  const CadastrosDrawer({super.key});

  @override
  State<CadastrosDrawer> createState() => _CadastrosDrawerState();
}

class _CadastrosDrawerState extends State<CadastrosDrawer> {
  final List<GanharVidasModels> _vidas = GanharVidasModels.generateItems(1);

  @override
  Widget build(BuildContext context) {
    return ExpansionPanelList(
      expandIconColor: Colors.white,
      expansionCallback: (int index, bool isExpanded) {
        setState(() {
          _vidas[index].isExpanded = isExpanded;
        });
      },
      children: _vidas.map<ExpansionPanel>((GanharVidasModels item) {
        return ExpansionPanel(
          backgroundColor: GlobalColor.AzulEscuroColor,
          headerBuilder: (BuildContext context, bool isExpanded) {
            return const ListTile(
              leading: Icon(
                Elusive.group_circled,
                color: Colors.white,
                size: 30,
              ),
              title: Text(
                'Geral',
                style:
                    TextStyle(fontWeight: FontWeight.bold, color: Colors.white),
              ),
            );
          },
          body: Column(
            children: [
              ListTile(
                subtitle: Row(
                  children: [
                    const Icon(
                      Icons.circle,
                      size: 8,
                      color: Colors.white,
                    ),
                    const SizedBox(
                      width: 15,
                    ),
                    InkWell(
                      child: const Text('Pessoas',
                          style: TextStyle(
                              fontWeight: FontWeight.bold,
                              color: Colors.white)),
                      onTap: () {
                        context.push('/lifes');
                      },
                    ),
                  ],
                ),
              ),
              ListTile(
                subtitle: Row(
                  children: [
                    const Icon(
                      Icons.circle,
                      size: 8,
                      color: Colors.white,
                    ),
                    const SizedBox(
                      width: 15,
                    ),
                    InkWell(
                      child: const Text('Descendêcias',
                          style: TextStyle(
                              fontWeight: FontWeight.bold,
                              color: Colors.white)),
                      onTap: () {
                        context.push('/descendencia');
                      },
                    ),
                  ],
                ),
              ),
            ],
          ),
          isExpanded: item.isExpanded,
        );
      }).toList(),
    );
  }
}
