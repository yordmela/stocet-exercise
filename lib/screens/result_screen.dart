import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../providers/investment_provider.dart';

class ResultScreen extends ConsumerWidget {
  const ResultScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final result = ref.watch(allocationResultProvider);

    if (result == null) {
      return const Scaffold(body: Center(child: Text('Missing result')));
    }

    return Scaffold(
      appBar: AppBar(title: const Text('Investment Result')),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          children: [
            Text('Projected Stock Return: ${result.stockReturn.toStringAsFixed(2)} ETB'),
            Text('Projected Bond Return: ${result.bondReturn.toStringAsFixed(2)} ETB'),
            Text('Projected Cash Return: ${result.cashReturn.toStringAsFixed(2)} ETB'),
            const Divider(height: 30),
            Text('Total Projected Return: ${result.totalReturn.toStringAsFixed(2)} ETB',
                style: const TextStyle(fontWeight: FontWeight.bold)),
            const SizedBox(height: 12),
            Text(
              result.goalMet ? '🎉 Goal Met!' : '⚠️ Goal Not Met',
              style: TextStyle(
                fontSize: 18,
                color: result.goalMet ? Colors.green : Colors.red,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
