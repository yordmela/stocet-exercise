import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../providers/cmsp_provider.dart';
import '../widgets/cmsp_card.dart';

class CMSPListScreen extends ConsumerWidget {
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final cmsps = ref.watch(filteredCMSPsProvider);

    return ListView.builder(
      itemCount: cmsps.length,
      itemBuilder: (context, index) {
        return CMSPCard(cmsp: cmsps[index]);
      },
    );
  }
}
