import 'package:flutter/material.dart';

class InsightsPage extends StatelessWidget {
  final List<Map<String, String>> expenses;

  const InsightsPage({
    super.key,
    required this.expenses,
  });

  @override
  Widget build(BuildContext context) {
    int total = 0;
    Map<String, int> categoryTotals = {};

    for (var item in expenses) {
      int amount = int.tryParse(item["amount"] ?? "0") ?? 0;
      String category = item["category"] ?? "Other";

      total += amount;

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

    if (expenses.isEmpty) {
      return const Center(
        child: Text(
          "No insights yet",
          style: TextStyle(fontSize: 24),
        ),
      );
    }

    return Padding(
      padding: const EdgeInsets.all(16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Card(
            child: ListTile(
              leading: const Icon(Icons.currency_rupee),
              title: const Text("Total Spending"),
              subtitle: Text("₹$total"),
            ),
          ),

          const SizedBox(height: 12),

          Card(
            child: ListTile(
              leading: const Icon(Icons.receipt_long),
              title: const Text("Transactions"),
              subtitle: Text("${expenses.length} expenses added"),
            ),
          ),

          const SizedBox(height: 12),

          Card(
            child: ListTile(
              leading: const Icon(Icons.category),
              title: const Text("Top Category"),
              subtitle: Text(topCategory),
            ),
          ),

          const SizedBox(height: 20),

          const Text(
            "Smart Insight",
            style: TextStyle(
              fontSize: 22,
              fontWeight: FontWeight.bold,
            ),
          ),

          const SizedBox(height: 10),

          Container(
            width: double.infinity,
            padding: const EdgeInsets.all(16),
            decoration: BoxDecoration(
              color: Colors.indigo.shade50,
              borderRadius: BorderRadius.circular(12),
            ),
            child: Text(
              "You spent the most on $topCategory.",
              style: const TextStyle(fontSize: 18),
            ),
          ),
        ],
      ),
    );
  }
}