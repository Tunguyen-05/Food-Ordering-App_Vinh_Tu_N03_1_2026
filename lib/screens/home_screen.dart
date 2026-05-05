import 'package:flutter/material.dart';
import '../data/fake_food_data.dart';
import '../models/food_category.dart';
import '../widgets/category_card.dart';
import 'food_list_screen.dart';
import '../widgets/app_layout.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  void openFoodList(BuildContext context, FoodCategory category) {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) {
          return FoodListScreen(category: category);
        },
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return AppLayout(
      title: 'Food Categories',
      body: ListView.builder(
        shrinkWrap: true,
        physics: const NeverScrollableScrollPhysics(),
        itemCount: foodCategories.length,
        itemBuilder: (context, index) {
          final category = foodCategories[index];

          return CategoryCard(
            category: category,
            onTap: () {
              openFoodList(context, category);
            },
          );
        },
      ),
    );
  }
}