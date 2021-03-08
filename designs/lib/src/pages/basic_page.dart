import 'package:flutter/material.dart';

class BasicPage extends StatelessWidget {
  final titleStyle = TextStyle(fontSize: 20.0, fontWeight: FontWeight.bold);
  final subtitleStyle = TextStyle(fontSize: 18.0, color: Colors.grey);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: SingleChildScrollView(
      child: Column(children: [
        createImage(),
        createTitle(),
        createActions(),
        createText(),
        createText(),
        createText()
      ]),
    ));
  }

  Widget createImage() {
    return Container(
      width: double.infinity,
      child: Image(
        fit: BoxFit.cover,
        image: NetworkImage(
            'https://images.unsplash.com/photo-1506744038136-46273834b3fb?ixlib=rb-1.2.1&ixid=MXwxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHw%3D&auto=format&fit=crop&w=750&q=80'),
        height: 200.0,
      ),
    );
  }

  Widget createTitle() {
    return SafeArea(
      child: Container(
        padding: EdgeInsets.symmetric(horizontal: 30.0, vertical: 20.0),
        child: Row(
          children: [
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Montañas',
                    style: titleStyle,
                  ),
                  SizedBox(height: 7.0),
                  Text('Otra montaña', style: subtitleStyle)
                ],
              ),
            ),
            Icon(Icons.star, color: Colors.red, size: 30.0),
            Text(
              '41',
              style: TextStyle(fontSize: 20.0),
            )
          ],
        ),
      ),
    );
  }

  Widget createActions() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: [
        createAction(Icons.call, 'CALL'),
        createAction(Icons.near_me, 'ROUTE'),
        createAction(Icons.share, 'SHARE')
      ],
    );
  }

  Widget createAction(IconData icon, String text) {
    return Column(
      children: [
        Icon(
          icon,
          color: Colors.blue,
          size: 40.0,
        ),
        SizedBox(height: 5.0),
        Text(
          text,
          style: TextStyle(color: Colors.blue, fontSize: 15.0),
        )
      ],
    );
  }

  Widget createText() {
    return SafeArea(
      child: Container(
        margin: EdgeInsets.symmetric(horizontal: 40.0),
        child: Text(
          "Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Ut enim ad minim veniam, quis nostrud exercitation ullamco laboris nisi ut aliquip ex ea commodo consequat. Duis aute irure dolor in reprehenderit in voluptate velit esse cillum dolore eu fugiat nulla pariatur. Excepteur sint occaecat cupidatat non proident, sunt in culpa qui officia deserunt mollit anim id est laborum.",
          textAlign: TextAlign.justify,
        ),
      ),
    );
  }
}
