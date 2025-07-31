class Stock {
  final String symbol;
  final String name;
  final double price;
  final double changePercent;
  final String imagePath;

  Stock({
    required this.symbol,
    required this.name,
    required this.price,
    required this.changePercent,
    required this.imagePath,
  });

  factory Stock.fromJson(Map<String, dynamic> json) {
    return Stock(
      symbol: json['symbol'],
      name: json['name'],
      price: (json['price'] as num).toDouble(),
      changePercent: (json['changePercent'] as num).toDouble(),
      imagePath: json['imagePath'],
    );
  }
}
