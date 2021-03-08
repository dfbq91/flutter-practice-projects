import 'dart:math';
import 'dart:ui';

import 'package:flutter/material.dart';

class ButtonsPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Stack(children: [
          backgroundApp(),
          SingleChildScrollView(
              child: Column(
            children: [_titles(), _roundedButtons()],
          )),
        ]),
        bottomNavigationBar: BottomNavigationBar(
          selectedFontSize: 0,
          backgroundColor: Color.fromRGBO(55, 57, 84, 1.0),
          unselectedItemColor: Color.fromRGBO(116, 117, 152, 1.0),
          selectedItemColor: Colors.pinkAccent,
          items: [
            BottomNavigationBarItem(
              icon: Icon(Icons.person),
              label: "",
            ),
            BottomNavigationBarItem(
                icon: Icon(Icons.calendar_today), label: ""),
            BottomNavigationBarItem(icon: Icon(Icons.settings), label: ""),
          ],
        ));
  }

  Widget backgroundApp() {
    final gradient = Container(
      width: double.infinity,
      height: double.infinity,
      decoration: BoxDecoration(
          gradient: LinearGradient(
              begin: FractionalOffset(0.0, 0.6),
              end: FractionalOffset(0.0, 1.0),
              colors: [
            Color.fromRGBO(52, 54, 101, 1.0),
            Color.fromRGBO(35, 37, 57, 1.0)
          ])),
    );

    final pinkBox = Transform.rotate(
        angle: -pi / 5.0,
        child: Container(
            width: 360.0,
            height: 360.0,
            decoration: BoxDecoration(
                gradient: LinearGradient(colors: [
                  Color.fromRGBO(236, 98, 188, 1.0),
                  Color.fromRGBO(241, 142, 172, 1.0)
                ]),
                borderRadius: BorderRadius.circular(70.0))));

    return Stack(
      children: [gradient, Positioned(top: -100.0, child: pinkBox)],
    );
  }

  Widget _titles() {
    return SafeArea(
      child: Container(
        margin: EdgeInsets.all(20.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text('Classify Transaction',
                style: TextStyle(
                    color: Colors.white,
                    fontSize: 30.0,
                    fontWeight: FontWeight.bold)),
            SizedBox(height: 10.0),
            Text('Classify this transaction into a particular category',
                style: TextStyle(color: Colors.white, fontSize: 17.0))
          ],
        ),
      ),
    );
  }

  Widget _roundedButtons() {
    return Table(children: [
      TableRow(children: [
        _createRoundedButton(
            Colors.green, Icons.access_alarm_outlined, 'Texto 1'),
        _createRoundedButton(Colors.orange, Icons.crop_original, 'Texto 2')
      ]),
      TableRow(children: [
        _createRoundedButton(
            Colors.deepPurple, Icons.baby_changing_station, 'Texto 3'),
        _createRoundedButton(Colors.indigo, Icons.grade, 'Texto 4')
      ]),
      TableRow(children: [
        _createRoundedButton(Colors.brown, Icons.cached, 'Texto 5'),
        _createRoundedButton(Colors.deepOrange, Icons.deck, "Texto 6")
      ]),
      TableRow(children: [
        _createRoundedButton(Colors.yellow, Icons.point_of_sale, "Texto 7"),
        _createRoundedButton(Colors.redAccent, Icons.amp_stories, "Texto 8")
      ]),
    ]);
  }

  Widget _createRoundedButton(Color color, IconData icon, String text) {
    return ClipRect(
      child: BackdropFilter(
        filter: ImageFilter.blur(sigmaX: 12.0, sigmaY: 12.0),
        child: Container(
          padding: EdgeInsets.all(25.0),
          height: 150.0,
          margin: EdgeInsets.all(15.0),
          decoration: BoxDecoration(
              color: Color.fromRGBO(62, 66, 107, 0.7),
              borderRadius: BorderRadius.circular(20.0)),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              CircleAvatar(
                backgroundColor: color,
                radius: 30.0,
                child: Icon(
                  icon,
                  color: Colors.white,
                  size: 30.0,
                ),
              ),
              SizedBox(
                height: 15.0,
              ),
              Text(
                text,
                style: TextStyle(color: color),
              )
            ],
          ),
        ),
      ),
    );
  }
}
