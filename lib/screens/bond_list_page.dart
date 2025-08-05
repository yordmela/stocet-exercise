// bond_list_page.dart
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class Bond {
  final String name;
  final double coupon;
  final DateTime maturity;
  final double price;
  final Color color;

  Bond({
    required this.name,
    required this.coupon,
    required this.maturity,
    required this.price,
    required this.color,
  });
}

class BondListPage extends StatefulWidget {
  const BondListPage({super.key});

  @override
  State<BondListPage> createState() => _BondListPageState();
}

class _BondListPageState extends State<BondListPage> {
  // Mock bond data
 final List<Bond> allBonds = [
  // Government Bonds
  Bond(
    name: "US Treasury 2Y",
    coupon: 2.1,
    maturity: DateTime(2025, 8, 15),
    price: 99.20,
    color: Colors.blue.shade100,
  ),
  Bond(
    name: "US Treasury 10Y",
    coupon: 3.4,
    maturity: DateTime(2033, 11, 15),
    price: 97.85,
    color: Colors.blue.shade200,
  ),
  Bond(
    name: "UK Gilt 5Y",
    coupon: 1.8,
    maturity: DateTime(2028, 9, 7),
    price: 101.30,
    color: Colors.red.shade100,
  ),
  Bond(
    name: "German Bund 7Y",
    coupon: 0.9,
    maturity: DateTime(2030, 4, 22),
    price: 102.10,
    color: Colors.yellow.shade100,
  ),
  
  // Corporate Bonds
  Bond(
    name: "Apple Inc. AAA",
    coupon: 3.2,
    maturity: DateTime(2029, 5, 1),
    price: 104.25,
    color: Colors.grey.shade200,
  ),
  Bond(
    name: "Microsoft Corp",
    coupon: 2.9,
    maturity: DateTime(2031, 2, 15),
    price: 103.75,
    color: Colors.blueGrey.shade200,
  ),
  Bond(
    name: "Amazon 4.05% 2035",
    coupon: 4.05,
    maturity: DateTime(2035, 6, 3),
    price: 98.60,
    color: Colors.orange.shade100,
  ),
  Bond(
    name: "Tesla Convertible",
    coupon: 0.25,
    maturity: DateTime(2027, 3, 15),
    price: 112.40,
    color: Colors.red.shade300,
  ),
  
  // Municipal Bonds
  Bond(
    name: "NYC Muni Bond",
    coupon: 2.3,
    maturity: DateTime(2026, 4, 1),
    price: 100.50,
    color: Colors.blue.shade300,
  ),
  Bond(
    name: "California GO Bond",
    coupon: 2.7,
    maturity: DateTime(2034, 11, 1),
    price: 99.90,
    color: Colors.green.shade300,
  ),
  
  // High Yield/Junk Bonds
  Bond(
    name: "Ford Motor Co",
    coupon: 5.6,
    maturity: DateTime(2030, 8, 1),
    price: 92.75,
    color: Colors.blue.shade400,
  ),
  Bond(
    name: "Delta Airlines",
    coupon: 4.8,
    maturity: DateTime(2029, 7, 15),
    price: 89.25,
    color: Colors.red.shade400,
  ),
  
  // Special Types
  Bond(
    name: "Perpetual Bond",
    coupon: 4.25,
    maturity: DateTime(2100, 1, 1),
    price: 105.00,
    color: Colors.purple.shade300,
  ),
  Bond(
    name: "Inflation-Linked TIPS",
    coupon: 0.3,
    maturity: DateTime(2042, 1, 15),
    price: 101.80,
    color: Colors.teal.shade300,
  ),
  Bond(
    name: "Catastrophe Bond",
    coupon: 8.2,
    maturity: DateTime(2027, 12, 31),
    price: 97.40,
    color: Colors.orange.shade400,
  ),
  
  // Emerging Markets
  Bond(
    name: "Brazil Gov 10Y",
    coupon: 6.7,
    maturity: DateTime(2032, 4, 15),
    price: 94.20,
    color: Colors.green.shade400,
  ),
  Bond(
    name: "India Infra Bond",
    coupon: 5.4,
    maturity: DateTime(2035, 3, 10),
    price: 96.80,
    color: Colors.orange.shade300,
  ),
  
  // Financial Sector
  Bond(
    name: "JPMorgan Subordinated",
    coupon: 4.35,
    maturity: DateTime(2033, 9, 20),
    price: 100.25,
    color: Colors.blue.shade500,
  ),
  Bond(
    name: "Goldman Sachs AT1",
    coupon: 5.1,
    maturity: DateTime(2040, 7, 1),
    price: 98.90,
    color: Colors.purple.shade200,
  ),
  
  // Green Bonds
  Bond(
    name: "EU Green Bond",
    coupon: 1.2,
    maturity: DateTime(2035, 5, 15),
    price: 102.60,
    color: Colors.green.shade500,
  ),
  Bond(
    name: "Solar Energy Project",
    coupon: 3.8,
    maturity: DateTime(2032, 12, 31),
    price: 99.40,
    color: Colors.yellow.shade600,
  ),
];
  // Filter variables
  double minCoupon = 0.0;
  double maxCoupon = 10.0;
  String maturityYear = "";
  
  // Get filtered bonds
  List<Bond> get filteredBonds {
    return allBonds.where((bond) {
      final couponMatch = bond.coupon >= minCoupon && bond.coupon <= maxCoupon;
      final yearMatch = maturityYear.isEmpty || 
          DateFormat('y').format(bond.maturity) == maturityYear;
      return couponMatch && yearMatch;
    }).toList();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Bond Listings'),
        centerTitle: true,
        backgroundColor: Colors.blueGrey[800],
      ),
      body: Column(
        children: [
          // Filter Section
          _buildFilterCard(),
          
          // Results count
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  '${filteredBonds.length} bonds found',
                  style: const TextStyle(
                    fontWeight: FontWeight.bold,
                    color: Colors.blueGrey,
                  ),
                ),
                TextButton(
                  onPressed: () {
                    setState(() {
                      minCoupon = 0.0;
                      maxCoupon = 10.0;
                      maturityYear = "";
                    });
                  },
                  child: const Text('Reset Filters'),
                ),
              ],
            ),
          ),
          
          // Bond List
          Expanded(
            child: ListView.builder(
              itemCount: filteredBonds.length,
              itemBuilder: (context, index) {
                final bond = filteredBonds[index];
                return _buildBondCard(bond);
              },
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildFilterCard() {
    return Card(
      margin: const EdgeInsets.all(16),
      elevation: 4,
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              'Filter Bonds',
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 16),
            
            // Coupon Range Slider
            const Text('Coupon Range:'),
            RangeSlider(
              values: RangeValues(minCoupon, maxCoupon),
              min: 0,
              max: 10,
              divisions: 20,
              labels: RangeLabels(
                '${minCoupon.toStringAsFixed(1)}%',
                '${maxCoupon.toStringAsFixed(1)}%',
              ),
              onChanged: (values) {
                setState(() {
                  minCoupon = values.start;
                  maxCoupon = values.end;
                });
              },
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text('Min: ${minCoupon.toStringAsFixed(1)}%'),
                Text('Max: ${maxCoupon.toStringAsFixed(1)}%'),
              ],
            ),
            
            const SizedBox(height: 20),
            
            // Maturity Year Filter
            const Text('Maturity Year:'),
            TextField(
              decoration: const InputDecoration(
                hintText: 'Enter year (e.g. 2025)',
                border: OutlineInputBorder(),
                contentPadding: EdgeInsets.symmetric(horizontal: 12),
              ),
              keyboardType: TextInputType.number,
              onChanged: (value) {
                setState(() {
                  maturityYear = value;
                });
              },
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildBondCard(Bond bond) {
    return Card(
      margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      elevation: 2,
      color: bond.color.withOpacity(0.2),
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Expanded(
                  child: Text(
                    bond.name,
                    style: const TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
                Container(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 12,
                    vertical: 6,
                  ),
                  decoration: BoxDecoration(
                    color: bond.coupon > 4
                        ? Colors.green.shade100
                        : bond.coupon > 2
                            ? Colors.amber.shade100
                            : Colors.red.shade100,
                    borderRadius: BorderRadius.circular(20),
                  ),
                  child: Text(
                    '${bond.coupon.toStringAsFixed(1)}%',
                    style: TextStyle(
                      color: bond.coupon > 4
                          ? Colors.green.shade800
                          : bond.coupon > 2
                              ? Colors.amber.shade800
                              : Colors.red.shade800,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 10),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text(
                      'Maturity',
                      style: TextStyle(color: Colors.grey),
                    ),
                    Text(
                      DateFormat('MMM dd, yyyy').format(bond.maturity),
                      style: const TextStyle(fontWeight: FontWeight.bold),
                    ),
                  ],
                ),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: [
                    const Text(
                      'Price',
                      style: TextStyle(color: Colors.grey),
                    ),
                    Text(
                      '\$${bond.price.toStringAsFixed(2)}',
                      style: const TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 16,
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}