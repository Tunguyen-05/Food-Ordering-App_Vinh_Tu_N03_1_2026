import 'package:flutter/material.dart';
import 'food_item.dart';
import 'list_food_item.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Food Ordering Demo',
      home: const FoodScreen(),
    );
  }
}

class FoodScreen extends StatefulWidget {
  const FoodScreen({super.key});

  @override
  State<FoodScreen> createState() => _FoodScreenState();
}

class _FoodScreenState extends State<FoodScreen> {
  ListFoodItem manager = ListFoodItem();

  void addSampleData() {
    setState(() {
      manager.foodList.clear();

      manager.create(
        FoodItem(
          id: 'F01',
          name: 'Burger',
          price: 50000,
          category: 'Fast Food',
          isAvailable: true,
        ),
      );

      manager.create(
        FoodItem(
          id: 'F02',
          name: 'Pizza',
          price: 120000,
          category: 'Italian',
          isAvailable: true,
        ),
      );

      manager.create(
        FoodItem(
          id: 'F03',
          name: 'Fried Chicken',
          price: 80000,
          category: 'Chicken',
          isAvailable: false,
        ),
      );
    });
  }

  void editFood() {
    setState(() {
      manager.edit(
        'F02',
        FoodItem(
          id: 'F02',
          name: 'Cheese Pizza',
          price: 130000,
          category: 'Italian',
          isAvailable: true,
        ),
      );
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Food Ordering App'),
        centerTitle: true,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          children: [
            Row(
              children: [
                Expanded(
                  child: ElevatedButton(
                    onPressed: addSampleData,
                    child: const Text('Create Sample Data'),
                  ),
                ),
                const SizedBox(width: 10),
                Expanded(
                  child: ElevatedButton(
                    onPressed: editFood,
                    child: const Text('Edit F02'),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 20),
            Expanded(
              child: manager.foodList.isEmpty
                  ? const Center(
                child: Text(
                  'Chưa có món ăn nào',
                  style: TextStyle(fontSize: 18),
                ),
              )
                  : ListView.builder(
                itemCount: manager.foodList.length,
                itemBuilder: (context, index) {
                  final food = manager.foodList[index];

                  return Card(
                    margin: const EdgeInsets.only(bottom: 12),
                    child: ListTile(
                      leading: CircleAvatar(
                        child: Text(food.id),
                      ),
                      title: Text(food.name),
                      subtitle: Text(
                        'Price: ${food.price} VND\n'
                            'Category: ${food.category}\n'
                            'Available: ${food.isAvailable ? "Yes" : "No"}',
                      ),
                      isThreeLine: true,
                    ),
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}