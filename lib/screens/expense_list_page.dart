import 'package:flutter/material.dart';

class ExpenseListPage extends StatelessWidget {
  final List<Map<String, String>> expenses;

  const ExpenseListPage({
    super.key,
    required this.expenses,
  });

  @override
  Widget build(BuildContext context) {
    if (expenses.isEmpty) {
      return const Center(
        child: Text(
          "No expenses added yet",
          style: TextStyle(fontSize: 22),
        ),
      );
    }

    return ListView.builder(
      padding: const EdgeInsets.all(16),
      itemCount: expenses.length,
      itemBuilder: (context, index) {
        final item = expenses[index];

        return Card(
          margin: const EdgeInsets.only(bottom: 12),
          child: ListTile(
            leading: const Icon(Icons.currency_rupee),
            title: Text("₹${item["amount"]}"),
            subtitle: Text(
              "${item["category"]} • ${item["note"]}\n${item["date"]}",
            ),
            isThreeLine: true,
          ),
        );
      },
    );
  }
}