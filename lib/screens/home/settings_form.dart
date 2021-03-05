import 'package:flutter/material.dart';
import 'package:order_me_a_coffee/modules/user.dart';
import 'package:order_me_a_coffee/services/database.dart';
import 'package:order_me_a_coffee/shared/loading.dart';
import 'package:provider/provider.dart';
class SettingsForm extends StatefulWidget {
  @override
  _SettingsFormState createState() => _SettingsFormState();
}

class _SettingsFormState extends State<SettingsForm> {
  final _formKey = GlobalKey<FormState>();
  final List<String> sugars = ['0','1','2','3','4'];
  String _currentName;
  String _currentSugars='';
  int _currentStrength;
  @override
  Widget build(BuildContext context) {
    MyUser user  = Provider.of<MyUser>(context);
    return StreamBuilder<UserData>(
      stream: DatabaseService(uid: user.uid).userData,
      builder: (context, snapshot) {
        print(snapshot.hasData);
        if(snapshot.hasData)
          {
            UserData userData =  snapshot.data;
            return Form(
                key: _formKey,
                child: Column(
                  children: <Widget>[
                    Text("Update your Settings"),
                    SizedBox(height: 20.0,),
                    TextFormField(
                      initialValue: userData.name,
//              decoration: textInputDecoration,
                      validator: (val) => val.isEmpty ? 'Please enter your name' : null,
                      onChanged: (val) => setState(()=> _currentName=val),
                    ),
                    SizedBox(height: 20.0,),
                    DropdownButtonFormField(
                      items: sugars.map((sugar) {
                        return DropdownMenuItem(
                          value: sugar,
                          child: Text("$sugar sugars"),


                        );
                      }).toList(),
                      onChanged: (val) {
                        setState(() => _currentSugars = val);
                      },
                    ),
                    Slider(
                      value: (_currentStrength ?? userData.strength).toDouble() ,
                      min: 100.0,
                      max: 900.0,
                      divisions: 8,

                      onChanged: (val) {
                        setState(() => _currentStrength = val.round());
                      },),
                    RaisedButton(
                        child: Text("Update"),
                        onPressed: ()async{
                          print(_currentName);
                          print(_currentStrength);
                          print(_currentSugars);
                          if(_formKey.currentState.validate()){
                            await DatabaseService(uid: user.uid).updateUserData(_currentSugars ?? userData.sugars, _currentName ?? userData.name, _currentStrength ?? userData.strength);
                            Navigator.pop(context);
                          }
                        }

                    ),
                  ],
                )
            );
          }
        else{
          return Loading();
        }

      }
    );
  }
}