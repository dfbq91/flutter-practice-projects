import 'package:flutter/material.dart';

class UiProvider extends ChangeNotifier {
  int _selectedMenuOption = 1;

  // Getters
  int get selectedMenuOption {
    return this._selectedMenuOption;
  }

  set selectedMenuOption(int selectedOption) {
    this._selectedMenuOption = selectedOption;
    notifyListeners();
  }

  // Getters and setters can also be coded in normal way
  // getSelectedMenuOption() {
  //   return this._selectedMenuOption;
  // }

  // setSelectedMenuOption(int selectedOption) {
  //   this._selectedMenuOption = selectedOption;
  //   notifyListeners();
  // }
}
