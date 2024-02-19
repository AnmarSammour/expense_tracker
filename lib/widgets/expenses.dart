import 'package:flutter/material.dart';

import 'new_expense.dart';
import 'expenses_list/expenses_list.dart';
import '../models/expense.dart';
import 'chart/chart.dart';

class Expenses extends StatefulWidget {
  const Expenses({Key? key});

  @override
  State<Expenses> createState() {
    return _ExpensesState();
  }
}

class _ExpensesState extends State<Expenses> {
  final List<Expense> _registeredExpenses = [];

  void _openAddExpenseOverlay() {
    // Display the add window to add a new expense
    showModalBottomSheet(
      useSafeArea: true,
      isScrollControlled: true,
      context: context,
      builder: (ctx) => NewExpense(onAddExpense: _addExpense),
    );
  }

  void _addExpense(Expense expense) {
    // Add a new expense
    setState(() {
      _registeredExpenses.add(expense);
    });
  }

  void _removeExpense(Expense expense) {
    // Remove expense
    final expenseIndex = _registeredExpenses.indexOf(expense);
    setState(() {
      _registeredExpenses.remove(expense);
    });
    ScaffoldMessenger.of(context).clearSnackBars();
    // Show a Snackbar message when expense is deleted with the option to undo
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        duration: const Duration(seconds: 3),
        content: const Text('Expense deleted.'),
        action: SnackBarAction(
          label: 'Undo',
          onPressed: () {
            setState(() {
              _registeredExpenses.insert(expenseIndex, expense);
            });
          },
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.of(context).size.width;

    // Determine the main content based on whether expenses exist or not
    Widget mainContent = const Center(
      child: Text('No expenses found. Start adding some!'),
    );

    if (_registeredExpenses.isNotEmpty) {
      // Display the expenses list
      mainContent = ExpensesList(
        expenses: _registeredExpenses,
        onRemoveExpense: _removeExpense,
      );
    }

    return Scaffold(
      appBar: AppBar(
        title: const Text('Flutter ExpenseTracker'),
        actions: [
          // Button to open the add window
          IconButton(
            onPressed: _openAddExpenseOverlay,
            icon: const Icon(Icons.add),
          ),
        ],
      ),
      body: width < 600
          ? Column(
              children: [
                // Display statistics in case of narrow screens
                Chart(expenses: _registeredExpenses),
                // Display the expenses list
                Expanded(
                  child: mainContent,
                ),
              ],
            )
          : Row(children: [
              // Display statistics in case of wide screens
              Expanded(
                child: Chart(expenses: _registeredExpenses),
              ),
              // Display the expenses list
              Expanded(
                child: mainContent,
              ),
            ]),
    );
  }
}
