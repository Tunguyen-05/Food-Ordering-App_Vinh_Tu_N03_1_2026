import 'package:flutter/material.dart';
import '../models/food_category.dart';
import '../models/food_item.dart';

const List<FoodCategory> foodCategories = [
  FoodCategory(
    id: 1,
    name: 'Phở',
    icon: Icons.ramen_dining,
  ),
  FoodCategory(
    id: 2,
    name: 'Bún',
    icon: Icons.restaurant,
  ),
  FoodCategory(
    id: 3,
    name: 'Cơm',
    icon: Icons.rice_bowl,
  ),
  FoodCategory(
    id: 4,
    name: 'Đồ uống',
    icon: Icons.local_drink,
  ),
];

const List<FoodItem> foodItems = [
  FoodItem(
    id: 1,
    categoryId: 1,
    name: 'Phở bò',
    price: 45000,
  ),
  FoodItem(
    id: 2,
    categoryId: 1,
    name: 'Phở trâu',
    price: 55000,
  ),
  FoodItem(
    id: 3,
    categoryId: 1,
    name: 'Phở tim cật',
    price: 60000,
  ),
  FoodItem(
    id: 4,
    categoryId: 2,
    name: 'Bún bò Huế',
    price: 50000,
  ),
  FoodItem(
    id: 5,
    categoryId: 2,
    name: 'Bún chả',
    price: 45000,
  ),
  FoodItem(
    id: 6,
    categoryId: 3,
    name: 'Cơm gà',
    price: 40000,
  ),
  FoodItem(
    id: 7,
    categoryId: 3,
    name: 'Cơm rang dưa bò',
    price: 50000,
  ),
  FoodItem(
    id: 8,
    categoryId: 4,
    name: 'Trà đá',
    price: 5000,
  ),
  FoodItem(
    id: 9,
    categoryId: 4,
    name: 'Nước cam',
    price: 25000,
  ),
];