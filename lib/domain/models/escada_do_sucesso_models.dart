class EscadaDoSucessoModels {
  String title;
  bool isExpanded;

  EscadaDoSucessoModels(
    {
      required this.title,
      this.isExpanded = false,
    }
  );

  static List<EscadaDoSucessoModels> generateItems(int numberOfItems) {
    return List<EscadaDoSucessoModels>.generate(numberOfItems, (int index) {
      return EscadaDoSucessoModels(
        title: 'Sucesso $index', 
      );
    });
  }
}