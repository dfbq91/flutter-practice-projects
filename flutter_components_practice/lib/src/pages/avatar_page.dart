import 'package:flutter/material.dart';

class AvatarPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Avatar Page'),
        actions: [
          Container(
            padding: EdgeInsets.all(5.0),
            child: CircleAvatar(
              backgroundImage: NetworkImage(
                  'https://i.pinimg.com/474x/89/f5/e8/89f5e82810108f2ae9eb71f028ef9641.jpg'),
              radius: 20.0,
            ),
          ),
          Container(
            padding: EdgeInsets.only(right: 10.0),
            child: CircleAvatar(
              child: Text('DB'),
              backgroundColor: Colors.blue[800],
            ),
          )
        ],
      ),
      body: Center(
        child: FadeInImage(
          placeholder: AssetImage('assets/jar-loading.gif'),
          image: NetworkImage(
              'https://divaguemosjuntos.files.wordpress.com/2018/06/michael-dam.jpg?w=1200&h=800&crop=1'),
          fadeInDuration: Duration(milliseconds: 300),
        ),
      ),
    );
  }
}
