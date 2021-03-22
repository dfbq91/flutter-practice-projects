import 'package:awesome_qr_reader/models/scan_model.dart';
import 'package:awesome_qr_reader/providers/db_provider.dart';
import 'package:flutter/material.dart';
import 'package:flutter/foundation.dart';

// Interacts with user interface through  DBProvider
class ScanListProvider extends ChangeNotifier {
  List<ScanModel> scans = [];
  String selectedOption = 'http'; // first button

  Future<ScanModel> newScan(String value) async {
    final newScan = ScanModel(value: value);
    final id = await DBProvider.db.newScan(newScan);
    newScan.id = id;

    print('ID of the created element ' + '$id');

    if (this.selectedOption == newScan.type) {
      this.scans.add(newScan);
      notifyListeners();
    }

    return newScan;
  }

  void loadAllScans() async {
    final scans = await DBProvider.db.getAllScans();
    this.scans = [...scans];
    notifyListeners();
  }

  void loadAllScansByType(String type) async {
    final scans = await DBProvider.db.getScansByType(type);
    this.scans = [...scans];
    this.selectedOption = type;
    notifyListeners();
  }

  void deleteAllScans() async {
    await DBProvider.db.deleteAllScans();
    this.scans = [];
    notifyListeners();
  }

  void deleteScanById(int id) async {
    await DBProvider.db.deleteScan(id);
  }
}
