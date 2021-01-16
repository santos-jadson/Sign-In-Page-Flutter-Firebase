import 'package:basic_login_page/screens/authenticate/registrate.dart';
import 'package:basic_login_page/screens/authenticate/sign_in.dart';
import 'package:flutter/material.dart';

class Authenticate extends StatefulWidget {
  @override
  _AuthenticateState createState() => _AuthenticateState();
}

class _AuthenticateState extends State<Authenticate> {

  bool signIn = true;

  void toggle(){
    setState(() => signIn = !signIn);
  }

  @override
  Widget build(BuildContext context) {
    if(signIn)
      return SignIn(toggle: toggle);
    
    return Register(toggle: toggle);
  }
}