import 'package:flutter/material.dart';
import 'screens/stock_list_page.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Stocet App',
      theme: ThemeData(primarySwatch: Colors.blue),
      home: const StockListPage(),
      debugShowCheckedModeBanner: false,
    );
  }
}
