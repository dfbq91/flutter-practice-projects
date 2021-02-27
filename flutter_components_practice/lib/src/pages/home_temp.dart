import 'package:flutter/material.dart';

class HomePageTemp extends StatelessWidget {
  final List<String> options = ['Uno', 'Dos', 'Tres', 'Cuatro', 'Cinco'];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Flutter components Practice"),
      ),
      body: ListView(children: _anotherWay()),
    );
  }

  // List<Widget> _createOptions() {
  //   List<Widget> optionsList = [];
  //   for (String option in options) {
  //     optionsList.add(ListTile(title: Text(option)));
  //     optionsList.add(Divider());
  //   }
  //   return optionsList;
  // }

  List<Widget> _anotherWay() {
    return options.map((option) {
      return Column(
        children: [
          ListTile(
            title: Text(option),
            subtitle: Text('A subtitle'),
            leading: Icon(Icons.accessible_rounded),
            trailing: Icon(Icons.arrow_right_alt),
            onTap: () => null,
          ),
          Divider()
        ],
      );
    }).toList();
  }
}
