// lib/widgets/bond_list.dart
import 'package:flutter/material.dart';
import 'package:stocet/models/bond.dart';
import 'package:stocet/widgets/bond_card.dart';

class BondList extends StatelessWidget {
  final List<Bond> bonds;

  BondList({required this.bonds});

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemCount: bonds.length,
      itemBuilder: (context, index) {
        return BondCard(bond: bonds[index]);
      },
    );
  }
}
