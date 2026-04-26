import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class InsightsPage extends StatelessWidget {
  const InsightsPage({super.key});

  @override
  Widget build(BuildContext context) {
    return StreamBuilder(
      stream: FirebaseFirestore.instance.collection("expenses").snapshots(),
      builder: (context, snapshot) {
        if (!snapshot.hasData) {
          return const Center(child: CircularProgressIndicator());
        }

        final docs = snapshot.data!.docs;

        if (docs.isEmpty) {
          return const Center(
            child: Text(
              "No insights yet",
              style: TextStyle(fontSize: 22),
            ),
          );
        }

        double total = 0;
        Map<String, double> categoryTotals = {};

        for (var doc in docs) {
          double amount = (doc["amount"] as num).toDouble();
          String category = doc["category"];

          total += amount;

          categoryTotals[category] =
              (categoryTotals[category] ?? 0) + amount;
        }

        String topCategory = "";
        double maxSpend = 0;

        categoryTotals.forEach((key, value) {
          if (value > maxSpend) {
            maxSpend = value;
            topCategory = key;
          }
        });

        return SingleChildScrollView(
          padding: const EdgeInsets.all(16),
          child: Column(
            children: [
              Card(
                child: ListTile(
                  leading: const Icon(Icons.currency_rupee),
                  title: const Text("Total Spending"),
                  subtitle: Text("₹${total.toStringAsFixed(0)}"),
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
                    title: Text(entry.key),
                    trailing: Text(
                      "₹${entry.value.toStringAsFixed(0)}",
                    ),
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
                  "You spent the most on $topCategory.",
                  style: const TextStyle(fontSize: 18),
                ),
              ),
            ],
          ),
        );
      },
    );
  }
}