import 'package:flutter/material.dart';

class AlertPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Alert Page')),
      body: Center(
        child: RaisedButton(
          onPressed: () {
            _showAlert(context);
          },
          textColor: Colors.white,
          child: Text("Botón"),
          color: Colors.green,
          shape: StadiumBorder(),
        ),
      ),
      floatingActionButton: FloatingActionButton(
        child: Icon(Icons.keyboard_return),
        onPressed: () => Navigator.pop(context),
      ),
    );
  }

  void _showAlert(BuildContext context) {
    showDialog(
        context: context,
        barrierDismissible: true,
        builder: (context) {
          return AlertDialog(
            title: Text('Un titulo'),
            content: Column(mainAxisSize: MainAxisSize.min, children: [
              Text('El contenido de la caja de la alerta'),
              FlutterLogo(
                size: 100.0,
              ),
            ]),
            shape:
                RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
            actions: [
              FlatButton(
                onPressed: () => Navigator.of(context).pop(),
                child: Text('Cancelar'),
              ),
              FlatButton(
                onPressed: () => Navigator.of(context).pop(),
                child: Text('De acuerdo'),
              ),
            ],
          );
        });
  }
}
