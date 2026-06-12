# 🍜 Ứng Dụng Đặt Thức Ăn – Food Ordering App

## Thông tin nhóm

| Họ tên | MSSV | Vai trò |
|---|---|---|
| Lê Quang Vinh | 23010507 | User screens, giao diện người dùng, quản lý đơn hàng |
| Nguyễn Anh Tú | 23010645 | Admin screens |


## Kiến Trúc Ứng Dụng

```
lib/
├── main.dart
├── models/
│   ├── product.dart
│   ├── user.dart
│   ├── order.dart
│   ├── cart_item.dart
│   └── order_item.dart
├── providers/
│   ├── auth_provider.dart
│   └── cart_provider.dart
├── services/
│   ├── storage_service.dart
│   ├── auth_service.dart
│   ├── product_service.dart
│   └── order_service.dart
├── screens/
│   ├── login_screen.dart
│   └── register_screen.dart
├── user/
│   ├── main_user_screen.dart
│   ├── user_home_screen.dart
│   ├── user_cart_screen.dart
│   ├── checkout_screen.dart
│   ├── user_orders_screen.dart
│   └── user_profile_screen.dart
└── admin/
    ├── admin_main_screen.dart
    ├── admin_products_screen.dart
    └── admin_orders_screen.dart
```

