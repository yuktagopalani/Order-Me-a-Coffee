import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:order_me_a_coffee/modules/coffee.dart';
import 'package:order_me_a_coffee/screens/home/brewlist.dart';
import 'package:order_me_a_coffee/services/auth.dart';
import 'package:order_me_a_coffee/services/database.dart';
import 'package:provider/provider.dart';
class Home extends StatelessWidget {
  final AuthService _auth = AuthService();
  @override
  Widget build(BuildContext context) {
    return StreamProvider<List<Brew>>.value(
      initialData: List(),
      value: DatabaseService().data,
      child: Scaffold(
        appBar: AppBar(
          title: Text("Order Me a Coffee"),
          backgroundColor: Colors.brown[400],
          elevation: 50.0,
          actions: <Widget>[
            FlatButton.icon(onPressed: ()async{
              await _auth.signingOut();

            }, icon: Icon(Icons.person), label: Text("Logout")),
          ],
        ),
        body: BrewList(),
      ),
    );
  }
}
