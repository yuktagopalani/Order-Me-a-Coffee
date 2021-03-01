import 'package:flutter/material.dart';
import 'package:order_me_a_coffee/modules/user.dart';
import 'package:order_me_a_coffee/screens/authenticate/authenticate.dart';
import 'package:order_me_a_coffee/screens/home/home.dart';
import 'package:provider/provider.dart';
class Wrapper extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final user  = Provider.of<MyUser>(context);
    if(user==null)
      {
        return Authenticate();
      }
    else{
      return Home();
    }
  }
}
