class Product {
  final int? id;
  final String name;
  final int price;
  final String description;
  final String imageUrl;
  final String category;

  Product({
    this.id,
    required this.name,
    required this.price,
    required this.description,
    required this.imageUrl,
    required this.category,
  });

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'name': name,
      'price': price,
      'description': description,
      'image_url': imageUrl,
      'category': category,
    };
  }

  factory Product.fromMap(Map<String, dynamic> map) {
    return Product(
      id: map['id'] as int?,
      name: map['name'] as String,
      price: map['price'] as int,
      description: map['description'] as String,
      imageUrl: map['image_url'] as String,
      category: map['category'] as String,
    );
  }

  Product copyWith({
    int? id,
    String? name,
    int? price,
    String? description,
    String? imageUrl,
    String? category,
  }) {
    return Product(
      id: id ?? this.id,
      name: name ?? this.name,
      price: price ?? this.price,
      description: description ?? this.description,
      imageUrl: imageUrl ?? this.imageUrl,
      category: category ?? this.category,
    );
  }
}
