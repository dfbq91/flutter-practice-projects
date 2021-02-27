import 'package:flutter/material.dart';

class InputPage extends StatefulWidget {
  @override
  _InputPageState createState() => _InputPageState();
}

class _InputPageState extends State<InputPage> {
  String _name = '';
  String _email = '';
  String _date = '';
  String _selectedSkill = 'Communication';

  List<String> skills = [
    'Communication',
    'Teamwork',
    'Problem Solving',
    'Critical thinking',
    'Leadership'
  ];

  TextEditingController _inputDateFieldController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Inputs de texto'),
      ),
      body: ListView(
        padding: EdgeInsets.symmetric(horizontal: 10.0, vertical: 15.0),
        children: [
          _createInput(),
          Divider(),
          _createEmail(),
          Divider(),
          _createPassword(),
          Divider(),
          _createDate(context),
          Divider(),
          _createDropdown(),
          Divider(),
          _createPerson()
        ],
      ),
    );
  }

  Widget _createInput() {
    return TextField(
      textCapitalization: TextCapitalization.sentences,
      decoration: InputDecoration(
        border: OutlineInputBorder(borderRadius: BorderRadius.circular(15.0)),
        counter: Text('Cantidad de letras: ${_name.length}'),
        helperText: "Texto de ayuda",
        labelText: "Label",
        hintText: 'Placeholder',
        icon: Icon(Icons.supervisor_account_sharp),
        suffixIcon: Icon(Icons.accessibility_new_sharp),
      ),
      onChanged: (value) {
        setState(() {
          _name = value;
        });
      },
    );
  }

  Widget _createEmail() {
    return TextField(
      keyboardType: TextInputType.emailAddress,
      decoration: InputDecoration(
        border: OutlineInputBorder(borderRadius: BorderRadius.circular(15.0)),
        helperText: "Email",
        labelText: "Email",
        hintText: 'Email',
        icon: Icon(Icons.alternate_email),
        suffixIcon: Icon(Icons.email),
      ),
      onChanged: (value) {
        setState(() {
          _email = value;
        });
      },
    );
  }

  Widget _createPassword() {
    return TextField(
      obscureText: true,
      decoration: InputDecoration(
        border: OutlineInputBorder(borderRadius: BorderRadius.circular(15.0)),
        helperText: "Password",
        labelText: "Password",
        hintText: 'Password',
        icon: Icon(Icons.lock_open),
        suffixIcon: Icon(Icons.lock),
      ),
      onChanged: (value) {
        setState(() {});
      },
    );
  }

  Widget _createDate(BuildContext context) {
    return TextField(
        enableInteractiveSelection: false,
        controller: _inputDateFieldController,
        decoration: InputDecoration(
          border: OutlineInputBorder(borderRadius: BorderRadius.circular(15.0)),
          helperText: "Fecha de nacimiento",
          labelText: "Fecha de nacimiento",
          hintText: 'Fecha de nacimiento',
          icon: Icon(Icons.perm_contact_calendar),
          suffixIcon: Icon(Icons.calendar_today),
        ),
        onTap: () {
          FocusScope.of(context).requestFocus(new FocusNode());
          _selectDate(context);
        });
  }

  void _selectDate(BuildContext context) async {
    DateTime pickedDate = await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime(2018),
      lastDate: DateTime(2025),
      locale: Locale('es', 'ES'),
    );

    if (pickedDate != null) {
      setState(() {
        _date = pickedDate.toString();
        _inputDateFieldController.text = _date;
      });
    }
  }

  List<DropdownMenuItem<String>> getListItems() {
    List<DropdownMenuItem<String>> personSkills = List();

    skills.forEach((skill) {
      personSkills.add(DropdownMenuItem(
        child: Text(skill),
        value: skill,
      ));
    });
    return personSkills;
  }

  Widget _createDropdown() {
    return Row(children: [
      Icon(Icons.arrow_drop_down),
      SizedBox(width: 30.0),
      Expanded(
        child: DropdownButton(
            value: _selectedSkill,
            onChanged: (option) {
              setState(() {
                _selectedSkill = option;
              });
            },
            items: getListItems()),
      )
    ]);
  }

  Widget _createPerson() {
    return ListTile(
        title: Text('El nombre de la persona es $_name'),
        subtitle: Text('El nombre de la persona es $_email'),
        trailing: Text(_selectedSkill));
  }
}
