import 'package:flutter/material.dart';
import 'package:uuid/uuid.dart';
import 'package:intl/intl.dart';

final formatter = DateFormat.yMd(); //year/month/day

var uuid = Uuid();

enum Category { food, leisure, study, shopping, presents }

final Map<Category, IconData> categoryIcons = {
  Category.food: Icons.lunch_dining,
  Category.leisure: Icons.movie,
  Category.presents: Icons.card_giftcard,
  Category.shopping: Icons.shopping_bag,
  Category.study: Icons.book,
}; //map

class expense_card {
  expense_card({
    required this.name,
    required this.price,
    required this.date,
    required this.category,
  }) : id = uuid.v4();

  final String name;
  final double price;
  final DateTime date;
  final String id;
  final Category category;

  String get formattedDate {
    return formatter.format(date);
  }
}

class ExpenseBucket {
  const ExpenseBucket({
    required this.category,
    required this.expenses,
  });
  ExpenseBucket.forCategory(List<expense_card> allExpenses, this.category)
      : expenses = allExpenses
            .where((expense) => expense.category == category)
            .toList();
  final Category category;
  final List<expense_card> expenses;

  double get totalPrice {
    double sum = 0;
    for (final expense in expenses) {
      sum += expense.price;
    }
    return sum;
  }
}
