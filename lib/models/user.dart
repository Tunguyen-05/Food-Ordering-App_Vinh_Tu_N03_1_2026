class User {
  final int? id;
  final String phone;
  final String password;
  final String name;
  final String address;
  final bool isAdmin;

  User({
    this.id,
    required this.phone,
    required this.password,
    required this.name,
    this.address = '',
    this.isAdmin = false,
  });

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'phone': phone,
      'password': password,
      'name': name,
      'address': address,
      'is_admin': isAdmin ? 1 : 0,
    };
  }

  factory User.fromMap(Map<String, dynamic> map) {
    return User(
      id: map['id'] as int?,
      phone: map['phone'] as String,
      password: map['password'] as String,
      name: map['name'] as String,
      address: map['address'] as String? ?? '',
      isAdmin: (map['is_admin'] as int) == 1,
    );
  }

  User copyWith({
    int? id,
    String? phone,
    String? password,
    String? name,
    String? address,
    bool? isAdmin,
  }) {
    return User(
      id: id ?? this.id,
      phone: phone ?? this.phone,
      password: password ?? this.password,
      name: name ?? this.name,
      address: address ?? this.address,
      isAdmin: isAdmin ?? this.isAdmin,
    );
  }
}
