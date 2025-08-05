// lib/data/bonds.dart
class Bond {
  final String name;
  final double coupon;
  final DateTime maturity;
  final double price;

  Bond({required this.name, required this.coupon, required this.maturity, required this.price});
}

List<Bond> bondData = [
  Bond(name: "Bond A", coupon: 5.0, maturity: DateTime(2025, 12, 31), price: 1000),
  Bond(name: "Bond B", coupon: 3.5, maturity: DateTime(2027, 6, 30), price: 950),
  // Add more bonds as needed
];
