import 'package:flutter/material.dart';
import 'grocery_cubit.dart';
import 'grocery_item.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class GroceryListScreen extends StatelessWidget {
  GroceryListScreen({super.key});
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _quantityController = TextEditingController();

  void _addGroceryItem(BuildContext context) {
    final String name = _nameController.text;
    final String quantityStr = _quantityController.text;

    if (name.isNotEmpty && quantityStr.isNotEmpty) {
      final int quantity = int.tryParse(quantityStr) ?? 1;
      final item = GroceryItem(name: name, quantity: quantity);
      context.read<GroceryCubit>().addGroceryItem(item);

      _nameController.clear();
      _quantityController.clear();
    }
  }

  void _editGroceryItem(
      BuildContext parentContext, int index, GroceryItem item) {
    _nameController.text = item.name;
    _quantityController.text = item.quantity.toString();

    showDialog(
      context: parentContext,
      builder: (context) {
        return AlertDialog(
          title: const Text('Edit Grocery Item'),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              TextField(
                controller: _nameController,
                decoration: const InputDecoration(labelText: 'Name'),
              ),
              TextField(
                controller: _quantityController,
                decoration: const InputDecoration(labelText: 'Quantity'),
                keyboardType: TextInputType.number,
              )
            ],
          ),
          actions: [
            TextButton(
              onPressed: () {
                final String name = _nameController.text;
                final String quantityStr = _quantityController.text;

                if (name.isNotEmpty && quantityStr.isNotEmpty) {
                  final int quantity = int.tryParse(quantityStr) ?? 0;
                  final updatedItem =
                      GroceryItem(name: name, quantity: quantity);
                  parentContext
                      .read<GroceryCubit>()
                      .updateGroceryItem(index, updatedItem);
                }
                _nameController.clear();
                _quantityController.clear();
                Navigator.of(context).pop();
              },
              child: const Text('Save'),
            ),
            TextButton(
              onPressed: () {
                _nameController.clear();
                _quantityController.clear();
                Navigator.of(context).pop();
              },
              child: const Text('Cancel'),
            ),
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Grocery List'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            Expanded(
              child: BlocBuilder<GroceryCubit, List<GroceryItem>>(
                builder: (context, groceryList) {
                  return ListView.builder(
                    itemCount: groceryList.length,
                    itemBuilder: (context, index) {
                      final item = groceryList[index];
                      return ListTile(
                        title: Text(item.name),
                        subtitle: Text('Quantity: ${item.quantity}'),
                        trailing: Row(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            IconButton(
                              icon: const Icon(Icons.edit),
                              onPressed: () {
                                _editGroceryItem(context, index, item);
                              },
                            ),
                            IconButton(
                              icon: const Icon(Icons.delete),
                              onPressed: () => {
                                context
                                    .read<GroceryCubit>()
                                    .removeGroceryItem(index)
                              },
                            ),
                          ],
                        ),
                      );
                    },
                  );
                },
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 8.0),
              child: Row(
                children: [
                  Expanded(
                    child: TextField(
                      controller: _nameController,
                      decoration: const InputDecoration(labelText: 'Name'),
                    ),
                  ),
                  const SizedBox(width: 8),
                  Expanded(
                    child: TextField(
                      controller: _quantityController,
                      decoration: const InputDecoration(labelText: 'Quantity'),
                    ),
                  ),
                  IconButton(
                    icon: const Icon(Icons.add),
                    onPressed: () => _addGroceryItem(context),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
