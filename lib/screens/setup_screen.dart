import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../models/investment_input.dart';
import '../providers/investment_provider.dart';

class SetupScreen extends ConsumerStatefulWidget {
  const SetupScreen({super.key});

  @override
  ConsumerState<SetupScreen> createState() => _SetupScreenState();
}

class _SetupScreenState extends ConsumerState<SetupScreen> {
  final _capitalController = TextEditingController();
  final _goalController = TextEditingController();
  String _investorType = 'Active';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Investment Setup')),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          children: [
            TextField(
              controller: _capitalController,
              keyboardType: TextInputType.number,
              decoration: const InputDecoration(labelText: 'Initial Capital (ETB)'),
            ),
            const SizedBox(height: 12),
            TextField(
              controller: _goalController,
              keyboardType: TextInputType.number,
              decoration: const InputDecoration(labelText: 'Goal (ETB)'),
            ),
            const SizedBox(height: 12),
            DropdownButton<String>(
              value: _investorType,
              items: const [
                DropdownMenuItem(value: 'Active', child: Text('Active')),
                DropdownMenuItem(value: 'Passive', child: Text('Passive')),
              ],
              onChanged: (value) {
                setState(() {
                  _investorType = value!;
                });
              },
            ),
            const Spacer(),
            ElevatedButton(
              onPressed: () {
                final capital = double.tryParse(_capitalController.text);
                final goal = _goalController.text;

                if (capital != null && goal.isNotEmpty) {
                  ref.read(investmentInputProvider.notifier).state = InvestmentInput(
                    capital: capital,
                    goal: goal,
                    investorType: _investorType,
                  );
                  Navigator.pushNamed(context, '/allocation');
                }
              },
              child: const Text('Next: Allocation'),
            )
          ],
        ),
      ),
    );
  }
}
