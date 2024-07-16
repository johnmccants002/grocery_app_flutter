import 'package:flutter/material.dart';

class GroceryListScreen extends StatefulWidget {
  const GroceryListScreen({super.key});

  @override
  State<GroceryListScreen> createState() {
    return _GroceryListScreenState();
  }
}

class _GroceryListScreenState extends State<GroceryListScreen> {
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _quantityController = TextEditingController();
  List<Map<String, dynamic>> _groceryList = [];

  void _addGroceryItem() {
    final String name = _nameController.text;
    final String quantity = _quantityController.text;

    if (name.isNotEmpty && quantity.isNotEmpty) {
      setState(() {
        _groceryList.insert(0, {'name': name, 'quantity': quantity});
      });

      _nameController.clear();
      _quantityController.clear();
    }
  }

  void _deleteGroceryItem(int index) {
    var _updated_list = _groceryList.removeAt(index);
    setState(() {
      _groceryList = _updated_list;
    });
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
              child: ListView.builder(
                itemCount: _groceryList.length,
                itemBuilder: (context, index) {
                  final item = _groceryList[index];
                  return ListTile(
                    title: Text('${item['name']}'),
                    subtitle: Text('Quantity: ${item['quantity']}'),
                    trailing: Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        IconButton(
                          icon: const Icon(Icons.edit),
                          onPressed: () {
                            // Placeholder for edit functionality
                          },
                        ),
                        IconButton(
                          icon: const Icon(Icons.delete),
                          onPressed: () => _deleteGroceryItem(index),
                        ),
                      ],
                    ),
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
                    onPressed: _addGroceryItem,
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
