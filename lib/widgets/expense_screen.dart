import 'package:expense_trackerapp/widgets/charts/chart_bar.dart';
import 'package:expense_trackerapp/widgets/expenses_list/expense_list.dart';
import 'package:expense_trackerapp/models/expense.dart';
import 'package:expense_trackerapp/widgets/new_expense.dart';
import 'package:flutter/material.dart';
import 'package:expense_trackerapp/widgets/charts/chart.dart';

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
        useSafeArea: true,
        isScrollControlled: true,
        builder: (ctx) => NewExpense(onAddExpense: _addExpense));
  }

  void _addExpense(Expense expense) {
    setState(() {
      _registeredExpenses.add(expense);
    });
  }

  void _removeExpense(Expense expense) {
    final expenseIndex = _registeredExpenses.indexOf(expense);
    setState(() {
      _registeredExpenses.remove(expense);
    });
    ScaffoldMessenger.of(context).clearSnackBars();
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: const Text("Expense Deleted Successfully"),
        duration: const Duration(seconds: 5),
        action: SnackBarAction(
            label: 'Undo',
            onPressed: () {
              setState(() {
                _registeredExpenses.insert(expenseIndex, expense);
              });
            }),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.of(context).size.width;

    Widget mainContent = const Center(
      child: Text("No expenses, try to add some"),
    );
    if (_registeredExpenses.isNotEmpty) {
      mainContent = ExpenseList(
        expensesList: _registeredExpenses,
        onRemoveExpense: _removeExpense,
      );
    }
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
        body: width < 600
            ? Column(
                children: [
                  const Text('Chart'),
                  Chart(expenses: _registeredExpenses),
                  const Text('Expenses'),
                  Expanded(child: mainContent),
                ],
              )
            : Row(
                children: [
                  const Text('Chart'),
                  Expanded(child: Chart(expenses: _registeredExpenses)),
                  const Text('Expenses'),
                  Expanded(child: mainContent),
                ],
              ));
  }
}
