import 'package:flutter_bloc/flutter_bloc.dart';
import 'grocery_item.dart';

class GroceryCubit extends Cubit<List<GroceryItem>> {
  GroceryCubit() : super([]);

  void addGroceryItem(GroceryItem item) {
    final currentList = List<GroceryItem>.from(state);
    currentList.insert(0, item);
    emit(currentList);
  }

  void removeGroceryItem(int index) {
    final currentList = List<GroceryItem>.from(state);
    currentList.removeAt(index);
    emit(currentList);
  }

  void updateGroceryItem(int index, GroceryItem updatedItem) {
    final currentList = List<GroceryItem>.from(state);
    currentList[index] = updatedItem;
    emit(currentList);
  }
}
