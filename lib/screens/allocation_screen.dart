import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../providers/investment_provider.dart';

class AllocationScreen extends ConsumerWidget {
  const AllocationScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final input = ref.watch(investmentInputProvider);
    final result = ref.watch(allocationResultProvider);

    if (input == null || result == null) {
      return const Scaffold(body: Center(child: Text('Missing data')));
    }

    return Scaffold(
      appBar: AppBar(title: const Text('Allocation Overview')),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          children: [
            Text('Investor Type: ${input.investorType}'),
            const SizedBox(height: 12),
            Text('Stocks: ${result.stockAmount.toStringAsFixed(2)} ETB'),
            Text('Bonds: ${result.bondAmount.toStringAsFixed(2)} ETB'),
            Text('Cash: ${result.cashAmount.toStringAsFixed(2)} ETB'),
            const Spacer(),
            ElevatedButton(
              onPressed: () {
                Navigator.pushNamed(context, '/result');
              },
              child: const Text('Next: Result'),
            ),
          ],
        ),
      ),
    );
  }
}
