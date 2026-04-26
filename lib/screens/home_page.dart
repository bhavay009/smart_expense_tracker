import 'package:flutter/material.dart';
import 'add_expense_page.dart';
import 'expense_list_page.dart';
import 'insights_page.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  int currentIndex = 0;

  // Store expenses in parent widget
  final List<Map<String, String>> _expenses = [];

  void _addExpense(Map<String, String> expense) {
    setState(() {
      _expenses.add(expense);
    });
  }

  late final pages = [
    AddExpensePage(onExpenseAdded: _addExpense),
    ExpenseListPage(expenses: _expenses),
    InsightsPage(expenses: _expenses),
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
        onTap: (index) {
          setState(() {
            currentIndex = index;
          });
        },
        items: const [
          BottomNavigationBarItem(icon: Icon(Icons.add), label: "Add"),
          BottomNavigationBarItem(icon: Icon(Icons.list), label: "Expenses"),
          BottomNavigationBarItem(
            icon: Icon(Icons.bar_chart),
            label: "Insights",
          ),
        ],
      ),
    );
  }
}
