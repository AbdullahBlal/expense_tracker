import 'package:expense_trackerapp/widgets/expenses_list/expense_list.dart';
import 'package:expense_trackerapp/models/expense.dart';
import 'package:expense_trackerapp/widgets/new_expense.dart';
import 'package:flutter/material.dart';

class ExpenseScreen extends StatefulWidget {
  const ExpenseScreen({super.key});
  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    return _ExpenseScreenState();
  }
}

class _ExpenseScreenState extends State<ExpenseScreen> {
  final List<Expense> _registeredExpenses = [
    Expense(
        title: "Flutter Course",
        amount: 19.9,
        date: DateTime.now(),
        category: Category.food),
    Expense(
        title: "Cinema",
        amount: 20.20,
        date: DateTime.now(),
        category: Category.work),
  ];

  void _addExpenseOverlay() {
    showModalBottomSheet(
        context: context,
        isScrollControlled: true,
        builder: (ctx) => NewExpense(onAddExpense: _addExpense));
  }

  void _addExpense(Expense expense) {
    setState(() {
      _registeredExpenses.add(expense);
    });
  }
    void _removeExpense(Expense expense) {
    setState(() {
      _registeredExpenses.remove(expense);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Flutter Expense Tracker'),
        actions: [
          IconButton(
            onPressed: _addExpenseOverlay,
            icon: const Icon(Icons.add),
          )
        ],
      ),
      body: Expanded(
        child: Column(
          children: [
            const Text('Chart'),
            const Text('Expenses'),
            Expanded(
              child: ExpenseList(expensesList: _registeredExpenses, onRemoveExpense: _removeExpense,),
            ),
          ],
        ),
      ),
    );
  }
}
