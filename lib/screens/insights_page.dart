import 'package:flutter/material.dart';

class InsightsPage extends StatelessWidget {
  final List<Map<String, String>> expenses;

  const InsightsPage({
    super.key,
    required this.expenses,
  });

  @override
  Widget build(BuildContext context) {
    if (expenses.isEmpty) {
      return const Center(
        child: Text(
          "No insights yet",
          style: TextStyle(fontSize: 24),
        ),
      );
    }

    int weekTotal = 0;
    int monthTotal = 0;

    Map<String, int> categoryTotals = {};

    DateTime now = DateTime.now();

    for (var item in expenses) {
      int amount = int.tryParse(item["amount"] ?? "0") ?? 0;
      String category = item["category"] ?? "Other";
      String dateText = item["date"] ?? "";

      List<String> parts = dateText.split("/");

      if (parts.length == 3) {
        int day = int.parse(parts[0]);
        int month = int.parse(parts[1]);
        int year = int.parse(parts[2]);

        DateTime expenseDate = DateTime(year, month, day);

        // Monthly total
        if (expenseDate.month == now.month &&
            expenseDate.year == now.year) {
          monthTotal += amount;
        }

        // Weekly total (last 7 days)
        if (now.difference(expenseDate).inDays <= 7 &&
            now.difference(expenseDate).inDays >= 0) {
          weekTotal += amount;
        }
      }

      categoryTotals[category] =
          (categoryTotals[category] ?? 0) + amount;
    }

    String topCategory = "None";
    int maxAmount = 0;

    categoryTotals.forEach((key, value) {
      if (value > maxAmount) {
        maxAmount = value;
        topCategory = key;
      }
    });

    return SingleChildScrollView(
      padding: const EdgeInsets.all(16),
      child: Column(
        children: [
          Card(
            child: ListTile(
              leading: const Icon(Icons.calendar_view_week),
              title: const Text("This Week"),
              subtitle: Text("₹$weekTotal"),
            ),
          ),

          const SizedBox(height: 12),

          Card(
            child: ListTile(
              leading: const Icon(Icons.calendar_month),
              title: const Text("This Month"),
              subtitle: Text("₹$monthTotal"),
            ),
          ),

          const SizedBox(height: 20),

          const Align(
            alignment: Alignment.centerLeft,
            child: Text(
              "Category Breakdown",
              style: TextStyle(
                fontSize: 22,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),

          const SizedBox(height: 10),

          ...categoryTotals.entries.map(
            (entry) => Card(
              child: ListTile(
                leading: const Icon(Icons.category),
                title: Text(entry.key),
                trailing: Text("₹${entry.value}"),
              ),
            ),
          ),

          const SizedBox(height: 20),

          Container(
            width: double.infinity,
            padding: const EdgeInsets.all(16),
            decoration: BoxDecoration(
              color: Colors.indigo.shade50,
              borderRadius: BorderRadius.circular(12),
            ),
            child: Text(
              "You spent the most on $topCategory this month.",
              style: const TextStyle(fontSize: 18),
            ),
          ),
        ],
      ),
    );
  }
}