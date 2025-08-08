import 'package:flutter/material.dart';
import '../models/cmsp.dart';
import '../screens/cmsp_detail_screen.dart';

class CMSPCard extends StatelessWidget {
  final CMSP cmsp;

  CMSPCard({required this.cmsp});

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: EdgeInsets.all(8),
      child: ListTile(
        title: Text(cmsp.name),
        subtitle: Text('${cmsp.type} • ${cmsp.licensedDate}'),
        trailing: Icon(Icons.arrow_forward_ios),
        onTap: () => Navigator.push(
          context,
          MaterialPageRoute(
            builder: (_) => CMSPDetailScreen(cmsp: cmsp),
          ),
        ),
      ),
    );
  }
}
