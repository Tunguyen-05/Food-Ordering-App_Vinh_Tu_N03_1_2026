class FoodItem {
  final int id;
  final int categoryId;
  final String name;
  final int price;
  final String description;
  final String imageUrl;

  const FoodItem({
    required this.id,
    required this.categoryId,
    required this.name,
    required this.price,
    required this.description,
    required this.imageUrl,
  });
}