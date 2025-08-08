import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../providers/cmsp_provider.dart';
import 'cmsp_list_screen.dart';

class HomeScreen extends ConsumerWidget {
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final types = ['All', 'Investment Bank', 'Broker'];

    return DefaultTabController(
      length: types.length,
      child: Scaffold(
        appBar: AppBar(
          title: Text("CMSP Explorer"),
          bottom: TabBar(
            isScrollable: true,
            onTap: (index) {
              ref.read(selectedTypeProvider.notifier).state =
                  types[index] == 'All' ? null : types[index];
            },
            tabs: types.map((t) => Tab(text: t)).toList(),
          ),
        ),
        body: CMSPListScreen(),
      ),
    );
  }
}
