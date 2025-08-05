// lib/widgets/bond_card.dart
import 'package:flutter/material.dart';
import 'package:stocet/models/bond.dart';

class BondCard extends StatelessWidget {
  final Bond bond;

  BondCard({required this.bond});

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: EdgeInsets.all(8.0),
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text('Name: ${bond.name}', style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
            Text('Coupon: ${bond.coupon}%', style: TextStyle(fontSize: 16)),
            Text('Maturity: ${bond.maturity.toLocal().toString().split(' ')[0]}', style: TextStyle(fontSize: 16)),
            Text('Price: \$${bond.price}', style: TextStyle(fontSize: 16)),
          ],
        ),
      ),
    );
  }
}
