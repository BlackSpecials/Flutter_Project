class Article {
  final String name;
  final String category;
  final int quantity;
  final double price;
  bool isChecked;

  Article({
    required this.name,
    required this.category,
    required this.quantity,
    required this.price,
    this.isChecked = false,
  });
}
