import 'package:awesome_qr_reader/providers/scan_list_provider.dart';
import 'package:awesome_qr_reader/utils/utils.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class ScanTiles extends StatelessWidget {
  final String type;

  const ScanTiles({@required this.type});

  @override
  Widget build(BuildContext context) {
    final scanListProvider = Provider.of<ScanListProvider>(context);
    final scans = scanListProvider.scans;

    return ListView.builder(
      itemCount: scans.length,
      itemBuilder: (context, i) {
        return Dismissible(
          key: UniqueKey(),
          background: Container(color: Colors.red),
          onDismissed: (DismissDirection direction) =>
              Provider.of<ScanListProvider>(context, listen: false)
                  .deleteScanById(scans[i].id),
          child: ListTile(
            title: Text(scans[i].value),
            subtitle: Text(scans[i].id.toString()),
            leading: Icon(
                (this.type == 'http') ? Icons.home_outlined : Icons.map,
                color: Theme.of(context).primaryColor),
            trailing:
                Icon(Icons.keyboard_arrow_right_rounded, color: Colors.grey),
            onTap: () {
              launchURL(context, scans[i]);
            },
          ),
        );
      },
    );
  }
}
