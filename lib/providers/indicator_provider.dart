import 'dart:convert';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final indicatorsDataProvider = FutureProvider<Map<String, dynamic>>((ref) async {
  final raw = await rootBundle.loadString('assets/data/indicators.json');
  final json = jsonDecode(raw) as Map<String, dynamic>;
  return json;
});

final selectedIndicatorsProvider = StateProvider<List<String>>((ref) => []);
