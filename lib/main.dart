import 'package:flutter/material.dart';

void main() {
  runApp(const ExpenseApp());
}

class ExpenseApp extends StatelessWidget {
  const ExpenseApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: "Smart Expense Tracker",
      theme: ThemeData(primarySwatch: Colors.indigo),
      home: const HomePage(),
    );
  }
}

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  int currentIndex = 0;

  final pages = [
    const AddExpensePage(),
    const Center(
      child: Text("📋 Expense List", style: TextStyle(fontSize: 24)),
    ),
    const Center(child: Text("📊 Insights", style: TextStyle(fontSize: 24))),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Smart Expense Tracker"),
        centerTitle: true,
      ),
      body: pages[currentIndex],
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: currentIndex,
        selectedItemColor: Colors.indigo,
        onTap: (index) {
          setState(() {
            currentIndex = index;
          });
        },
        items: const [
          BottomNavigationBarItem(
            icon: Icon(Icons.add_circle_outline),
            label: "Add",
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.list_alt),
            label: "Expenses",
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.bar_chart),
            label: "Insights",
          ),
        ],
      ),
    );
  }
}

class AddExpensePage extends StatefulWidget {
  const AddExpensePage({super.key});

  @override
  State<AddExpensePage> createState() => _AddExpensePageState();
}

class _AddExpensePageState extends State<AddExpensePage> {
  final amountController = TextEditingController();
  final noteController = TextEditingController();

  String selectedCategory = "Food";
  DateTime selectedDate = DateTime.now();

  final categories = ["Food", "Travel", "Shopping", "Bills", "Other"];

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
            value: selectedCategory,
            items: categories.map((item) {
              return DropdownMenuItem(value: item, child: Text(item));
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

          ElevatedButton(onPressed: () {}, child: const Text("Save Expense")),
        ],
      ),
    );
  }
}
