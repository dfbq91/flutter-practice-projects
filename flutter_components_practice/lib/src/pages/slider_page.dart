import 'package:flutter/material.dart';

class SliderPage extends StatefulWidget {
  SliderPage({Key key}) : super(key: key);

  @override
  _SliderPageState createState() => _SliderPageState();
}

class _SliderPageState extends State<SliderPage> {
  bool _blockedCheckbox = false;
  double _sliderValue = 200.0;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Slider'),
      ),
      body: Container(
        padding: EdgeInsets.only(top: 20.0),
        child: Column(
          children: [
            createSlider(),
            _checkbox(),
            _createSwitch(),
            getImage(),
          ],
        ),
      ),
    );
  }

  Widget createSlider() {
    return Slider(
        // divisions: 20,
        label: 'Tamaño de la imagen',
        activeColor: Colors.green,
        onChanged: _blockedCheckbox
            ? (value) {
                setState(() {
                  _sliderValue = value;
                });
              }
            : null,
        value: _sliderValue,
        min: 0.0,
        max: 500.0);
  }

  Widget _checkbox() {
    // return Checkbox(
    //   onChanged: (value) {
    //     setState(() {
    //       _blockedCheckbox = value;
    //     });
    //   },
    //   value: _blockedCheckbox,
    // );
    return CheckboxListTile(
      onChanged: (value) {
        setState(() {
          _blockedCheckbox = value;
        });
      },
      value: _blockedCheckbox,
      title: Text('CheckboxTile'),
    );
  }

  _createSwitch() {
    return SwitchListTile(
      onChanged: (value) {
        setState(() {
          _blockedCheckbox = value;
        });
      },
      value: _blockedCheckbox,
      title: Text('CheckboxTile'),
    );
  }

  Widget getImage() {
    return Expanded(
      child: Image(
        image: NetworkImage(
            'https://upload.wikimedia.org/wikipedia/commons/c/cf/11.-_Casa_Targaryen.png'),
        width: _sliderValue,
      ),
    );
  }
}
