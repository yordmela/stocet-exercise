// widgets/order_tile.dart
import 'package:flutter/material.dart';
import '../models/order.dart';
import 'package:intl/intl.dart';

class OrderTile extends StatelessWidget {
  final Order order;
  final bool highlight;

  const OrderTile({required this.order, this.highlight = false, super.key});

  @override
  Widget build(BuildContext context) {
    final df = DateFormat('HH:mm:ss');
    final priceText = order.price != null ? order.price!.toStringAsFixed(2) : '-';
    return Card(
      color: highlight ? Colors.yellow[100] : null,
      margin: const EdgeInsets.symmetric(vertical: 4, horizontal: 8),
      child: ListTile(
        dense: true,
        title: Row(
          children: [
            Text(order.side == OrderSide.buy ? 'BUY' : 'SELL', style: TextStyle(fontWeight: FontWeight.bold, color: order.side == OrderSide.buy ? Colors.green[700] : Colors.red[700])),
            const SizedBox(width: 12),
            Text('Q: ${order.quantity.toStringAsFixed(2)}'),
            const SizedBox(width: 12),
            Text('@ $priceText'),
          ],
        ),
        subtitle: Text('id: ${order.id.substring(0, 8)} • ${df.format(order.timestamp)}'),
      ),
    );
  }
}
