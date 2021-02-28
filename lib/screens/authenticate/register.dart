import 'package:flutter/material.dart';
import 'package:order_me_a_coffee/services/auth.dart';
class Register extends StatefulWidget {
  final Function toggleView;
  Register({this.toggleView});
  @override
  _RegisterState createState() => _RegisterState();
}

class _RegisterState extends State<Register> {
  AuthService _auth = AuthService();
  final _formkey = GlobalKey<FormState>();
  String email='';
  String password='';
  String error='';
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.brown[100],
      appBar: AppBar(
        backgroundColor: Colors.brown[400],
        elevation: 50.0,
        title: Text("Sign Up to get Coffee  :-)"),
        actions: <Widget>[
          FlatButton.icon(onPressed: ()async{
//            await _auth.signingOut();

              widget.toggleView();
          },
              icon: Icon(Icons.person), label: Text("Sign in")),
        ],

      ),
      body: Container(
        padding: EdgeInsets.symmetric(horizontal: 50.0, vertical: 20.0),
        child: Form(
          key: _formkey,
          child: Column(
            children: <Widget>[
              SizedBox(height: 20.0),
              TextFormField(
                validator: (val) => val.isEmpty ? 'Enter an E-Mail' : null,
                onChanged: (val){
                  setState(() => email=val);
                },
              ),
              SizedBox(height: 20.0),
              TextFormField(
                obscureText: true,
                validator: (val) => val.length <6 ? 'Password should be at least 6 characters' : null,
                onChanged: (val){
                  setState(() => password=val);
                },
              ),
              SizedBox(height: 20.0),
              RaisedButton(
                  color: Colors.pink[400],
                  child: Text("Sign Up"),
                  onPressed: ()async{
                    if(_formkey.currentState.validate())
                      {
                            dynamic result = await _auth.registerWithEmail(email, password);
                            if(result==null)
                              {
                                 setState(() => error='please enter the valid email');
                              }
                      }

                  }),
              SizedBox(height: 20.0),
              Text(error,
                style: TextStyle(
                  color: Colors.red,
                ),
              )


            ],
          ),
        ),
      ),
    );
  }
}
