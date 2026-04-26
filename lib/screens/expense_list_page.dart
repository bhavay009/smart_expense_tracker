import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class ExpenseListPage extends StatelessWidget {
  const ExpenseListPage({super.key});

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
              "No expenses added yet",
              style: TextStyle(fontSize: 22),
            ),
          );
        }

        Map<String, List<QueryDocumentSnapshot>> grouped = {};

        for (var doc in docs) {
          final data = doc.data() as Map<String, dynamic>;
          DateTime date = (data["date"] as Timestamp).toDate();

          String key =
              "${date.day}/${date.month}/${date.year}";

          grouped.putIfAbsent(key, () => []);
          grouped[key]!.add(doc);
        }

        final keys = grouped.keys.toList();

        return ListView.builder(
          padding: const EdgeInsets.all(16),
          itemCount: keys.length,
          itemBuilder: (context, index) {
            final dateKey = keys[index];
            final items = grouped[dateKey]!;

            return Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  dateKey,
                  style: const TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                  ),
                ),

                const SizedBox(height: 8),

                ...items.map((doc) {
                  final data = doc.data() as Map<String, dynamic>;

                  return Card(
                    child: ListTile(
                      leading: const Icon(Icons.currency_rupee),
                      title: Text(
                        "₹${(data["amount"] as num).toStringAsFixed(0)}",
                      ),
                      subtitle: Text(
                        "${data["category"]} • ${data["note"]}",
                      ),
                    ),
                  );
                }).toList(),

                const SizedBox(height: 12),
              ],
            );
          },
        );
      },
    );
  }
}