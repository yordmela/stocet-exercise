import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:stocet/screens/allocation_screen.dart';
import 'package:stocet/screens/home_screen.dart';
import 'package:stocet/screens/result_screen.dart';
import 'package:stocet/screens/setup_screen.dart';
import 'screens/stock_list_page.dart';
import 'screens/bond_list_page.dart'; // Import your Bond List Page

void main() {
  runApp(ProviderScope(child: const MyApp()));
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Stock and Bond App',
      theme: ThemeData(primarySwatch: Colors.blue),
      // Remove home property
      initialRoute: '/', // Set your desired default route
      routes: {
        '/': (context) => const StockListPage(),
        '/bonds': (context) => const BondListPage(),
        '/cmsp': (context) => HomeScreen(),
        '/portfolio': (context) => const SetupScreen(),
        '/allocation': (context) => const AllocationScreen(),
        '/result': (context) => const ResultScreen(),
      },
      debugShowCheckedModeBanner: false,
    );
  }
}
