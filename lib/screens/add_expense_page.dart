import 'package:flutter/material.dart';

class AddExpensePage extends StatefulWidget {
  final Function(Map<String, String>) onSave;

  const AddExpensePage({
    super.key,
    required this.onSave,
  });

  @override
  State<AddExpensePage> createState() => _AddExpensePageState();
}

class _AddExpensePageState extends State<AddExpensePage> {
  final amountController = TextEditingController();
  final noteController = TextEditingController();

  String selectedCategory = "Food";

  final categories = [
    "Food",
    "Travel",
    "Shopping",
    "Bills",
    "Other",
  ];

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16),
      child: SingleChildScrollView(
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
              value: selectedCategory,
              items: categories.map((item) {
                return DropdownMenuItem(
                  value: item,
                  child: Text(item),
                );
              }).toList(),
              onChanged: (value) {
                setState(() {
                  selectedCategory = value!;
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

            SizedBox(
              width: double.infinity,
              child: ElevatedButton(
                onPressed: () {
                  widget.onSave({
                    "amount": amountController.text,
                    "category": selectedCategory,
                    "note": noteController.text,
                  });

                  amountController.clear();
                  noteController.clear();
                },
                child: const Text("Save Expense"),
              ),
            ),
          ],
        ),
      ),
    );
  }
}