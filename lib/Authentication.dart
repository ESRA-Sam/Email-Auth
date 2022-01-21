import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_app1/Retrieve.dart';

class Authentication extends StatefulWidget {
  const Authentication({Key key}) : super(key: key);


  @override
  _AuthenticationState createState() => _AuthenticationState();
}

class _AuthenticationState extends State<Authentication> {

  String _email,_password;
  GlobalKey<FormState> formKey = GlobalKey<FormState>();
  Widget _buildEmail()
  {
    return  TextFormField(
      decoration: InputDecoration(
          labelText: 'email',
          hintText: 'Write your email address'
      ),
      validator: (value)
      {
        if(value.isEmpty)
        {
          return 'Email is required to sign in';
        }
      },

      onSaved: (value)
      {
        _email = value;
      },
    );
  }

  Widget _buildPassword()
  {
    return TextFormField(
      decoration:  InputDecoration
        (
          labelText: "password",
          hintText: "Write your password here"
      ),

      validator: (value)
      {
        if(value.isEmpty)
        {
          return 'Password is required';
        }

      },

      onSaved: (value)
      {
        _password = value;
      },

    );
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          title: Center(child: Text('Login')),
          backgroundColor: Colors.green,
        ),
        body: SafeArea(
          child: Container
            (
            child: Form(
              key: formKey,
              child: Column(
                children:<Widget> [
                  _buildEmail(), SizedBox(height: 10,),
                  _buildPassword(),SizedBox(height: 10,),
                  ElevatedButton(
                    onPressed: (){
                      if(!formKey.currentState.validate())
                      {
                        return;
                      }
                      else
                      {
                        formKey.currentState.save();
                        login(_email,_password);
                      }
                    },
                    child:Text('Login'),

                  ),
                  RichText(
                      text: new TextSpan(
                          children: [
                            new TextSpan(
                                text: 'Do not have an account?',
                                style: TextStyle(color: Colors.black)
                            ),
                            new TextSpan(
                                text: 'signup',
                                style: TextStyle(color: Colors.blue),
                                recognizer: TapGestureRecognizer()
                                  ..onTap = (){
                                    Navigator.push(context, MaterialPageRoute(builder: (context) => Retrieve()));

                                  }
                            )
                          ]
                      ))
                ],

              ),),
          ),
        ),
      ),
    );
  }

  Future<void> login(String email, String password) {

    FirebaseAuth.instance.createUserWithEmailAndPassword(email: email, password: password)
        .then((value) => Navigator.push(context, MaterialPageRoute(builder: (context) => Retrieve())) )
        .catchError((onError)=>display('$onError'));
    var uid = FirebaseAuth.instance.currentUser.uid;


  }

  void display(String text)
  {
    final snackBar = SnackBar(content: Text(text));
    ScaffoldMessenger.of(context).showSnackBar(snackBar);
    print('Success');
  }
}
