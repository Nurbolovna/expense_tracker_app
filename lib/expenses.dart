import 'package:flutter/material.dart';
import 'package:expense_tracker/expense_card.dart';
import 'package:expense_tracker/add_new_expense.dart';

class Expenses extends StatefulWidget {
  const Expenses({super.key, required this.onRemoveExpense});
  final void Function(expense_card expense) onRemoveExpense; 

  @override
  State<Expenses> createState() {
    return _ExpensesState();
  }
}

class _ExpensesState extends State<Expenses> {
  final List<expense_card> cards = [
    expense_card(
        name: 'Udemy course',
        price: 19.99,
        date: DateTime.now(),
        category: Category.study),
    expense_card(
        name: 'Croissant',
        price: 2.99,
        date: DateTime.now(),
        category: Category.food),
  ];
  //final List<expense_card> expenses;

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

  void _removeExpense(expense_card expense){
    setState(() {
      cards.remove(expense);

    });
  }

  @override
  Widget build(BuildContext build) {
    return Scaffold(
      appBar: AppBar(
        title: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(style: TextStyle(color: Colors.white), "Track your expenses"),
            ElevatedButton(
              onPressed: _openAddOverlay,
              child: Icon(
                Icons.add,
                color: Color.fromARGB(255, 219, 124, 8),
              ),
            )
          ],
        ),
        backgroundColor: const Color.fromARGB(255, 219, 124, 8),
      ),
      body: Column(
        children: [
          Text("Chart"),
          Expanded(
            child: ListView.builder(
                itemCount: cards.length,
                itemBuilder: (cxt, index) => Dismissible(
                    key: ValueKey(Card(
                        child: Padding(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 20,
                        vertical: 16,
                      ),
                      child: Column(
                        children: [
                          Text(cards[index].name),
                          //SizedBox(width: 460,),  why it is not working?
                          Row(
                            children: [
                              Text(
                                  '\$ ${cards[index].price.toStringAsFixed(2)}'),
                              const Spacer(),
                              Row(children: [
                                //Text(cards[index].category.toString()),
                                Icon(
                                  categoryIcons[cards[index].category]!,
                                  color: Color.fromARGB(255, 219, 124, 8),
                                ),
                                const SizedBox(
                                  width: 8,
                                ),
                                Text(cards[index].formattedDate),
                              ]),
                            ],
                          )
                        ],
                      ),
                    ))),
                    onDismissed: (direction){
                      onRemoveExpense(Card(
                        child: Padding(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 20,
                        vertical: 16,
                      ),
                      child: Column(
                        children: [
                          Text(cards[index].name),
                          //SizedBox(width: 460,),  why it is not working?
                          Row(
                            children: [
                              Text(
                                  '\$ ${cards[index].price.toStringAsFixed(2)}'),
                              const Spacer(),
                              Row(children: [
                                //Text(cards[index].category.toString()),
                                Icon(
                                  categoryIcons[cards[index].category]!,
                                  color: Color.fromARGB(255, 219, 124, 8),
                                ),
                                const SizedBox(
                                  width: 8,
                                ),
                                Text(cards[index].formattedDate),
                              ]),
                            ],
                          )
                        ],
                      ),
                    ))); 
                    },
                    child: Card(
                        child: Padding(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 20,
                        vertical: 16,
                      ),
                      child: Column(
                        children: [
                          Text(cards[index].name),
                          //SizedBox(width: 460,),  why it is not working?
                          Row(
                            children: [
                              Text(
                                  '\$ ${cards[index].price.toStringAsFixed(2)}'),
                              const Spacer(),
                              Row(children: [
                                //Text(cards[index].category.toString()),
                                Icon(
                                  categoryIcons[cards[index].category]!,
                                  color: Color.fromARGB(255, 219, 124, 8),
                                ),
                                const SizedBox(
                                  width: 8,
                                ),
                                Text(cards[index].formattedDate),
                              ]),
                            ],
                          )
                        ],
                      ),
                    )))),
          ),
        ],
      ),
    );
  }
}
