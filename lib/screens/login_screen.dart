import 'package:modal_progress_hud_nsn/modal_progress_hud_nsn.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:myfacebook/components/round_button.dart';
import 'package:myfacebook/screens/chat_screen.dart';

import '../constants.dart';

class LoginScreen extends StatefulWidget {
  static const String id = 'login_screen';
  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final _auth = FirebaseAuth.instance;
  late String email;
  late String password;
  bool showSpinner = false;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: ModalProgressHUD(
        inAsyncCall: showSpinner,
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 24.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: <Widget>[
              Container(
                height: 200.0,
                child: Image.asset('images/logo.png'),
              ),
              SizedBox(
                height: 48.0,
              ),
              Textfieldwidget(
                onChanged: (value) {
                  email = value;
                },
                hinttext: 'Enter your email',
                hidetext: false,
              ),
              SizedBox(
                height: 8.0,
              ),
              Textfieldwidget(
                onChanged: (value) {
                  password = value;
                },
                hinttext: 'Enter your password',
                hidetext: true,
              ),
              SizedBox(
                height: 24.0,
              ),
              Roundbutton(
                title: 'Log In',
                onPressed: () async {
                  setState(() {
                    showSpinner= true;
                  });
                  try{
                  final user = await _auth.signInWithEmailAndPassword(email: email, password: password);
                  Navigator.pushNamed(context, ChatScreen.id);
                  setState(() {
                    showSpinner= false;
                  });
                  }
                  catch(e){
                    print(e);
                  }
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}
