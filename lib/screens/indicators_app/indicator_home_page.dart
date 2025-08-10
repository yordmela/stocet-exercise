import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../indicators_app/indicators_page.dart';
import '../indicators_app/about_page.dart';

class IndicatorHomePage extends ConsumerStatefulWidget {
  const IndicatorHomePage({super.key});
  @override
  ConsumerState<IndicatorHomePage> createState() => _HomePageState();
}

class _HomePageState extends ConsumerState<IndicatorHomePage> {
  int _current = 1;

  final List<Widget> _pages = const [
    Center(child: Text('Welcome to Stocet')), // Home placeholder
    IndicatorsPage(),
    AboutPage(),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _pages[_current],
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _current,
        onTap: (i) => setState(() => _current = i),
        items: const [
          BottomNavigationBarItem(icon: Icon(Icons.home), label: 'Home'),
          BottomNavigationBarItem(icon: Icon(Icons.show_chart), label: 'Indicators'),
          BottomNavigationBarItem(icon: Icon(Icons.info), label: 'About'),
        ],
      ),
    );
  }
}
