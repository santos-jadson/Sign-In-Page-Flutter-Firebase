import 'package:basic_login_page/screens/wrapper.dart';
import 'package:basic_login_page/services/auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:basic_login_page/model/user.dart';

void main() async {
   WidgetsFlutterBinding.ensureInitialized();
   await Firebase.initializeApp();
   runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return StreamProvider<ModelUser>.value(
        value: AuthService().user,
        child: MaterialApp(
          theme: ThemeData (
            primarySwatch: Colors.green,
          ),
        home: Wrapper(),
        debugShowCheckedModeBanner: false,
      ),
    );
  }
}