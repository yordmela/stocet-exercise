import 'package:flutter/material.dart';
import '../models/cmsp.dart';

class CMSPDetailScreen extends StatelessWidget {
  final CMSP cmsp;

  CMSPDetailScreen({required this.cmsp});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text(cmsp.name)),
      body: Padding(
        padding: EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text("Type: ${cmsp.type}"),
            SizedBox(height: 8),
            Text("Licensed On: ${cmsp.licensedDate}"),
            Divider(),
            Text("Background: ${cmsp.background}"),
            SizedBox(height: 8),
            Text("Goals: ${cmsp.goals}"),
            SizedBox(height: 8),
            Text("Capital: ${cmsp.capital}"),
            SizedBox(height: 8),
            Text("Prepared On: ${cmsp.preparedOn}"),
          ],
        ),
      ),
    );
  }
}
