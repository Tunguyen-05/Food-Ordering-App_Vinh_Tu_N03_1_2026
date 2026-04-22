import 'food_item.dart';

class ListFoodItem {
  List<FoodItem> foodList = [];

  void create(FoodItem food) {
    foodList.add(food);
  }

  void edit(String id, FoodItem newFood) {
    for (int i = 0; i < foodList.length; i++) {
      if (foodList[i].id == id) {
        foodList[i] = newFood;
        return;
      }
    }
  }

  void read() {
    for (var food in foodList) {
      print('${food.id} - ${food.name} - ${food.price}');
    }
  }
}