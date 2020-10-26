
import 'package:datetime_picker_formfield/datetime_picker_formfield.dart';
import 'package:intl/intl.dart';
import 'package:flutter/material.dart';
void main() {
  runApp(new Publish());
}

class Publish extends StatelessWidget {
  DateTime selectedDate = DateTime.now();

  final format = DateFormat("yyyy-MM-dd");
  final formath = DateFormat("HH:mm");
  @override
  Widget build(BuildContext context) {
    String _nom;
    String _descripcio;

    String _direccio;
    String _preu;
    return MaterialApp(
      home: Scaffold(
        body: Container(
          margin: EdgeInsets.only(left: 30.0, right: 30.0, top: 120.0),
          alignment: Alignment.bottomCenter,
          child: Padding(
            padding: const EdgeInsets.all(10.0),
            child: Wrap(
              children: <Widget>[TextFormField(
                decoration: InputDecoration(
                  labelText: "Nom Esdeveniment",
                  fillColor: Colors.white,
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(25.0),
                    borderSide: BorderSide(),
                  )
                ),
                maxLines: 1,
                validator: (input) => input.isEmpty ? 'Error' : null,
                onSaved: (input) => _descripcio = input,
              ),
                Container(
                  margin: EdgeInsets.only(top: 20.0),
                  child: TextFormField(
                    decoration: InputDecoration(
                        labelText: "Descripció de l'Esdeveniment",
                        fillColor: Colors.white,
                        contentPadding: new EdgeInsets.symmetric(vertical: 30.0, horizontal: 20.0),
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(25.0),
                          borderSide: BorderSide(),
                        )
                    ),
                    maxLines: 4,
                    validator: (input) => input.isEmpty ? 'Error' : null,
                    onSaved: (input) => _nom = input,
                  ),
                ),
                Container(
                  margin: EdgeInsets.only(top: 20.0, left: 10.0),
                  child: Column(
                    children: <Widget>[TextFormField(
                      decoration: InputDecoration(
                          labelText: "Direcció de l\'Esdeveniment",
                          fillColor: Colors.white,
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(25.0),
                            borderSide: BorderSide(),
                          )
                      ),
                      maxLines: 1,
                      validator: (input) => input.isEmpty ? 'Error' : null,
                      onSaved: (input) => _direccio = input,
                    ),

                    ],
                  ),
                ),
                Container(
                  margin: EdgeInsets.only(top: 20.0, left: 10.0),
                  child: Column(
                    children: <Widget>[TextFormField(
                      decoration: InputDecoration(
                          labelText: "Preu",
                          fillColor: Colors.white,
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(25.0),
                            borderSide: BorderSide(),
                          )
                      ),
                      maxLines: 1,
                      validator: (input) => input.isEmpty ? 'Error' : null,
                      onSaved: (input) => _preu = input,
                    ),

                    ],
                  ),
                ),Container(
                  margin: EdgeInsets.only(top: 20.0, left: 10.0),
                  child: Column(
                    children: <Widget>[
                      Text('Introdueix la Data de l\'Esdeveniment'),
                      Container(
                        margin: EdgeInsets.only(left: 100.0, right:70.0),
                        child: DateTimeField(
                            format: format,
                            onShowPicker: (context, currentValue){
                              return showDatePicker(
                                  context: context,
                                  initialDate: currentValue ?? DateTime.now(),
                                  firstDate: DateTime(1900),
                                  lastDate: DateTime(2100)
                              );
                            }
                        ),
                      )
                    ],
                  ),
                ),
                Container(
                  margin: EdgeInsets.only(top: 10.0, left: 10.0),
                  child: Column(
                    children: <Widget>[
                      Text('Introdueix l\'hora de l\'Esdeveniment'),
                      Container(
                        margin: EdgeInsets.only(left: 120.0, right:94.0),
                        child: DateTimeField(
                            format: formath,
                            onShowPicker: (context, currentValue) async{
                              final time = await showTimePicker(
                                context: context,
                                initialTime: TimeOfDay.fromDateTime(currentValue ?? DateTime.now()),
                              );
                              return DateTimeField.convert(time);
                            }
                        ),
                      )
                    ],
                  ),
                ),
                Container(
                  margin: EdgeInsets.only(top: 10.0, left: 10.0),
                  child: Row(
                    children: <Widget>[
                      RaisedButton(
                          child: Text('Boton'),
                          onPressed: () =>{
                            publicaEsdeveniment()
                          },
                      )
                    ],
                  )
                ),
              ],
            ),
          ),
        ),
      ) ,
    );
  }

  publicaEsdeveniment() {
    //do stuff
  }




}




