import 'package:flutter/material.dart';
import 'package:expense_tracker/expense_card.dart';
import 'package:expense_tracker/add_new_expense.dart';

class Expenses extends StatefulWidget {
  const Expenses({super.key, required this.onRemoveExpense});
  final void Function(expense_card expense) onRemoveExpense;

  @override
  State<Expenses> createState() => _ExpensesState();
}

class _ExpensesState extends State<Expenses> {
  final List<expense_card> cards = [
    expense_card(
      name: 'Udemy course',
      price: 19.99,
      date: DateTime.now(),
      category: Category.study,
    ),
    expense_card(
      name: 'Croissant',
      price: 2.99,
      date: DateTime.now(),
      category: Category.food,
    ),
  ];

  void _openAddOverlay() {
    showModalBottomSheet(
      isScrollControlled: true,
      context: context,
      builder: (ctx) => AddNewExpense(
        onAddExpense: _addExpenseCard,
      ),
    );
  }

  void _addExpenseCard(expense_card expense) {
    setState(() {
      cards.add(expense);
    });
  }

  

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            const Text(
              "Track your expenses",
              style: TextStyle(color: Colors.white),
            ),
            ElevatedButton(
              onPressed: _openAddOverlay,
              child: const Icon(
                Icons.add,
                color: Color.fromARGB(255, 219, 124, 8),
              ),
            ),
          ],
        ),
        backgroundColor: const Color.fromARGB(255, 219, 124, 8),
      ),
      body: Column(
        children: [
          const Text("Chart"),
          Expanded(
            child: ListView.builder(
              itemCount: cards.length,
              itemBuilder: (ctx, index) => Dismissible(
                // Use a unique identifier from the expense card
                key: ValueKey(cards[index].name),
                onDismissed: (direction) {
                  final removedExpense = cards[index];
                  setState(() {
                    widget.onRemoveExpense(cards[index]);
                    cards.removeAt(index);
                  });
                  widget.onRemoveExpense(removedExpense);
                },
                child: Card(
                  child: Padding(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 20,
                      vertical: 16,
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(cards[index].name),
                        Row(
                          children: [
                            Text('\$ ${cards[index].price.toStringAsFixed(2)}'),
                            const Spacer(),
                            Row(
                              children: [
                                Icon(
                                  categoryIcons[cards[index].category]!,
                                  color: const Color.fromARGB(255, 219, 124, 8),
                                ),
                                const SizedBox(width: 8),
                                Text(cards[index].formattedDate),
                              ],
                            ),
                          ],
                        )
                      ],
                    ),
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
