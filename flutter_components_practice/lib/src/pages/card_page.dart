import 'package:flutter/material.dart';

class CardPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Cards Page"),
      ),
      body: ListView(
        padding: EdgeInsets.all(10.0),
        children: [_card1(), SizedBox(height: 15.0), _card2()],
      ),
    );
  }

  _card1() {
    return Card(
      elevation: 10,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15.0)),
      child: Column(
        children: [
          ListTile(
            title: Text('Hola, soy un título'),
            subtitle: Text(
                'Hola, soy un subtitulo y puedo tener solo una línea, o tener varias líneas. Tu decides.'),
            leading: Icon(
              Icons.photo_album,
              color: Colors.blue,
            ),
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              FlatButton(
                onPressed: () {},
                child: Text('Button'),
              ),
              FlatButton(
                onPressed: () {},
                child: Text('Button'),
              ),
            ],
          )
        ],
      ),
    );
  }

  _card2() {
    final card = Container(
      child: Column(
        children: [
          FadeInImage(
            placeholder: AssetImage('assets/jar-loading.gif'),
            image: NetworkImage(
                'https://cdn2.wanderlust.co.uk/media/1028/cropped-shutterstock_497799013.jpg?anchor=center&mode=crop&width=1200&height=0&rnd=131915974290000000'),
            fadeInDuration: Duration(milliseconds: 250),
            height: 200.0,
            fit: BoxFit.cover,
          ),
          Container(
              child: Text('Solo un texto de ejemplo'),
              padding: EdgeInsets.all(8.0)),
        ],
      ),
    );

    return Container(
      child: ClipRRect(
        child: card,
        borderRadius: BorderRadius.circular(20.0),
      ),
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(20.0),
          color: Colors.white,
          boxShadow: [
            BoxShadow(
                blurRadius: 10.0,
                color: Colors.black38,
                offset: Offset(2.0, 5.0),
                spreadRadius: (2.0))
          ]),
    );
  }
}
