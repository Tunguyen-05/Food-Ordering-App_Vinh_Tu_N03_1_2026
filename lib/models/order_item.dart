class OrderItem {
  final int? id;
  final int orderId;
  final int productId;
  final String productName;
  final int price;
  final int quantity;

  OrderItem({
    this.id,
    required this.orderId,
    required this.productId,
    required this.productName,
    required this.price,
    required this.quantity,
  });

  int get totalPrice => price * quantity;

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'order_id': orderId,
      'product_id': productId,
      'product_name': productName,
      'price': price,
      'quantity': quantity,
    };
  }

  factory OrderItem.fromMap(Map<String, dynamic> map) {
    return OrderItem(
      id: map['id'] as int?,
      orderId: map['order_id'] as int,
      productId: map['product_id'] as int,
      productName: map['product_name'] as String,
      price: map['price'] as int,
      quantity: map['quantity'] as int,
    );
  }
}
