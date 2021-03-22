import 'package:flutter/material.dart';
import 'package:awesome_qr_reader/providers/ui_provider.dart';
import 'package:provider/provider.dart';

class CustomNavigationBar extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    // Get the selected menu option
    final uiProvider = Provider.of<UiProvider>(context);

    // Set selectedOption with the respective page
    final currentIndex = uiProvider.selectedMenuOption;

    // Take a look to onTap property. When user taps in bottom navigation
    // bar item, the index of the option (from 0 to n) is setted through
    // uiProvider setter, whose includes a notifyListeners instruction
    // to notify HomePageBody to change the body of HomePage.
    return BottomNavigationBar(
      elevation: 0,
      currentIndex: currentIndex,
      onTap: (int selectedOption) {
        uiProvider.selectedMenuOption = selectedOption;
      },
      items: [
        BottomNavigationBarItem(icon: Icon(Icons.map), label: 'Mapa'),
        BottomNavigationBarItem(
            icon: Icon(Icons.compass_calibration), label: 'Direcciones')
      ],
    );
  }
}
