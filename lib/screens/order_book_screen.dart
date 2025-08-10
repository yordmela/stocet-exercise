// screens/order_book_screen.dart
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:stocet/screens/new_order_screen.dart';
import '../providers/order_book.dart';
import '../widgets/order_tile.dart';
import '../models/order.dart';
import 'package:intl/intl.dart';

class OrderBookScreen extends StatelessWidget {
  const OrderBookScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Consumer<OrderBookProvider>(
      builder: (context, ob, _) {
        final bestBid = ob.bids.isNotEmpty ? ob.bids.first : null;
        final bestAsk = ob.asks.isNotEmpty ? ob.asks.first : null;
        return Scaffold(
          appBar: AppBar(
            title: const Text('Order Book'),
            actions: [
              IconButton(onPressed: () => ob.clear(), icon: const Icon(Icons.clear_all)),
            ],
          ),
          body: Column(
            children: [
              // Top summary row
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 12.0, vertical: 8),
                child: Row(
                  children: [
                    Flexible(child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
                      const Text('Best Bid', style: TextStyle(fontWeight: FontWeight.bold)),
                      if (bestBid != null) Text('${bestBid.price?.toStringAsFixed(2) ?? '-'} • Q: ${bestBid.quantity.toStringAsFixed(2)}') else const Text('-'),
                    ])),
                    Flexible(child: Column(crossAxisAlignment: CrossAxisAlignment.end, children: [
                      const Text('Best Ask', style: TextStyle(fontWeight: FontWeight.bold)),
                      if (bestAsk != null) Text('${bestAsk.price?.toStringAsFixed(2) ?? '-'} • Q: ${bestAsk.quantity.toStringAsFixed(2)}') else const Text('-'),
                    ])),
                  ],
                ),
              ),
              const Divider(),
              Expanded(
                child: Row(
                  children: [
                    // Bids
                    Expanded(
                      child: Column(
                        children: [
                          const Padding(
                            padding: EdgeInsets.all(8.0),
                            child: Text('BIDS', style: TextStyle(fontWeight: FontWeight.bold)),
                          ),
                          Expanded(
                            child: ListView.builder(
                              itemCount: ob.bids.length,
                              itemBuilder: (context, i) {
                                final o = ob.bids[i];
                                final highlight = (i == 0);
                                return OrderTile(order: o, highlight: highlight);
                              },
                            ),
                          ),
                        ],
                      ),
                    ),
                    const VerticalDivider(),
                    // Asks
                    Expanded(
                      child: Column(
                        children: [
                          const Padding(
                            padding: EdgeInsets.all(8.0),
                            child: Text('ASKS', style: TextStyle(fontWeight: FontWeight.bold)),
                          ),
                          Expanded(
                            child: ListView.builder(
                              itemCount: ob.asks.length,
                              itemBuilder: (context, i) {
                                final o = ob.asks[i];
                                final highlight = (i == 0);
                                return OrderTile(order: o, highlight: highlight);
                              },
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
              const Divider(),
              // Trades / pending stops
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
                child: Row(
                  children: [
                    Expanded(child: Text('Recent Trades', style: TextStyle(fontWeight: FontWeight.bold))),
                    Expanded(child: Text('Pending Stops', style: TextStyle(fontWeight: FontWeight.bold))),
                  ],
                ),
              ),
              SizedBox(
                height: 140,
                child: Row(
                  children: [
                    // trades
                    Expanded(
                      child: ListView.builder(
                        itemCount: ob.trades.length,
                        itemBuilder: (context, i) {
                          final t = ob.trades.elementAt(i);
                          final df = DateFormat('HH:mm:ss');
                          return ListTile(
                            dense: true,
                            title: Text('${t.quantity.toStringAsFixed(2)} @ ${t.price.toStringAsFixed(2)}'),
                            subtitle: Text('${df.format(t.timestamp)}'),
                          );
                        },
                      ),
                    ),
                    const VerticalDivider(),
                    // pending stops
                    Expanded(
                      child: ListView.builder(
                        itemCount: ob.pendingStops.length,
                        itemBuilder: (context, i) {
                          final s = ob.pendingStops[i];
                          return ListTile(
                            dense: true,
                            title: Text('${s.side == OrderSide.buy ? 'Buy Stop' : 'Sell Stop'} • Q:${s.quantity}'),
                            subtitle: Text('Trigger: ${s.price}'),
                          );
                        },
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
          floatingActionButton: FloatingActionButton.extended(
            onPressed: () => Navigator.push(context, MaterialPageRoute(builder: (_) => const NewOrderScreen())),
            label: const Text('New Order'),
            icon: const Icon(Icons.add),
          ),
          floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
        );
      },
    );
  }
}
