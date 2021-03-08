import 'package:flutter/material.dart';

class ScrollPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: PageView(
      scrollDirection: Axis.vertical,
      children: [_page1(), _page2()],
    ));
  }

  Widget _page1() {
    return Stack(children: [backgroundColor(), backgroundImage(), texts()]);
  }

  Widget _page2() {
    return Container(
      width: double.infinity,
      height: double.infinity,
      color: Color.fromRGBO(108, 192, 218, 1.0),
      child: Center(
        child: RaisedButton(
          padding: EdgeInsets.symmetric(horizontal: 40.0, vertical: 20.0),
          onPressed: () {},
          child: Text(
            'Un triste botón',
            style: TextStyle(fontSize: 20.0),
          ),
          shape: StadiumBorder(),
          textColor: Colors.white,
          color: Colors.blueAccent,
        ),
      ),
    );
  }

  Widget backgroundColor() {
    return Container(
      width: double.infinity,
      height: double.infinity,
      color: Color.fromRGBO(108, 192, 218, 1.0),
    );
  }

  Widget backgroundImage() {
    return Container(
      width: double.infinity,
      height: double.infinity,
      child: Image(image: AssetImage('assets/scroll.png'), fit: BoxFit.cover),
    );
  }

  Widget texts() {
    final textStyle = TextStyle(color: Colors.white, fontSize: 50.0);

    return SafeArea(
      child: Column(
        children: [
          SizedBox(height: 25.0),
          Text('11°', style: textStyle),
          Text('Miércoles', style: textStyle),
          Expanded(
            child: Container(),
          ),
          Icon(Icons.keyboard_arrow_down, color: Colors.white, size: 70.0)
        ],
      ),
    );
  }
}
