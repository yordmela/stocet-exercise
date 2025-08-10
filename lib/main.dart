import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:provider/provider.dart';
import 'package:stocet/providers/order_book.dart';
import 'package:stocet/screens/allocation_screen.dart';
import 'package:stocet/screens/home_screen.dart';
import 'package:stocet/screens/indicators_app/indicator_home_page.dart';
import 'package:stocet/screens/new_order_screen.dart';
import 'package:stocet/screens/order_book_screen.dart';
import 'package:stocet/screens/result_screen.dart';
import 'package:stocet/screens/setup_screen.dart';
import 'screens/stock_list_page.dart';
import 'screens/bond_list_page.dart'; 
import 'package:provider/provider.dart' as p;


void main() {
  runApp(ProviderScope(child: const MyApp()));
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        p.ChangeNotifierProvider(create: (_) => OrderBookProvider()),
        // other providers from provider package
      ],
      child: MaterialApp(
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
          '/indicators': (context) => const IndicatorHomePage(),
          '/new': (context) => const NewOrderScreen(),
          '/book': (context) => const OrderBookScreen(),
        },
        debugShowCheckedModeBanner: false,
      ),
    );
  }
}
