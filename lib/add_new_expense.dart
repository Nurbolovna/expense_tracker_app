import 'package:expense_tracker/expense_card.dart';
import 'package:flutter/material.dart';

class AddNewExpense extends StatefulWidget {
  const AddNewExpense({super.key, required this.onAddExpense});

  final void Function(expense_card expense) onAddExpense; 
  @override
  State<AddNewExpense> createState() {
    return _AddNewExpenseState();
  }
}

class _AddNewExpenseState extends State<AddNewExpense> {
  final titleController = TextEditingController();
  final priceController = TextEditingController();
  DateTime? _selectedDate;
  Category _selectedCategory = Category.study;



  void _submitExpenseData() {
    final enteredPrice = double.tryParse(priceController.text);
    final priceIsInvalid = enteredPrice == null || enteredPrice <= 0;
    //error message
    if (titleController.text.trim().isEmpty ||
        priceIsInvalid ||
        _selectedDate == null) {
      showDialog(
        context: context,
        builder: (ctx) => AlertDialog(
          title: Text(style: TextStyle(color: Colors.red), 'Invalid input'),
          content: const Text('Please make sure that you wrote the name, price and selected the date'),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.pop(ctx);
              },
              child: const Text(style: TextStyle(color: Color.fromARGB(255, 4, 137, 18)), "Return"),
            ),
          ],
        ),
      );
      return;
    }
    widget.onAddExpense(expense_card(name: titleController.text, price: enteredPrice, date: _selectedDate!, category: _selectedCategory));
    Navigator.pop(context);
  }

  

  void _datepicker() async {
    final now = DateTime.now();
    final firstDate = DateTime(now.year - 1, now.month);
    final pickedDate = await showDatePicker(
        context: context,
        initialDate: now,
        firstDate: firstDate,
        lastDate: now);
    setState(() {
      _selectedDate = pickedDate;
    });
  }

  @override
  void dispose() {
    titleController.dispose();
    priceController.dispose();
    super.dispose();
  }

  @override
  Widget build(build) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(16, 64, 16, 16),
      child: Column(
        children: [
          Text(
            "Add a new expense below: ",
            textAlign: TextAlign.left,
            style: TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.bold,
              color: const Color.fromARGB(255, 134, 132, 132),
            ),
          ),
          TextField(
            controller: titleController,
            maxLength: 50,
            decoration: InputDecoration(
              label: Text(
                  style: TextStyle(
                    color: const Color.fromARGB(255, 83, 82, 82),
                  ),
                  "Expense name:"),
              enabledBorder: UnderlineInputBorder(
                borderSide: BorderSide(color: Colors.grey),
              ),
              focusedBorder: UnderlineInputBorder(
                borderSide: BorderSide(
                  color: Color.fromARGB(255, 219, 124, 8),
                ),
              ),
            ),
          ),
          Row(
            children: [
              Expanded(
                child: TextField(
                  controller: priceController,
                  keyboardType: TextInputType.number,
                  decoration: InputDecoration(
                    prefixText: '\$',
                    label: Text(
                        style: TextStyle(
                          color: const Color.fromARGB(255, 83, 82, 82),
                        ),
                        "Price:"),
                    enabledBorder: UnderlineInputBorder(
                      borderSide: BorderSide(color: Colors.grey),
                    ),
                    focusedBorder: UnderlineInputBorder(
                      borderSide: BorderSide(
                        color: Color.fromARGB(255, 219, 124, 8),
                      ),
                    ),
                  ),
                ),
              ),
              const SizedBox(width: 16),
              Expanded(
                  child: Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  Text(_selectedDate == null
                      ? 'No data selected'
                      : formatter.format(_selectedDate!)),
                  IconButton(
                    onPressed: _datepicker,
                    icon: Icon(Icons.calendar_month),
                  ),
                ],
              )),
            ],
          ),
          SizedBox(height: 16),
          Row(
            children: [
              DropdownButton(
                  value: _selectedCategory,
                  items: Category.values
                      .map((category) => DropdownMenuItem(
                            value: category,
                            child: Text(category.name.toUpperCase()),
                          ))
                      .toList(),
                  onChanged: (value) {
                    if (value == null) return;
                    setState(() {
                      _selectedCategory = value;
                    });
                  }),
              const Spacer(),
              OutlinedButton(
                onPressed: () {
                  Navigator.pop(context);
                },
                style: OutlinedButton.styleFrom(
                  side: BorderSide(
                    color: Color.fromARGB(255, 219, 124, 8),
                  ),
                ),
                child: Text(
                    style: TextStyle(
                      color: Color.fromARGB(255, 219, 124, 8),
                    ),
                    'Cancel'),
              ),
              SizedBox(width: 8),
              ElevatedButton(
                onPressed: _submitExpenseData,
                style: ElevatedButton.styleFrom(
                  backgroundColor: Color.fromARGB(255, 219, 124, 8),
                ),
                child: Text(style: TextStyle(color: Colors.white), "Save"),
              ),
            ],
          )
        ],
      ),
    ); 
  }
}
