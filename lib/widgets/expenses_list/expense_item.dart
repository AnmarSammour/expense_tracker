import 'package:flutter/material.dart';
import '../../models/expense.dart';

class ExpenseItem extends StatelessWidget {
  const ExpenseItem(this.expense, {Key? key});

  final Expense expense;

  @override
  Widget build(BuildContext context) {
    return Card(
      child: Padding(
        padding: const EdgeInsets.symmetric(
          horizontal: 20,
          vertical: 16,
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              expense.title,
              style: Theme.of(context)
                  .textTheme
                  .headline6, // Displays the title of the expense
            ),
            const SizedBox(height: 4),
            Row(
              children: [
                // Displays the expense amount as text, using '\$' as a prefix
                Text(
                  '\$${expense.amount.toStringAsFixed(2)}',
                ),
                const Spacer(),
                // Displays the category icon and expense date
                Row(
                  children: [
                    Icon(categoryIcons[
                        expense.category]), // Displays the category icon
                    const SizedBox(width: 8),
                    Text(expense
                        .formattedDate), // Displays the date of the expense
                  ],
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
