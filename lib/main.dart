import 'package:expense_tracker/expense_card.dart';
import 'package:flutter/material.dart';
import 'package:expense_tracker/expenses.dart'; 

void main() {
  runApp(
    MaterialApp(
    home: Expenses(onRemoveExpense: (expense){},))); 
    
}