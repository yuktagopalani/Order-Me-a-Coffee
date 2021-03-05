import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:order_me_a_coffee/modules/coffee.dart';
import 'package:provider/provider.dart';
import 'package:order_me_a_coffee/services/database.dart';
import 'brew_tile.dart';
class BrewList extends StatefulWidget {
  @override
  _BrewListState createState() => _BrewListState();
}

class _BrewListState extends State<BrewList> {
  @override
  Widget build(BuildContext context) {
    final brews = Provider.of<List<Brew>>(context) ?? [];
//    print(brews.docs);
    if(brews!=null) {
      brews.forEach((brews) {
        print(brews.name);
        print(brews.sugars);
        print(brews.strength);
      });
    }
    return ListView.builder(
      itemCount: brews.length,
      itemBuilder: (context,index){
          return BrewTile(brew: brews[index]);
      },
    );
  }
}
