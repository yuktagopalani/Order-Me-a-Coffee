import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:order_me_a_coffee/modules/user.dart';
import 'package:order_me_a_coffee/services/database.dart';

class AuthService{
  final FirebaseAuth _auth = FirebaseAuth.instance;

  MyUser _userFromFirebaseUser(User user)
  {
    return user != null ? MyUser(uid: user.uid): null;
  }

  Stream<MyUser> get user {
    return _auth.authStateChanges().map(_userFromFirebaseUser);
  }

  Future signInAnon() async {
    try{
      UserCredential result = await _auth.signInAnonymously();
      User user = result.user;
      return _userFromFirebaseUser(user);
    }
    catch(e)
    {
        print(e);
        return null;
    }
  }
  Future signInWithEmail(String email, String password)async
  {
    try{
      UserCredential result= await _auth.signInWithEmailAndPassword(email: email, password: password);
      User user = result.user;
      return _userFromFirebaseUser(user);
    }
    catch(e){
      print(e);
      return null;
    }
  }
  Future registerWithEmail(String email, String password)async
  {
      try{
        UserCredential result= await _auth.createUserWithEmailAndPassword(email: email, password: password);
        User user = result.user;
        await DatabaseService(uid: user.uid).updateUserData('0', 'Name', 100);
        return _userFromFirebaseUser(user);
      }
      catch(e){
          print(e);
          return null;
      }
  }
  Future signingOut() async {
    try{
      return await _auth.signOut();
    }
    catch(e)
    {
      print(e);
      return null;
    }
  }
}



