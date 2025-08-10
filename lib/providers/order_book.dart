// providers/order_book.dart
import 'dart:collection';
import 'package:flutter/material.dart';
import 'package:uuid/uuid.dart';
import '../models/order.dart';

final _uuid = Uuid();

class OrderBookProvider extends ChangeNotifier {
  final List<Order> _bids = []; // buy limit orders
  final List<Order> _asks = []; // sell limit orders
  final List<Order> _pendingStops = []; // stop orders
  final List<Trade> _trades = []; // executed trades (recent)

  UnmodifiableListView<Order> get bids => UnmodifiableListView(_bids);
  UnmodifiableListView<Order> get asks => UnmodifiableListView(_asks);
  UnmodifiableListView<Order> get pendingStops => UnmodifiableListView(_pendingStops);
  UnmodifiableListView<Trade> get trades => UnmodifiableListView(_trades.reversed.toList());

  /// Add order via New Order screen.
  void submit({
    required OrderSide side,
    required OrderType type,
    required double quantity,
    double? price,
    double? stopPrice,
  }) {
    if (quantity <= 0) return;

    final id = _uuid.v4();
    if (type == OrderType.stop) {
      // store stop with stopPrice in price field for simplicity
      final stopOrder = Order(id: id, side: side, type: type, quantity: quantity, price: stopPrice);
      _pendingStops.add(stopOrder);
      notifyListeners();
      return;
    }

    if (type == OrderType.market) {
      final order = Order(id: id, side: side, type: type, quantity: quantity);
      _processMarketOrder(order);
      notifyListeners();
      return;
    }

    // limit order
    final order = Order(id: id, side: side, type: type, quantity: quantity, price: price);
    _addLimitOrder(order);
    _match(); // attempt matching after inserting
    _checkStopsAfterTrade(); // in case matches triggered stops
    notifyListeners();
  }

  void _addLimitOrder(Order order) {
    if (order.side == OrderSide.buy) {
      _bids.add(order);
      // sort bids descending price, then older first
      _bids.sort((a, b) {
        final p = (b.price ?? 0).compareTo(a.price ?? 0); // higher first
        if (p != 0) return p;
        return a.timestamp.compareTo(b.timestamp); // older first
      });
    } else {
      _asks.add(order);
      _asks.sort((a, b) {
        final p = (a.price ?? 0).compareTo(b.price ?? 0); // lower first
        if (p != 0) return p;
        return a.timestamp.compareTo(b.timestamp);
      });
    }
  }

  void _processMarketOrder(Order marketOrder) {
    if (marketOrder.side == OrderSide.buy) {
      // match against asks (best first)
      double remaining = marketOrder.quantity;
      while (remaining > 0 && _asks.isNotEmpty) {
        final bestAsk = _asks.first;
        final tradeQty = remaining <= bestAsk.quantity ? remaining : bestAsk.quantity;
        final tradePrice = bestAsk.price ?? 0;
        _executeTrade(
          buyOrderId: marketOrder.id,
          sellOrderId: bestAsk.id,
          quantity: tradeQty,
          price: tradePrice,
        );
        remaining -= tradeQty;
        bestAsk.quantity -= tradeQty;
        if (bestAsk.quantity <= 0) _asks.removeAt(0);
      }
      // market order unmatched quantity is cancelled (nothing to add)
    } else {
      // sell market -> match against bids
      double remaining = marketOrder.quantity;
      while (remaining > 0 && _bids.isNotEmpty) {
        final bestBid = _bids.first;
        final tradeQty = remaining <= bestBid.quantity ? remaining : bestBid.quantity;
        final tradePrice = bestBid.price ?? 0;
        _executeTrade(
          buyOrderId: bestBid.id,
          sellOrderId: marketOrder.id,
          quantity: tradeQty,
          price: tradePrice,
        );
        remaining -= tradeQty;
        bestBid.quantity -= tradeQty;
        if (bestBid.quantity <= 0) _bids.removeAt(0);
      }
    }
    // after market matching, re-check stops
    _checkStopsAfterTrade();
  }

  void _match() {
    // While top bid price >= top ask price => execute trades
    bool matched = false;
    while (_bids.isNotEmpty && _asks.isNotEmpty) {
      final topBid = _bids.first;
      final topAsk = _asks.first;
      final bidPrice = topBid.price ?? double.negativeInfinity;
      final askPrice = topAsk.price ?? double.infinity;

      if (bidPrice >= askPrice) {
        matched = true;
        final tradeQty = (topBid.quantity <= topAsk.quantity) ? topBid.quantity : topAsk.quantity;
        final tradePrice = (topBid.timestamp.isBefore(topAsk.timestamp)) ? topAsk.price! : topAsk.price!; // trade at ask price
        _executeTrade(
          buyOrderId: topBid.id,
          sellOrderId: topAsk.id,
          quantity: tradeQty,
          price: tradePrice,
        );

        topBid.quantity -= tradeQty;
        topAsk.quantity -= tradeQty;
        if (topBid.quantity <= 0) _bids.removeAt(0);
        if (topAsk.quantity <= 0) _asks.removeAt(0);

        // continue loop to match more
      } else {
        break;
      }
    }
    if (matched) {
      _checkStopsAfterTrade();
    }
  }

  void _executeTrade({
    required String buyOrderId,
    required String sellOrderId,
    required double quantity,
    required double price,
  }) {
    final trade = Trade(
      buyOrderId: buyOrderId,
      sellOrderId: sellOrderId,
      quantity: quantity,
      price: price,
    );
    _trades.add(trade);
    if (_trades.length > 50) _trades.removeAt(0);
    notifyListeners();
  }

  void _checkStopsAfterTrade() {
    // If last trade price meets or exceeds stop conditions, trigger stops
    if (_trades.isEmpty) return;
    final lastPrice = _trades.last.price;

    // We will trigger stop orders if:
    // - For buy stop orders: trigger when market price >= stopPrice (price stored in order.price)
    // - For sell stop orders: trigger when market price <= stopPrice
    final triggered = <Order>[];
    for (final stop in List<Order>.from(_pendingStops)) {
      final stopPrice = stop.price;
      if (stopPrice == null) continue;
      if (stop.side == OrderSide.buy && lastPrice >= stopPrice) {
        triggered.add(stop);
      } else if (stop.side == OrderSide.sell && lastPrice <= stopPrice) {
        triggered.add(stop);
      }
    }

    for (final s in triggered) {
      _pendingStops.remove(s);
      // convert stop to market order on trigger
      final marketOrder = Order(
        id: s.id,
        side: s.side,
        type: OrderType.market,
        quantity: s.quantity,
      );
      _processMarketOrder(marketOrder);
    }
    if (triggered.isNotEmpty) notifyListeners();
  }

  void clear() {
    _bids.clear();
    _asks.clear();
    _pendingStops.clear();
    _trades.clear();
    notifyListeners();
  }
}
