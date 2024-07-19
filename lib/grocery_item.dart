class GroceryItem {
  String name;
  int quantity;

  GroceryItem({required this.name, required this.quantity});

  Map<String, dynamic> toMap() {
    return {
      'name': name,
      'quantity': quantity,
    };
  }

  factory GroceryItem.fromMap(Map<String, dynamic> map) {
    return GroceryItem(
      name: map['name'],
      quantity: map['quantity'],
    );
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is GroceryItem &&
        other.name == name &&
        other.quantity == quantity;
  }

  @override
  int get hashCode => name.hashCode ^ quantity.hashCode;
}
