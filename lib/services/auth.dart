import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:order_me_a_coffee/modules/user.dart';

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



