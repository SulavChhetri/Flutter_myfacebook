import 'package:modal_progress_hud_nsn/modal_progress_hud_nsn.dart';
import 'package:myfacebook/constants.dart';
import 'package:flutter/material.dart';
import 'package:myfacebook/components/round_button.dart';
import 'package:firebase_auth/firebase_auth.dart';

import 'chat_screen.dart';

class RegistrationScreen extends StatefulWidget {
  static const String id = 'registration_screen';
  @override
  _RegistrationScreenState createState() => _RegistrationScreenState();
}

class _RegistrationScreenState extends State<RegistrationScreen> {
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
                hinttext: 'Enter your Password',
                hidetext: true,
              ),
              SizedBox(
                height: 24.0,
              ),
              Roundbutton(title: 'Register', onPressed: () async {
                setState(() {
                  showSpinner=true;
                });
               try{
                 final newUser = await _auth.createUserWithEmailAndPassword(email: email, password: password);
                 Navigator.pushNamed(context, ChatScreen.id);
                 setState(() {
                   showSpinner= false;
                 });
               }
               catch(e){
                 print(e);
               }
              }
              ),
            ],
          ),
        ),
      ),
    );
  }
}
