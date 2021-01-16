import 'package:basic_login_page/constants/loadingRoad.dart';
import 'package:basic_login_page/services/auth.dart';
import 'package:flutter/material.dart';
import 'package:basic_login_page/constants/inputDecoration.dart';

class SignIn extends StatefulWidget {

  final Function toggle;

  SignIn({this.toggle});

  @override
  _SignInState createState() => _SignInState();
}

class _SignInState extends State<SignIn> {

  final AuthService _auth = AuthService();
  final _formKey = GlobalKey<FormState>();
  bool loading = false;

  String _email = '';
  String _password = '';
  String _error = '';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,

      body: loading ? Loading() : SingleChildScrollView(
        padding: EdgeInsets.symmetric(vertical: 20.0, horizontal: 50.0),
        child: Container(
          child: Form(
            key: _formKey,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                SizedBox(height: 50.0,),
                SizedBox(
                  width: 300,
                  height: 300,
                  child: Image.asset('assets/logo_login.jpg'),
                ),
                SizedBox(height: 20.0,),
                TextFormField(
                  validator: (val) => val.isEmpty ? 'Enter an email' : null,
                  onChanged: (val) {
                    setState(() => _email = val);
                  },

                  keyboardType: TextInputType.emailAddress,
                  decoration: textInputDecoration.copyWith(labelText: 'Email'),
                  style: TextStyle(
                    fontSize: 20,
                  ),
                ),
                SizedBox(height: 20.0,),
                TextFormField(
                  validator: (val) => val.length < 6 ? 'Your password must have at least 6 characters' : null,
                  onChanged: (val) {
                    setState(() => _password = val);
                  },

                  keyboardType: TextInputType.visiblePassword,
                  decoration: textInputDecoration.copyWith(labelText: 'Password'),
                  obscureText: true,
                ),
                SizedBox(height: 40.0,),
                RaisedButton(
                  padding: EdgeInsets.all(18),
                  color: Colors.greenAccent,
                  child: Text(
                    'Sign In',
                    style: TextStyle(color: Colors.black54, fontSize: 18),
                  ),
                  onPressed: () async{
                    if(_formKey.currentState.validate()){
                      setState(() => loading = true);
                      dynamic result = await _auth.signInWithEmailAndPassword(_email, _password);         
                      if (result == null) {
                        setState(() {
                          _error = 'error while signing in';
                          loading = false;
                        });
                      }
                    }
                  }
                ),

                SizedBox(height: 20.0,),
                Text(_error,
                  style: TextStyle(color: Colors.red),
                ),

                SizedBox(height: 20.0,),
                FlatButton.icon(
                  icon: Icon(Icons.person),
                  label: Text('Register'),
                  onPressed: () {
                    widget.toggle();
                  },
                )
              ],
            ),
          )
        ),
      ),      
    );
  }
}