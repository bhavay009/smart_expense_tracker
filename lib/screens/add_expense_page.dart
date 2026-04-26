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
  DateTime selectedDate = DateTime.now();

  final categories = [
    "Food",
    "Travel",
    "Shopping",
    "Bills",
    "Other",
  ];

  Future<void> pickDate() async {
    DateTime? picked = await showDatePicker(
      context: context,
      initialDate: selectedDate,
      firstDate: DateTime(2023),
      lastDate: DateTime(2030),
    );

    if (picked != null) {
      setState(() {
        selectedDate = picked;
      });
    }
  }

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

            const SizedBox(height: 15),

            ListTile(
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(8),
                side: const BorderSide(color: Colors.grey),
              ),
              title: Text(
                "${selectedDate.day}/${selectedDate.month}/${selectedDate.year}",
              ),
              trailing: const Icon(Icons.calendar_today),
              onTap: pickDate,
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
                    "date":
                        "${selectedDate.day}/${selectedDate.month}/${selectedDate.year}",
                  });

                  amountController.clear();
                  noteController.clear();

                  setState(() {
                    selectedCategory = "Food";
                    selectedDate = DateTime.now();
                  });
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