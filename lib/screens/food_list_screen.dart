import 'package:flutter/material.dart';
import '../data/fake_food_data.dart';
import '../models/food_category.dart';
import '../widgets/food_card.dart';
import '../widgets/app_layout.dart';

class FoodListScreen extends StatelessWidget {
  final FoodCategory category;

  const FoodListScreen({
    super.key,
    required this.category,
  });

  @override
  Widget build(BuildContext context) {
    final foodsInCategory = foodItems.where((food) {
      return food.categoryId == category.id;
    }).toList();

    return AppLayout(
      title: category.name,
      body: ListView.builder(
        shrinkWrap: true,
        physics: const NeverScrollableScrollPhysics(),
        itemCount: foodsInCategory.length,
        itemBuilder: (context, index) {
          final food = foodsInCategory[index];
          return FoodCard(food: food);
        },
      ),
    );
  }
}