class GanharVidasModels {
  String title;
  bool isExpanded;

  GanharVidasModels(
    {
      required this.title,
      this.isExpanded = false,
    }
  );

  static List<GanharVidasModels> generateItems(int numberOfItems) {
    return List<GanharVidasModels>.generate(numberOfItems, (int index) {
      return GanharVidasModels(
        title: 'Vidas$index', 
      );
    });
  }
}