import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'dart:convert';
import 'grocery_item.dart';

class GroceryCubit extends Cubit<List<GroceryItem>> {
  GroceryCubit() : super([]) {
    _loadGroceryList();
  }

  void addGroceryItem(GroceryItem item) {
    final currentList = List<GroceryItem>.from(state);
    currentList.insert(0, item);
    emit(currentList);
    _saveGroceryList();
  }

  void removeGroceryItem(int index) {
    final currentList = List<GroceryItem>.from(state);
    currentList.removeAt(index);
    emit(currentList);
    _saveGroceryList();
  }

  void updateGroceryItem(int index, GroceryItem updatedItem) {
    final currentList = List<GroceryItem>.from(state);
    currentList[index] = updatedItem;
    emit(currentList);
    _saveGroceryList();
  }

  Future<void> _loadGroceryList() async {
    final prefs = await SharedPreferences.getInstance();
    final String? groceryListJson = prefs.getString('groceryList');
    if (groceryListJson != null) {
      final List<dynamic> jsonList = jsonDecode(groceryListJson);
      final List<GroceryItem> groceryList =
          jsonList.map((jsonItem) => GroceryItem.fromMap(jsonItem)).toList();
      emit(groceryList);
    }
  }

  Future<void> _saveGroceryList() async {
    final prefs = await SharedPreferences.getInstance();
    final List<Map<String, dynamic>> jsonList =
        state.map((groceryItem) => groceryItem.toMap()).toList();
    final String groceryListJson = jsonEncode(jsonList);
    await prefs.setString('groceryList', groceryListJson);
  }
}
