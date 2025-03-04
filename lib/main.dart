
import 'package:flutter/material.dart';
import 'package:expense_tracker/expenses.dart'; 

var kColorScheme = ColorScheme.fromSeed(
  seedColor: Color.fromARGB(255, 219, 124, 8),
).copyWith(
  primary: Color.fromARGB(255, 219, 124, 8),
  secondaryContainer: Color.fromARGB(255, 236, 203, 168), 
 // surface: Colors.white,
  // ...
);
var kDarkColorScheme = ColorScheme.fromSeed(
  brightness: Brightness.dark,
  seedColor: Color.fromARGB(255, 219, 50, 8),
).copyWith(
  primary: Color.fromARGB(255, 219, 43, 8),
  // onPrimary: Colors.white,
);


void main() {
  runApp(
    MaterialApp(
darkTheme: ThemeData.dark().copyWith(
        useMaterial3: true,
        colorScheme: kDarkColorScheme,
  appBarTheme: const AppBarTheme().copyWith(
        backgroundColor: kColorScheme.primary,    // background = orange
        foregroundColor: kColorScheme.onPrimary, // text/icons = contrast
),
  cardTheme: const CardTheme().copyWith(
          color: kDarkColorScheme.secondaryContainer,
          margin: const EdgeInsets.symmetric(
            horizontal: 16,
            vertical: 8,
          ),
        ),
  elevatedButtonTheme: ElevatedButtonThemeData(
          style: ElevatedButton.styleFrom(
            backgroundColor: kDarkColorScheme.primaryContainer,
            foregroundColor: kDarkColorScheme.onPrimaryContainer,
          ),
        ),
      ),
theme: ThemeData().copyWith(
        useMaterial3: true,
        colorScheme: kColorScheme,
  appBarTheme: const AppBarTheme().copyWith(
          backgroundColor: kColorScheme.primary,
          foregroundColor: kColorScheme.onPrimary,
        ),
  cardTheme: const CardTheme().copyWith(
          color: kColorScheme.secondaryContainer,
          margin: const EdgeInsets.symmetric(
            horizontal: 16,
            vertical: 8,
          ),
        ),
  elevatedButtonTheme: ElevatedButtonThemeData(
          style: ElevatedButton.styleFrom(
            backgroundColor: kColorScheme.primaryContainer,
          ),
        ),
  textTheme: ThemeData().textTheme.copyWith(
              titleLarge: TextStyle(
                fontWeight: FontWeight.bold,
                color: kColorScheme.onSecondaryContainer,
                fontSize: 16,
              ),
            ),
      ),
    home: Expenses(onRemoveExpense: (expense){}))); 
    
}