import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../providers/indicator_provider.dart';

class AboutPage extends ConsumerWidget {
  const AboutPage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final dataAsync = ref.watch(indicatorsDataProvider);
    return dataAsync.when(
      loading: () => const Center(child: CircularProgressIndicator()),
      error: (e, s) => Center(child: Text('Error: $e')),
      data: (json) {
        return Scaffold(
          appBar: AppBar(title: const Text('About')),
          body: Padding(
            padding: const EdgeInsets.all(16),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text('Economic Indicators App', style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
                const SizedBox(height: 8),
                const Text('This app shows selected economic indicators (2019–2024) derived from NBE publications.'),
                const SizedBox(height: 8),
                Text('Source: ${json['meta']['source']}'),
                const SizedBox(height: 8),
                Text('Note: Please verify numbers with the NBE annual/quarterly reports for full accuracy.'),
              ],
            ),
          ),
        );
      },
    );
  }
}
