class FoodItem {
  String id;
  String name;
  double price;
  String category;
  bool isAvailable;

  FoodItem({
    required this.id,
    required this.name,
    required this.price,
    required this.category,
    required this.isAvailable,
  });

  void displayInfo() {
    print('ID: $id');
    print('Name: $name');
    print('Price: $price');
    print('Category: $category');
    print('Available: $isAvailable');
    print('----------------------');
  }
}