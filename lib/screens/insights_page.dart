import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class InsightsPage extends StatelessWidget {
  const InsightsPage({super.key});

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<QuerySnapshot>(
      stream: FirebaseFirestore.instance
          .collection("expenses")
          .orderBy("date", descending: true)
          .snapshots(),
      builder: (context, snapshot) {
        if (snapshot.hasError) {
          return const Center(child: Text("Something went wrong"));
        }

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

        final now = DateTime.now();

        double weekTotal = 0;
        double monthTotal = 0;
        double lastWeekTotal = 0;

        Map<String, double> categoryTotals = {};

        for (var doc in docs) {
          final data = doc.data() as Map<String, dynamic>;

          double amount = (data["amount"] as num).toDouble();
          String category = data["category"] ?? "Other";

          DateTime expenseDate = (data["date"] as Timestamp).toDate();

          int diffDays = now.difference(expenseDate).inDays;

          // This week
          if (diffDays >= 0 && diffDays <= 7) {
            weekTotal += amount;
          }

          // Last week
          if (diffDays > 7 && diffDays <= 14) {
            lastWeekTotal += amount;
          }

          // This month
          if (expenseDate.month == now.month &&
              expenseDate.year == now.year) {
            monthTotal += amount;
          }

          categoryTotals[category] =
              (categoryTotals[category] ?? 0) + amount;
        }

        String topCategory = "";
        double topValue = 0;

        categoryTotals.forEach((key, value) {
          if (value > topValue) {
            topValue = value;
            topCategory = key;
          }
        });

        String smartInsight = "You spent the most on $topCategory.";

        if (lastWeekTotal > 0 && weekTotal > lastWeekTotal) {
          double increase =
              ((weekTotal - lastWeekTotal) / lastWeekTotal) * 100;

          smartInsight =
              "You spent ${increase.toStringAsFixed(0)}% more this week than last week.";
        }

        return SingleChildScrollView(
          padding: const EdgeInsets.all(16),
          child: Column(
            children: [
              Card(
                child: ListTile(
                  leading: const Icon(Icons.calendar_view_week),
                  title: const Text("This Week"),
                  trailing: Text("₹${weekTotal.toStringAsFixed(0)}"),
                ),
              ),

              const SizedBox(height: 10),

              Card(
                child: ListTile(
                  leading: const Icon(Icons.calendar_month),
                  title: const Text("This Month"),
                  trailing: Text("₹${monthTotal.toStringAsFixed(0)}"),
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
                  smartInsight,
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