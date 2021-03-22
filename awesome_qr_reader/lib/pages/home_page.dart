// Packages
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

// Pages
import 'package:awesome_qr_reader/pages/directions_page.dart';
import 'package:awesome_qr_reader/pages/maps_page.dart';

// Widgets
import 'package:awesome_qr_reader/widgets/custom_navigation_bar.dart';
import 'package:awesome_qr_reader/widgets/scan_button.dart';

// Providers
import 'package:awesome_qr_reader/providers/scan_list_provider.dart';
import 'package:awesome_qr_reader/providers/ui_provider.dart';

class HomePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Center(child: Text('Historial')),
        actions: [
          IconButton(
            icon: Icon(Icons.delete_forever),
            onPressed: () {},
          )
        ],
      ),
      body: _HomePageBody(),
      floatingActionButton: ScanButton(),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      bottomNavigationBar: CustomNavigationBar(),
    );
  }
}

class _HomePageBody extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    // Get the selected menu option
    final uiProvider = Provider.of<UiProvider>(context);

    // Set selectedOption with the respective page
    final selectedOption = uiProvider.selectedMenuOption;

    // Just for testing of DBProvider methods
    // DBProvider.db.database;
    // final tempScan = new ScanModel(value: 'http://google.com');
    // DBProvider.db.newScan(tempScan);
    // final tempScan2 = new ScanModel(value: 'http://google.es');
    // DBProvider.db.newScan(tempScan2);
    // DBProvider.db.getAllScans().then(print);
    // DBProvider.db.getScanById(3).then((scan) => print(scan.value));

    final scanListProvider =
        Provider.of<ScanListProvider>(context, listen: false);

    switch (selectedOption) {
      case 0:
        scanListProvider.loadAllScansByType('geo');
        return MapsPage();
      case 1:
        scanListProvider.loadAllScansByType('http');
        return DirectionsPage();
      default:
        scanListProvider.loadAllScansByType('geo');
        return MapsPage();
    }
  }
}
