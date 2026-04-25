import 'package:flutter/material.dart';
import 'add_expense_page.dart';
import 'expense_list_page.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  int currentIndex = 0;

  List<Map<String, String>> expenses = [];

  List<Widget> get pages => [
        AddExpensePage(
          onSave: (expense) {
            setState(() {
              expenses.add(expense);
              currentIndex = 1;
            });
          },
        ),
        ExpenseListPage(expenses: expenses),
        const Center(
          child: Text(
            "📊 Insights",
            style: TextStyle(fontSize: 24),
          ),
        ),
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