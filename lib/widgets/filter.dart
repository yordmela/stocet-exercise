// lib/widgets/filter.dart
import 'package:flutter/material.dart';

class Filter extends StatelessWidget {
  final double minCoupon;
  final double maxCoupon;
  final int maturityYear;
  final Function(double, double, int) onFilterChanged;

  Filter({
    required this.minCoupon,
    required this.maxCoupon,
    required this.maturityYear,
    required this.onFilterChanged,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Text('Coupon Range: $minCoupon - $maxCoupon'),
        RangeSlider(
          min: 0,
          max: 10,
          divisions: 100,
          values: RangeValues(minCoupon, maxCoupon),
          onChanged: (values) {
            onFilterChanged(values.start, values.end, maturityYear);
          },
        ),
        Text('Maturity Year: $maturityYear'),
        DropdownButton<int>(
          value: maturityYear,
          items: List.generate(10, (index) {
            int year = DateTime.now().year + index;
            return DropdownMenuItem<int>(
              value: year,
              child: Text(year.toString()),
            );
          }),
          onChanged: (value) {
            if (value != null) {
              onFilterChanged(minCoupon, maxCoupon, value);
            }
          },
        ),
      ],
    );
  }
}
