import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class CardItem {
  final String title;
  final String description;
  final IconData icon;
  final String routeName;

  CardItem({
    required this.title,
    required this.description,
    required this.icon,
    required this.routeName,
  });
}

class CardsScreen extends StatefulWidget {
  const CardsScreen({super.key});

  @override
  State<CardsScreen> createState() => _CardsScreenState();
}

class _CardsScreenState extends State<CardsScreen> {
  final List<CardItem> cards = [
    CardItem(
        title: "Ganhar",
        description: "Gerencie seus membros",
        icon: Icons.group_add_outlined,
        routeName: '/novaVida'),
    CardItem(
        title: "Membros",
        description: "Gerencie seus membros",
        icon: Icons.person,
        routeName: '/membros'),
    CardItem(
        title: "Minha Descendencia",
        description: "Sua árvore",
        icon: Icons.family_restroom,
        routeName: '/minhaDescendencia'),
    CardItem(
        title: "Minhas Células",
        description: "Veja suas células",
        icon: Icons.group,
        routeName: '/celulas'),
    CardItem(
        title: "Eventos",
        description: "Próximos eventos",
        icon: Icons.event,
        routeName: '/eventos'),
    CardItem(
        title: "Calendário",
        description: "Agenda de atividades",
        icon: Icons.calendar_month,
        routeName: '/calendario'),
  ];

  @override
  Widget build(BuildContext context) {
    return GridView.builder(
      padding: const EdgeInsets.all(12),
      itemCount: cards.length,
      physics: const NeverScrollableScrollPhysics(),
      shrinkWrap: true,
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
        childAspectRatio: 1,
        crossAxisCount: 2,
      ),
      itemBuilder: (context, index) {
        final card = cards[index];
        return GestureDetector(
          onTap: () {
            context.push(card.routeName);
          },
          child: Container(
            margin: const EdgeInsets.all(10),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(15),
              color: const Color(0xFFD4ECF7),
              boxShadow: const [
                BoxShadow(
                  color: Colors.black26,
                  blurRadius: 4,
                  spreadRadius: 2,
                ),
              ],
            ),
            child: Padding(
              padding: const EdgeInsets.all(12),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Icon(card.icon, size: 40, color: Colors.blueAccent),
                  const SizedBox(height: 4),
                  Text(
                    card.title,
                    style: const TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(height: 4),
                  Text(
                    card.description,
                    style: const TextStyle(fontSize: 12, color: Colors.black87),
                  ),
                ],
              ),
            ),
          ),
        );
      },
    );
  }
}
