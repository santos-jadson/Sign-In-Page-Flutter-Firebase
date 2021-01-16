import 'package:basic_login_page/screens/contacts/contacts.dart';
import 'package:basic_login_page/services/auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:permission_handler/permission_handler.dart';

class Home extends StatefulWidget {
  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {

  final AuthService _auth = AuthService();
  PermissionStatus _permission;

  @override
  void initState() {
    _getPermission();
    super.initState();
  }

  Future<void> _getPermission() async {
    final PermissionStatus permission = await Permission.contacts.status;
    if (permission != PermissionStatus.granted &&
        permission != PermissionStatus.denied) {
      final Map<Permission, PermissionStatus> permissionStatus =
          await [Permission.contacts].request();

      setState((){
        _permission = permissionStatus[Permission.contacts] ??
          PermissionStatus.undetermined; 
      });
    } else {
      setState((){
        _permission = permission; 
      });
    }
  }

  @override
  Widget build(BuildContext context) {

    return Scaffold(
      appBar: AppBar(
        title: Text("Contacts", style: TextStyle(color: Colors.white, fontSize: 22),),
        backgroundColor: Colors.greenAccent[700],
        elevation: 0.0,
        actions: <Widget>[
          FlatButton.icon(
            label: Text("Logout", style: TextStyle(color: Colors.white)),
            icon: Icon(Icons.person,color: Colors.white,),
            onPressed: () async{
              await _auth.signOut();
            },
          )
        ],
      ),
      body: _permission == PermissionStatus.granted ?
            ContactsPage()
            : CupertinoAlertDialog(
                title: Text('Permissions error'),
                content: Text('Please enable contacts access '
                    'permission in system settings'),
                actions: <Widget>[
                  CupertinoDialogAction(
                    child: Text('OK'),
                    onPressed: () async { await _getPermission(); }
                  )
                ],
              )
    );
  }
}


