import 'dart:convert';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../models/cmsp.dart';

final cmspsProvider = FutureProvider<List<CMSP>>((ref) async {
  final data = await rootBundle.loadString('assets/data/cmsps.json');
  final jsonList = json.decode(data) as List;
  return jsonList.map((e) => CMSP.fromJson(e)).toList();
});

final selectedTypeProvider = StateProvider<String?>((ref) => null);

final filteredCMSPsProvider = Provider<List<CMSP>>((ref) {
  final cmspsAsync = ref.watch(cmspsProvider);
  final selectedType = ref.watch(selectedTypeProvider);

  return cmspsAsync.when(
    data: (cmsps) => selectedType == null
        ? cmsps
        : cmsps.where((c) => c.type == selectedType).toList(),
    loading: () => [],
    error: (_, __) => [],
  );
});
