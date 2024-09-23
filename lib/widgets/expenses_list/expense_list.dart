import 'package:expense_trackerapp/models/expense.dart';
import 'package:expense_trackerapp/widgets/expenses_list/expense_item.dart';
import 'package:flutter/material.dart';

class ExpenseList extends StatelessWidget {
  const ExpenseList({
    super.key,
    required this.expensesList,
    required this.onRemoveExpense,
  });

  final List<Expense> expensesList;
  final void Function (Expense expense) onRemoveExpense;
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return ListView.builder(
      itemCount: expensesList.length,
      itemBuilder: (ctx, index) => Dismissible(
        key: ValueKey(expensesList[index]),
        onDismissed: (direction) => onRemoveExpense(expensesList[index]),
        child: ExpenseItem(
          expense: expensesList[index],
        ),
      ),
    );
  }
}
