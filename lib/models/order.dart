class Order {
  final int? id;
  final int userId;
  final String customerName;
  final String customerPhone;
  final String customerAddress;
  final String shippingType;
  final int shippingFee;
  final int totalAmount;
  final String paymentMethod;
  final String status;
  final String? cancelReason;
  final DateTime createdAt;

  Order({
    this.id,
    required this.userId,
    required this.customerName,
    required this.customerPhone,
    required this.customerAddress,
    required this.shippingType,
    required this.shippingFee,
    required this.totalAmount,
    required this.paymentMethod,
    required this.status,
    this.cancelReason,
    required this.createdAt,
  });

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'user_id': userId,
      'customer_name': customerName,
      'customer_phone': customerPhone,
      'customer_address': customerAddress,
      'shipping_type': shippingType,
      'shipping_fee': shippingFee,
      'total_amount': totalAmount,
      'payment_method': paymentMethod,
      'status': status,
      'cancel_reason': cancelReason,
      'created_at': createdAt.toIso8601String(),
    };
  }

  factory Order.fromMap(Map<String, dynamic> map) {
    return Order(
      id: map['id'] as int?,
      userId: map['user_id'] as int,
      customerName: map['customer_name'] as String,
      customerPhone: map['customer_phone'] as String,
      customerAddress: map['customer_address'] as String,
      shippingType: map['shipping_type'] as String,
      shippingFee: map['shipping_fee'] as int,
      totalAmount: map['total_amount'] as int,
      paymentMethod: map['payment_method'] as String,
      status: map['status'] as String,
      cancelReason: map['cancel_reason'] as String?,
      createdAt: DateTime.parse(map['created_at'] as String),
    );
  }

  Order copyWith({
    int? id,
    int? userId,
    String? customerName,
    String? customerPhone,
    String? customerAddress,
    String? shippingType,
    int? shippingFee,
    int? totalAmount,
    String? paymentMethod,
    String? status,
    String? cancelReason,
    DateTime? createdAt,
  }) {
    return Order(
      id: id ?? this.id,
      userId: userId ?? this.userId,
      customerName: customerName ?? this.customerName,
      customerPhone: customerPhone ?? this.customerPhone,
      customerAddress: customerAddress ?? this.customerAddress,
      shippingType: shippingType ?? this.shippingType,
      shippingFee: shippingFee ?? this.shippingFee,
      totalAmount: totalAmount ?? this.totalAmount,
      paymentMethod: paymentMethod ?? this.paymentMethod,
      status: status ?? this.status,
      cancelReason: cancelReason ?? this.cancelReason,
      createdAt: createdAt ?? this.createdAt,
    );
  }
}
