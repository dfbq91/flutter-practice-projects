import 'package:flutter/material.dart';

import 'package:flutter_components_practice/src/providers/menu_provider.dart';

import 'package:flutter_components_practice/src/utils/icon_string_util.dart';

class HomePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('HomePage'),
      ),
      body: _list(),
    );
  }

  Widget _list() {
    return FutureBuilder(
      future: menuProvider.loadData(),
      initialData: [],
      builder: (context, AsyncSnapshot<List<dynamic>> snapshot) {
        return ListView(
          children: _itemsList(snapshot.data, context),
        );
      },
    );
  }

  List<Widget> _itemsList(List<dynamic> data, BuildContext context) {
    return data.map((option) {
      return Column(
        children: [
          ListTile(
            title: Text(option['texto']),
            leading: getIcon(option['icon']),
            trailing: Icon(Icons.arrow_right_alt_outlined),
            onTap: () {
              Navigator.pushNamed(context, option['ruta']);

              /* This is a way to navigate to an specific route
              final route =
                  MaterialPageRoute(builder: (context) => AlertPage());
              Navigator.push(context, route); */
            },
          ),
          Divider()
        ],
      );
    }).toList();

    /* Another Way using forEach and a return variable:
    final List<Widget> options = [];
    print('La data');
    print(data);

    data.forEach((option) {
      final widgetTemp = ListTile(
        title: Text(option['texto']),
        leading: Icon(Icons.ac_unit_outlined),
        trailing: Icon(Icons.arrow_right_alt_outlined),
        onTap: () {},
      );
      options.add(widgetTemp);
      options.add(Divider());
    });

    return options;
    */
  }
}
