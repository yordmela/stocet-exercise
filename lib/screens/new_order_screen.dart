// screens/new_order_screen.dart
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../providers/order_book.dart';
import '../models/order.dart';
import 'package:intl/intl.dart';

class NewOrderScreen extends StatefulWidget {
  const NewOrderScreen({super.key});

  @override
  State<NewOrderScreen> createState() => _NewOrderScreenState();
}

class _NewOrderScreenState extends State<NewOrderScreen> {
  final _formKey = GlobalKey<FormState>();
  OrderType _type = OrderType.limit;
  OrderSide _side = OrderSide.buy;
  final _qtyC = TextEditingController();
  final _priceC = TextEditingController();
  final _stopC = TextEditingController();

  @override
  void dispose() {
    _qtyC.dispose();
    _priceC.dispose();
    _stopC.dispose();
    super.dispose();
  }

  void _submit() {
    if (!_formKey.currentState!.validate()) return;
    final provider = Provider.of<OrderBookProvider>(context, listen: false);

    final qty = double.tryParse(_qtyC.text) ?? 0;
    if (qty <= 0) return;

    if (_type == OrderType.limit) {
      final price = double.tryParse(_priceC.text);
      if (price == null) {
        ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text('Limit order requires price')));
        return;
      }
      provider.submit(side: _side, type: _type, quantity: qty, price: price);
    } else if (_type == OrderType.market) {
      provider.submit(side: _side, type: _type, quantity: qty);
    } else if (_type == OrderType.stop) {
      final stopPrice = double.tryParse(_stopC.text);
      if (stopPrice == null) {
        ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text('Stop order requires stop price')));
        return;
      }
      provider.submit(side: _side, type: _type, quantity: qty, stopPrice: stopPrice);
    }

    // clear
    _qtyC.clear();
    _priceC.clear();
    _stopC.clear();

    // show quick confirmation
    ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text('Order submitted')));
  }

  @override
  Widget build(BuildContext context) {
    final df = DateFormat.Hm();
    return Scaffold(
      appBar: AppBar(title: const Text('New Order')),
      body: Padding(
        padding: const EdgeInsets.all(12.0),
        child: Form(
          key: _formKey,
          child: Column(
            children: [
              ToggleButtons(
                isSelected: [ _type == OrderType.limit, _type == OrderType.market, _type == OrderType.stop ],
                onPressed: (i) => setState(() {
                  _type = OrderType.values[i];
                }),
                children: const [ Padding(padding: EdgeInsets.all(8), child: Text('Limit')), Padding(padding: EdgeInsets.all(8), child: Text('Market')), Padding(padding: EdgeInsets.all(8), child: Text('Stop')) ],
              ),
              const SizedBox(height: 12),
              Row(
                children: [
                  Expanded(
                    child: ListTile(
                      title: const Text('Buy'),
                      leading: Radio<OrderSide>(
                        value: OrderSide.buy,
                        groupValue: _side,
                        onChanged: (v) => setState(() => _side = v!),
                      ),
                    ),
                  ),
                  Expanded(
                    child: ListTile(
                      title: const Text('Sell'),
                      leading: Radio<OrderSide>(
                        value: OrderSide.sell,
                        groupValue: _side,
                        onChanged: (v) => setState(() => _side = v!),
                      ),
                    ),
                  )
                ],
              ),
              TextFormField(
                controller: _qtyC,
                keyboardType: TextInputType.numberWithOptions(decimal: true),
                decoration: const InputDecoration(labelText: 'Quantity'),
                validator: (v) => v == null || v.isEmpty ? 'Enter quantity' : null,
              ),
              if (_type == OrderType.limit)
                TextFormField(
                  controller: _priceC,
                  keyboardType: TextInputType.numberWithOptions(decimal: true),
                  decoration: const InputDecoration(labelText: 'Price'),
                ),
              if (_type == OrderType.stop)
                TextFormField(
                  controller: _stopC,
                  keyboardType: TextInputType.numberWithOptions(decimal: true),
                  decoration: const InputDecoration(labelText: 'Stop Price (trigger)'),
                ),
              const Spacer(),
              ElevatedButton.icon(
                onPressed: _submit,
                icon: const Icon(Icons.send),
                label: const Text('Submit Order'),
                style: ElevatedButton.styleFrom(minimumSize: const Size.fromHeight(48)),
              ),
              const SizedBox(height: 8),
              Text('Local time: ${df.format(DateTime.now())}', style: TextStyle(color: Colors.grey[600]))
            ],
          ),
        ),
      ),
    );
  }
}
