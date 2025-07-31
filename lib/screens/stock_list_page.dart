import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart' show rootBundle;
import '../models/stock.dart';

class StockListPage extends StatefulWidget {
  const StockListPage({Key? key}) : super(key: key);

  @override
  State<StockListPage> createState() => _StockListPageState();
}

class _StockListPageState extends State<StockListPage> {
  List<Stock> stocks = [];
  String sortBy = "price";

  @override
  void initState() {
    super.initState();
    loadStocks();
  }

  Future<void> loadStocks() async {
    final jsonString = await rootBundle.loadString('assets/mock_stocks.json');
    final List<dynamic> jsonList = json.decode(jsonString);
    final loadedStocks = jsonList.map((json) => Stock.fromJson(json)).toList();
    setState(() {
      stocks = loadedStocks;
      sortStocks();
    });
  }

  void sortStocks() {
    setState(() {
      if (sortBy == "price") {
        stocks.sort((a, b) => b.price.compareTo(a.price));
      } else {
        stocks.sort((a, b) => b.changePercent.compareTo(a.changePercent));
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Mobile Stock Viewer'),
        actions: [
          PopupMenuButton<String>(
            onSelected: (value) {
              sortBy = value;
              sortStocks();
            },
            itemBuilder: (context) => [
              const PopupMenuItem(value: "price", child: Text("Sort by Price")),
              const PopupMenuItem(value: "change", child: Text("Sort by Change %")),
            ],
          )
        ],
      ),
      body: stocks.isEmpty
          ? const Center(child: CircularProgressIndicator())
          : ListView.builder(
              itemCount: stocks.length,
              itemBuilder: (context, index) {
                final stock = stocks[index];
                return Card(
                  margin: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
                  elevation: 3,
                  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
                  child: ListTile(
                    contentPadding: const EdgeInsets.all(12),
                    leading: ClipRRect(
                      borderRadius: BorderRadius.circular(6),
                      child: Image.asset(
                        stock.imagePath,
                        width: 50,
                        height: 50,
                        fit: BoxFit.cover,
                      ),
                    ),
                    title: Text(stock.name, style: const TextStyle(fontWeight: FontWeight.bold)),
                    subtitle: Text(stock.symbol),
                    trailing: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.end,
                      children: [
                        Text("\$${stock.price.toStringAsFixed(2)}"),
                        Text(
                          "${stock.changePercent > 0 ? '+' : ''}${stock.changePercent.toStringAsFixed(2)}%",
                          style: TextStyle(
                            color: stock.changePercent >= 0 ? Colors.green : Colors.red,
                          ),
                        )
                      ],
                    ),
                  ),
                );
              },
            ),
    );
  }
}
