import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Food Ordering App',
      home: const MyHomePage(),
    );
  }
}

class MyHomePage extends StatelessWidget {
  const MyHomePage({super.key});

  @override
  Widget build(BuildContext context) {
    int idFood = 1;
    String tenFood = "Trà sữa";
    int gia = 30000;
    String loai = "Đồ uống";

    // Đối tượng món ăn
    var food = {
      'idFood': idFood,
      'tenFood': tenFood,
      'gia': gia,
      'loai': loai,
    };

    // Danh sách người dùng
    var Listuser = [
      {
      'idUser': 1,
      'tenUser': 'Nguyễn Tú',
      },
      {
        'idUser': 2,
        'tenUser': 'Lê Vinh',
      }
    ];

    // Danh sách món ăn
    var listFood = [
      {
        'idFood': 1,
        'tenFood': 'Trà sữa',
        'gia': 30000,
        'loai': 'Đồ uống',
      },
      {
        'idFood': 2,
        'tenFood': 'Bánh mì',
        'gia': 20000,
        'loai': 'Đồ ăn',
      },
      {
        'idFood': 3,
        'tenFood': 'Cơm gà',
        'gia': 50000,
        'loai': 'Đồ ăn',
      },
    ];

    return Scaffold(
      appBar: AppBar(
        title: const Text("Food Ordering App"),
        backgroundColor: Colors.lightBlueAccent,
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              "1. Đối tượng món ăn",
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 10),
            Text("idFood: ${food['idFood']}"),
            Text("tenFood: ${food['tenFood']}"),
            Text("gia: ${food['gia']}"),
            Text("loai: ${food['loai']}"),

            const SizedBox(height: 25),

            const Text(
              "2. Danh sách người dùng",
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            ),

            const SizedBox(height: 10),
            Column(
              children: Listuser.map((userItem) {
                return Row(
                  children: [
                    Text("ID: ${userItem['idUser']}"),
                    const SizedBox(width: 20),
                    Text("Tên: ${userItem['tenUser']}"),
                  ],
                );
              }).toList(),
            ),
            const SizedBox(height: 25),

            const Text(
              "3. Danh sách món ăn",
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 10),

            Column(
              children: listFood.map((foodItem) {
                return Card(
                  margin: const EdgeInsets.symmetric(vertical: 8),
                  child: ListTile(
                    leading: const Icon(Icons.fastfood),
                    title: Text("${foodItem['tenFood']}"),
                    subtitle: Text(
                      "ID: ${foodItem['idFood']} - Giá: ${foodItem['gia']} - Loại: ${foodItem['loai']}",
                    ),
                  ),
                );
              }).toList(),
            ),
          ],
        ),
      ),
    );
  }
}