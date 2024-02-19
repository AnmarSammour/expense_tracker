import 'package:flutter/material.dart';
import 'package:uuid/uuid.dart';
import 'package:intl/intl.dart'; 

// Date formatting
final formatter = DateFormat.yMd();

// Creating a unique random identifier for each expense
const uuid = Uuid();

// Definition to represent different categories of expenses
// Using enum for enumeration
enum Category { food, travel, leisure, work }

// Assigning icons for each category
const categoryIcons = {
  Category.food: Icons.lunch_dining,
  Category.travel: Icons.flight_takeoff,
  Category.leisure: Icons.movie,
  Category.work: Icons.work,
};

// Represents an expense containing properties (title, amount, date, category)
class Expense {
  Expense({
    required this.title,
    required this.amount,
    required this.date,
    required this.category,
  }) : id = uuid.v4(); // Generating a unique identifier for each expense using Uuid

  final String id;
  final String title;
  final double amount;
  final DateTime date;
  final Category category;

  // Formats the date into a readable string
  String get formattedDate {
    return formatter.format(date);
  }
}

// Class representing a "bucket" to store expenses based on their category
class ExpenseBucket {
  const ExpenseBucket({
    required this.category,
    required this.expenses,
  });

  // Constructor to generate a bucket containing expenses based on a specific category
  ExpenseBucket.forCategory(List<Expense> allExpenses, this.category)
      : expenses = allExpenses
            .where((expense) => expense.category == category)
            .toList();

  final Category category;
  final List<Expense> expenses;

  // Calculates the total expenses
  double get totalExpenses {
    double sum = 0;

    for (final expense in expenses) {
      sum += expense.amount;
    }

    return sum;
  }
}
