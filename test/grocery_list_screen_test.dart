import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mockito/mockito.dart';
import 'package:mockito/annotations.dart';
import 'package:groceryapp/grocery_list_screen.dart'; // Ensure consistent import
import 'package:groceryapp/grocery_cubit.dart'; // Ensure consistent import
import 'package:groceryapp/grocery_item.dart'; // Ensure consistent import
import 'grocery_list_screen_test.mocks.dart'; // Import the generated mocks

@GenerateMocks([GroceryCubit])
void main() {
  group('GroceryListScreen', () {
    late MockGroceryCubit mockGroceryCubit;

    setUp(() {
      mockGroceryCubit = MockGroceryCubit();

      // Mock the initial state and stream
      when(mockGroceryCubit.state).thenReturn([]);
      when(mockGroceryCubit.stream).thenAnswer((_) => Stream.value([]));
    });

    testWidgets('displays grocery items and allows adding and editing',
        (WidgetTester tester) async {
      // Arrange
      final groceryItems = [
        GroceryItem(name: 'Apples', quantity: 5),
        GroceryItem(name: 'Bananas', quantity: 3),
      ];

      // Mock the state to return groceryItems
      when(mockGroceryCubit.state).thenReturn(groceryItems);
      when(mockGroceryCubit.stream)
          .thenAnswer((_) => Stream.value(groceryItems));

      await tester.pumpWidget(
        BlocProvider<GroceryCubit>(
          create: (_) => mockGroceryCubit,
          child: MaterialApp(
            home: GroceryListScreen(),
          ),
        ),
      );

      // Assert initial state
      expect(find.text('Apples'), findsOneWidget);
      expect(find.text('Bananas'), findsOneWidget);
      expect(find.text('Quantity: 5'), findsOneWidget);
      expect(find.text('Quantity: 3'), findsOneWidget);

      // Act: Add a new grocery item
      await tester.enterText(find.byType(TextField).first, 'Oranges');
      await tester.enterText(find.byType(TextField).last, '7');
      await tester.tap(find.byIcon(Icons.add));
      await tester.pump();

      // Log the state and calls made to the mock cubit
      print(
          'MockGroceryCubit state after adding item: ${mockGroceryCubit.state}');
      final addedItem = GroceryItem(name: 'Oranges', quantity: 7);
      verify(mockGroceryCubit.addGroceryItem(addedItem)).called(1);

      // Mock the state and stream again to include the newly added item
      final updatedGroceryItems = [
        GroceryItem(name: 'Oranges', quantity: 7),
        ...groceryItems,
      ];
      when(mockGroceryCubit.state).thenReturn(updatedGroceryItems);
      when(mockGroceryCubit.stream)
          .thenAnswer((_) => Stream.value(updatedGroceryItems));
      await tester.pump();

      // Act: Edit an existing grocery item
      await tester.tap(find.byIcon(Icons.edit).first);
      await tester.pump();
      await tester.enterText(find.byType(TextField).first, 'Grapes');
      await tester.enterText(find.byType(TextField).last, '10');
      await tester.tap(find.text('Save'));
      await tester.pump();

      // Log the state and calls made to the mock cubit
      print(
          'MockGroceryCubit state after editing item: ${mockGroceryCubit.state}');
      verify(mockGroceryCubit.updateGroceryItem(
              0, GroceryItem(name: 'Grapes', quantity: 10)))
          .called(1);
    });
  });
}
