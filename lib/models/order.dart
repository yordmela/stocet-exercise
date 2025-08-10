// models/order.dart
import 'package:flutter/foundation.dart';

enum OrderType { limit, market, stop }
enum OrderSide { buy, sell }

class Order {
  final String id;
  final OrderSide side;
  final OrderType type;
  double quantity;
  double? price; // nullable for market orders / stop orders reference price
  final DateTime timestamp;
  bool triggered; // for stop orders: once triggered they become market/limit

  Order({
    required this.id,
    required this.side,
    required this.type,
    required this.quantity,
    this.price,
    DateTime? timestamp,
    this.triggered = false,
  }) : timestamp = timestamp ?? DateTime.now();

  Order copyWith({
    double? quantity,
    double? price,
    bool? triggered,
  }) {
    return Order(
      id: id,
      side: side,
      type: type,
      quantity: quantity ?? this.quantity,
      price: price ?? this.price,
      timestamp: timestamp,
      triggered: triggered ?? this.triggered,
    );
  }
}

class Trade {
  final String buyOrderId;
  final String sellOrderId;
  final double quantity;
  final double price;
  final DateTime timestamp;

  Trade({
    required this.buyOrderId,
    required this.sellOrderId,
    required this.quantity,
    required this.price,
    DateTime? timestamp,
  }) : timestamp = timestamp ?? DateTime.now();
}
