import 'package:flutter/material.dart';
import 'package:fluttericon/elusive_icons.dart';
import 'package:go_router/go_router.dart';
import '../../domain/core/themes/global_colors.dart';

class EscadaDoSucessoDrawer extends StatefulWidget {
  const EscadaDoSucessoDrawer({super.key});

  @override
  State<EscadaDoSucessoDrawer> createState() => _EscadaDoSucessoDrawerState();
}

class _EscadaDoSucessoDrawerState extends State<EscadaDoSucessoDrawer> {
  // Estados de expansão para cada painel
  bool _isGanharExpanded = false;
  bool _isConsolidarExpanded = false;
  bool _isDiscipularExpanded = false;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        ExpansionPanelList(
          expandIconColor: Colors.white,
          expansionCallback: (int index, bool isExpanded) {
            setState(() {
              _isGanharExpanded = !_isGanharExpanded;
            });
          },
          children: [
            ExpansionPanel(
              backgroundColor: GlobalColor.AzulEscuroColor,
              headerBuilder: (BuildContext context, bool isExpanded) {
                return const ListTile(
                  leading: Icon(
                    Elusive.group_circled,
                    color: Colors.white,
                    size: 30,
                  ),
                  title: Text(
                    'Ganhar',
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      color: Colors.white,
                    ),
                  ),
                );
              },
              body: Column(
                children: [
                  ListTile(
                    subtitle: Row(
                      children: [
                        const Icon(Icons.circle, size: 8, color: Colors.white),
                        const SizedBox(width: 15),
                        InkWell(
                          onTap: () {
                            context.push('/visitante');
                          },
                          child: const Text(
                            'Nova Vida',
                            style: TextStyle(
                              fontWeight: FontWeight.bold,
                              color: Colors.white,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                  ListTile(
                    subtitle: Row(
                      children: [
                        const Icon(Icons.circle, size: 8, color: Colors.white),
                        const SizedBox(width: 15),
                        InkWell(
                          onTap: () {
                            context.push('/rota');
                          },
                          child: const Text(
                            'Rota da Vida',
                            style: TextStyle(
                              fontWeight: FontWeight.bold,
                              color: Colors.white,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
              isExpanded: _isGanharExpanded,
            ),
          ],
        ),
        const SizedBox(height: 10),
        ExpansionPanelList(
          expandIconColor: Colors.white,
          expansionCallback: (int index, bool isExpanded) {
            setState(() {
              _isConsolidarExpanded = !_isConsolidarExpanded;
            });
          },
          children: [
            ExpansionPanel(
              backgroundColor: GlobalColor.AzulEscuroColor,
              headerBuilder: (BuildContext context, bool isExpanded) {
                return const ListTile(
                  leading: Icon(
                    Elusive.group_circled,
                    color: Colors.white,
                    size: 30,
                  ),
                  title: Text(
                    'Consolidar',
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      color: Colors.white,
                    ),
                  ),
                );
              },
              body: ListTile(
                subtitle: Row(
                  children: [
                    Icon(Icons.circle, size: 8, color: Colors.white),
                    SizedBox(width: 15),
                    InkWell(
                      onTap: () {
                        context.push('/uniVida');
                      },
                      child: Text(
                        'Universidade da Vida',
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          color: Colors.white,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              isExpanded: _isConsolidarExpanded,
            ),
          ],
        ),
        const SizedBox(height: 10),
        ExpansionPanelList(
          expandIconColor: Colors.white,
          expansionCallback: (int index, bool isExpanded) {
            setState(() {
              _isDiscipularExpanded = !_isDiscipularExpanded;
            });
          },
          children: [
            ExpansionPanel(
              backgroundColor: GlobalColor.AzulEscuroColor,
              headerBuilder: (BuildContext context, bool isExpanded) {
                return const ListTile(
                  leading: Icon(
                    Elusive.group_circled,
                    color: Colors.white,
                    size: 30,
                  ),
                  title: Text(
                    'Discipular',
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      color: Colors.white,
                    ),
                  ),
                );
              },
              body: ListTile(
                subtitle: Row(
                  children: [
                    Icon(Icons.circle, size: 8, color: Colors.white),
                    SizedBox(width: 15),
                    InkWell(
                      onTap: () {
                        context.push('/ecd');
                      },
                      child: Text(
                        'Capacitação do Destino',
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          color: Colors.white,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              isExpanded: _isDiscipularExpanded,
            ),
          ],
        ),
      ],
    );
  }
}
