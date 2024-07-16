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
  final List<Map<String, dynamic>> _groceryList = [];

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
                itemCount: 0, // Placeholder for now
                itemBuilder: (context, index) {
                  return ListTile(
                    title: const Text('Placeholder Item'),
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
                          onPressed: () {
                            // Placeholder for delete functionality
                          },
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
