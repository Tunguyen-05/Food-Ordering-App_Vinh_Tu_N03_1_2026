import 'package:flutter/material.dart';
import '../data/fake_food_data.dart';
import '../models/food_category.dart';
import 'dart:math';

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
    final randomFoods = [...foodsInCategory]..shuffle(Random());
    final topImages = randomFoods.take(2).toList();

    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: Text(category.name),
        backgroundColor: Colors.white,
        foregroundColor: Colors.black,
        elevation: 0,
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            // ===== HERO SECTION =====
            Container(
              width: double.infinity,
              height: 320,
              color: const Color(0xffF3F3F3),
              child: Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      'Food Ordering',
                      style: const TextStyle(
                        fontSize: 42,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const SizedBox(height: 12),
                    Text(
                      'Choose your favorite ${category.name}',
                      style: const TextStyle(
                        fontSize: 22,
                        color: Colors.grey,
                      ),
                    ),
                  ],
                ),
              ),
            ),

            const SizedBox(height: 40),

            // ===== TWO IMAGE SECTION =====
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              child: Row(
                children: [
                  Expanded(
                    child: _ImageBox(
                      imageUrl: topImages.isNotEmpty
                          ? topImages[0].imageUrl
                          : 'https://picsum.photos/400/300',
                    ),
                  ),
                  const SizedBox(width: 18),
                  Expanded(
                    child: _ImageBox(
                      imageUrl: topImages.length > 1
                          ? topImages[1].imageUrl
                          : 'https://picsum.photos/400/300',
                    ),
                  ),
                ],
              ),
            ),

            const SizedBox(height: 80),

            // ===== HEADING =====
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              child: Align(
                alignment: Alignment.centerLeft,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      '${category.name} Menu',
                      style: const TextStyle(
                        fontSize: 28,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const SizedBox(height: 8),
                    const Text(
                      'Fresh food, fast service, simple ordering.',
                      style: TextStyle(
                        fontSize: 18,
                        color: Colors.grey,
                      ),
                    ),
                  ],
                ),
              ),
            ),

            const SizedBox(height: 32),

            // ===== HORIZONTAL CONTENT CARDS =====
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              child: Column(
                children: foodsInCategory.map((food) {
                  return _HorizontalFoodCard(
                    title: food.name,
                    description: food.description,
                    price: '${food.price} VND',
                    imageUrl: food.imageUrl,
                  );
                }).toList(),
              ),
            ),

            const SizedBox(height: 60),

            // ===== GRID SECTION =====
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              child: Align(
                alignment: Alignment.centerLeft,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: const [
                    Text(
                      'Popular Choices',
                      style: TextStyle(
                        fontSize: 28,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    SizedBox(height: 8),
                    Text(
                      'Recommended food items for you.',
                      style: TextStyle(
                        fontSize: 18,
                        color: Colors.grey,
                      ),
                    ),
                  ],
                ),
              ),
            ),

            const SizedBox(height: 32),

            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              child: GridView.builder(
                shrinkWrap: true,
                physics: const NeverScrollableScrollPhysics(),
                itemCount: foodsInCategory.length,
                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 2,
                  mainAxisSpacing: 20,
                  crossAxisSpacing: 20,
                  childAspectRatio: 1.25,
                ),
                itemBuilder: (context, index) {
                  final food = foodsInCategory[index];

                  return _GridFoodCard(
                    title: food.name,
                    description: food.description,
                    price: '${food.price} VND',
                    imageUrl: food.imageUrl,
                  );
                },
              ),
            ),

            const SizedBox(height: 50),

            // ===== FOOTER =====
            Container(
              width: double.infinity,
              padding: const EdgeInsets.all(24),
              color: const Color(0xffF5F5F5),
              child: const Text(
                'Phenikaa University\nFood Ordering App',
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.w600,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

// ================= IMAGE BOX =================

class _ImageBox extends StatelessWidget {
  final String imageUrl;

  const _ImageBox({
    required this.imageUrl,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 170,
      color: const Color(0xffEAEAEA),
      child: Image.network(
        imageUrl,
        fit: BoxFit.cover,
        errorBuilder: (context, error, stackTrace) {
          return const Center(
            child: Icon(
              Icons.image,
              size: 60,
              color: Colors.grey,
            ),
          );
        },
      ),
    );
  }
}

// ================= HORIZONTAL CARD =================

class _HorizontalFoodCard extends StatelessWidget {
  final String title;
  final String description;
  final String price;
  final String imageUrl;

  const _HorizontalFoodCard({
    required this.title,
    required this.description,
    required this.price,
    required this.imageUrl,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(bottom: 22),
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        border: Border.all(color: Colors.black12),
        borderRadius: BorderRadius.circular(8),
      ),
      child: Row(
        children: [
          ClipRRect(
            borderRadius: BorderRadius.circular(8),
            child: Image.network(
              imageUrl,
              width: 120,
              height: 120,
              fit: BoxFit.cover,
              errorBuilder: (context, error, stackTrace) {
                return Container(
                  width: 120,
                  height: 120,
                  color: const Color(0xffEAEAEA),
                  child: const Icon(
                    Icons.fastfood,
                    size: 50,
                    color: Colors.grey,
                  ),
                );
              },
            ),
          ),

          const SizedBox(width: 22),

          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  title,
                  style: const TextStyle(
                    fontSize: 24,
                    fontWeight: FontWeight.bold,
                  ),
                ),

                const SizedBox(height: 8),

                Text(
                  description,
                  style: const TextStyle(
                    fontSize: 16,
                    color: Colors.grey,
                  ),
                ),

                const SizedBox(height: 12),

                Text(
                  price,
                  style: const TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                  ),
                ),

                const SizedBox(height: 12),

                OutlinedButton(
                  onPressed: () {},
                  child: const Text('Order'),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

// ================= GRID CARD =================

class _GridFoodCard extends StatelessWidget {
  final String title;
  final String description;
  final String price;
  final String imageUrl;

  const _GridFoodCard({
    required this.title,
    required this.description,
    required this.price,
    required this.imageUrl,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(14),
      decoration: BoxDecoration(
        border: Border.all(color: Colors.black12),
        borderRadius: BorderRadius.circular(8),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          ClipRRect(
            borderRadius: BorderRadius.circular(6),
            child: Image.network(
              imageUrl,
              height: 250,
              width: double.infinity,
              fit: BoxFit.cover,
              errorBuilder: (context, error, stackTrace) {
                return Container(
                  height: 110,
                  width: double.infinity,
                  color: const Color(0xffEAEAEA),
                  child: const Icon(
                    Icons.fastfood,
                    size: 50,
                    color: Colors.grey,
                  ),
                );
              },
            ),
          ),

          const SizedBox(height: 16),

          Text(
            title,
            style: const TextStyle(
              fontSize: 21,
              fontWeight: FontWeight.bold,
            ),
          ),

          const SizedBox(height: 8),

          Text(
            description,
            style: const TextStyle(
              fontSize: 15,
              color: Colors.grey,
            ),
          ),

          const SizedBox(height: 8),

          Text(
            price,
            style: const TextStyle(
              fontWeight: FontWeight.bold,
            ),
          ),
        ],
      ),
    );
  }
}