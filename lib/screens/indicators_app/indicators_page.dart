import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../providers/indicator_provider.dart';

class IndicatorsPage extends ConsumerWidget {
  const IndicatorsPage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final dataAsync = ref.watch(indicatorsDataProvider);

    return dataAsync.when(
      loading: () => const Scaffold(body: Center(child: CircularProgressIndicator())),
      error: (e, s) => Scaffold(body: Center(child: Text('Error loading data: $e'))),
      data: (json) {
        final indicators = (json['indicators'] as List).cast<Map<String, dynamic>>();
        final allIds = indicators.map((i) => i['id'] as String).toList();
        final selected = ref.watch(selectedIndicatorsProvider);

        return Scaffold(
          appBar: AppBar(title: const Text('Economic Indicators')),
          body: Padding(
            padding: const EdgeInsets.all(12.0),
            child: Column(
              children: [
                // Selector: multi-select chips up to 5
                Wrap(
                  spacing: 8,
                  children: allIds.map((id) {
                    final title = indicators.firstWhere((it) => it['id'] == id)['title'];
                    final chosen = selected.contains(id);
                    return FilterChip(
                      label: Text(title, overflow: TextOverflow.ellipsis),
                      selected: chosen,
                      onSelected: (v) {
                        final list = List<String>.from(ref.read(selectedIndicatorsProvider));
                        if (v) {
                          if (list.length >= 5) {
                            ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text('You can select up to 5 indicators')));
                            return;
                          }
                          list.add(id);
                        } else {
                          list.remove(id);
                        }
                        ref.read(selectedIndicatorsProvider.notifier).state = list;
                      },
                    );
                  }).toList(),
                ),
                const SizedBox(height: 12),
                if (selected.isEmpty)
                  const Expanded(child: Center(child: Text('Select up to 5 indicators to view charts')))
                else
                  Expanded(
                    child: PageView(
                      children: selected.map((id) {
                        final it = indicators.firstWhere((x) => x['id'] == id);
                        return IndicatorCard(indicator: it);
                      }).toList(),
                    ),
                  ),
              ],
            ),
          ),
        );
      },
    );
  }
}

class IndicatorCard extends StatelessWidget {
  final Map<String, dynamic> indicator;
  const IndicatorCard({required this.indicator, super.key});

  @override
  Widget build(BuildContext context) {
    final years = (indicator['years'] as List).cast<int>();
    final values = (indicator['values'] as List).map((e) => (e as num).toDouble()).toList();

    // Build line chart data
    final spots = List.generate(values.length, (i) => FlSpot(i.toDouble(), values[i]));

    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Card(
        elevation: 4,
        child: Column(
          children: [
            ListTile(
              title: Text(indicator['title']),
              subtitle: Text(indicator['definition']),
            ),
            Expanded(
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 8.0),
                child: LineChart(
                  LineChartData(
                    gridData: FlGridData(show: true),
                    titlesData: FlTitlesData(
                      leftTitles: AxisTitles(sideTitles: SideTitles(showTitles: true)),
                      bottomTitles: AxisTitles(
                        sideTitles: SideTitles(
                          showTitles: true,
                          getTitlesWidget: (v, meta) {
                            final idx = v.toInt();
                            if (idx < 0 || idx >= years.length) return const Text('');
                            return Text('${years[idx]}');
                          },
                        ),
                      ),
                    ),
                    lineBarsData: [
                      LineChartBarData(
                        spots: spots,
                        isCurved: true,
                        dotData: FlDotData(show: true),
                        barWidth: 3,
                      ),
                    ],
                  ),
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(12.0),
              child: Row(
                children: [
                  Text('Unit: ${indicator['unit']}'),
                  const Spacer(),
                  Text('Data source: NBE', style: const TextStyle(fontStyle: FontStyle.italic)),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
