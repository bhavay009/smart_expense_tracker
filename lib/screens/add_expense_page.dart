import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class AddExpensePage extends StatefulWidget {
  final Function(Map<String, String>)? onExpenseAdded;

  const AddExpensePage({super.key, this.onExpenseAdded});

  @override
  State<AddExpensePage> createState() => _AddExpensePageState();
}

class _AddExpensePageState extends State<AddExpensePage> {
  final amountController = TextEditingController();
  final noteController = TextEditingController();

  String category = "Food";

  Future<void> saveExpense() async {
    if (amountController.text.isEmpty) return;

    await FirebaseFirestore.instance.collection("expenses").add({
      "amount": double.parse(amountController.text),
      "category": category,
      "note": noteController.text,
      "date": DateTime.now(),
    });

    // Call the callback if provided
    if (widget.onExpenseAdded != null) {
      widget.onExpenseAdded!({
        "amount": amountController.text,
        "category": category,
        "note": noteController.text,
        "date": DateTime.now().toIso8601String(),
      });
    }

    amountController.clear();
    noteController.clear();

    ScaffoldMessenger.of(
      context,
    ).showSnackBar(const SnackBar(content: Text("Expense Saved")));
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16),
      child: Column(
        children: [
          TextField(
            controller: amountController,
            keyboardType: TextInputType.number,
            decoration: const InputDecoration(
              labelText: "Amount",
              border: OutlineInputBorder(),
            ),
          ),
          const SizedBox(height: 15),

          DropdownButtonFormField(
            value: category,
            items: const [
              DropdownMenuItem(value: "Food", child: Text("Food")),
              DropdownMenuItem(value: "Travel", child: Text("Travel")),
              DropdownMenuItem(value: "Shopping", child: Text("Shopping")),
            ],
            onChanged: (value) {
              setState(() {
                category = value!;
              });
            },
            decoration: const InputDecoration(
              labelText: "Category",
              border: OutlineInputBorder(),
            ),
          ),

          const SizedBox(height: 15),

          TextField(
            controller: noteController,
            decoration: const InputDecoration(
              labelText: "Note",
              border: OutlineInputBorder(),
            ),
          ),

          const SizedBox(height: 20),

          ElevatedButton(
            onPressed: saveExpense,
            child: const Text("Save Expense"),
          ),
        ],
      ),
    );
  }
}
