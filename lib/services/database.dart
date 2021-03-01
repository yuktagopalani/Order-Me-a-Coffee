import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:order_me_a_coffee/modules/coffee.dart';

class DatabaseService{

  final String uid;
  DatabaseService({this.uid});
  final CollectionReference brewCollection = FirebaseFirestore.instance.collection('brews');

  Future updateUserData(String sugars, String name, int strength) async {
    return await brewCollection.doc(uid).set({
      'sugars': sugars,
      'name' : name,
      'strength' : strength,

    }
    );
  }
  List<Brew>_brewListFromSnapshot(QuerySnapshot snapshot)
  {
    return snapshot.docs.map((doc){
      return Brew(
        name: doc.data()['name'] ?? '',
        strength: doc.data()['strength'] ?? 0,
        sugars: doc.data()['sugars'] ?? '0',
      );
    }).toList();
  }
  Stream <List<Brew>> get data{
    return brewCollection.snapshots().map(_brewListFromSnapshot);
  }
}