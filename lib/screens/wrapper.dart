import 'package:basic_login_page/model/user.dart';
import 'package:basic_login_page/screens/authenticate/authenticate.dart';
import 'package:basic_login_page/screens/home/home.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class Wrapper extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final user = Provider.of<ModelUser>(context);

    if(user == null)
      return Authenticate();

    return Home();
  }
}