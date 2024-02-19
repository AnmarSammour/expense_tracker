import 'package:flutter/material.dart';

import 'expense_item.dart';
import '../../models/expense.dart';

class ExpensesList extends StatelessWidget {
  const ExpensesList({
    Key? key,
    required this.expenses,
    required this.onRemoveExpense,
  });

  final List<Expense> expenses;
  final void Function(Expense expense) onRemoveExpense;

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemCount: expenses.length, // Specifies the number of items in the list
      itemBuilder: (ctx, index) => Dismissible(
        key: ValueKey(
            expenses[index]), // Key for each item to ensure proper distinction
        background: Container(
          // Slide-out background of the item when deleting
          color: Theme.of(context).colorScheme.error.withOpacity(0.75),
          margin: EdgeInsets.symmetric(
            horizontal: Theme.of(context).cardTheme.margin!.horizontal,
          ),
        ),
        onDismissed: (direction) {
          onRemoveExpense(
              expenses[index]); // Function called when the item is deleted
        },
        child: ExpenseItem(
          expenses[index], // Displays the expense item using `ExpenseItem`
        ),
      ),
    );
  }
}
