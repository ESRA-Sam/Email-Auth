import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_app1/FetchProfile.dart';
import 'package:flutter_app1/Models/UserModel.dart';
import 'package:flutter_app1/Profile.dart';
import 'package:flutter_app1/Retrieve.dart';

class Signup extends StatefulWidget {
  @override
  _SignupState createState() => _SignupState();
}

String firstName;
String middleName;
String lastName;
String email;
String password;

Widget buildFirstName() {
  return TextFormField(
    decoration: InputDecoration(
      hintText: 'Enter first name',
    ),
    onSaved: (value) {
      firstName = value;
    },
    validator: (value) {
      if (value == null) {
        return 'First name is required';
      }
    },
  );
}

Widget buildMiddleName() {
  return TextFormField(
    decoration: InputDecoration(
      hintText: 'Enter middle name',
    ),
    onSaved: (value) {
      middleName = value;
    },
    validator: (value) {
      if (value == null) {
        return 'Middle name is required';
      }
    },
  );
}

Widget buildLastName() {
  return TextFormField(
    decoration: InputDecoration(
      hintText: 'Enter Last name',
    ),
    onSaved: (value) {
      lastName = value;
    },
    validator: (value) {
      if (value == null) {
        return 'Last name is required';
      }
    },
  );
}

Widget buildPassword() {
  return TextFormField(
    decoration: InputDecoration(
      hintText: 'Enter password',
    ),
    onSaved: (value) {
      password = value;
    },
    validator: (value) {
      if (value == null) {
        return 'Password is required';
      }
    },
    obscureText: true,
  );
}

Widget buildEmail() {
  return TextFormField(
    decoration: InputDecoration(
      hintText: 'Enter email',
    ),
    onSaved: (value) {
      email = value;
    },
    validator: (value) {
      if (value == null) {
        return 'email is required';
      }
    },
  );
}

final GlobalKey<FormState> _key = GlobalKey<FormState>();

class _SignupState extends State<Signup> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Signup')),
      body: Center(
        child: Form(
          key: _key,
          child: Column(
            children: <Widget>[
              buildFirstName(),
              SizedBox(
                height: 10,
              ),
              buildMiddleName(),
              SizedBox(
                height: 10,
              ),
              buildLastName(),
              SizedBox(
                height: 10,
              ),
              buildEmail(),
              SizedBox(
                height: 10,
              ),
              buildPassword(),
              SizedBox(
                height: 10,
              ),
              ElevatedButton(onPressed: () {
                if (_key.currentState.validate()) {
                  _key.currentState.save();
                  signUp();
                }
                else {
                  return;
                }
              }
                  , child: Text('Submit')),
            ],
          ),
        ),
      ),
    );
  }

  signUp() async {
    final mAuth = FirebaseAuth.instance;
    await mAuth.createUserWithEmailAndPassword(email: email, password: password)
        .then((value) => addUserMode(mAuth.currentUser.uid))
        .catchError((onError) => print('$onError'));
  }

  addUserMode(String uid) async {
    UserModel userModel = UserModel(
        firstName, middleName, lastName, email, uid);
    await FirebaseFirestore.instance.collection('Users Collection').doc(uid)
        .set(userModel.toJson(userModel))
        .then((value) => Navigator.push(
        context, MaterialPageRoute(builder: (context) => FetchProfile())))
        .catchError((onError) => print('$onError'));


    addUser(String uid) async {
      final CollectionReference mUsers = FirebaseFirestore.instance.collection(
          'Users Collection');
      await mUsers.doc(uid).set(
          {
            'FirstName': firstName,
            'MiddleName': middleName,
            'LastName': lastName,
            'Email': email,
            'uid': FirebaseAuth.instance.currentUser.uid
          }

      )
          .then((value) => Navigator.push(
          context, MaterialPageRoute(builder: (context) => FetchProfile())))
          .catchError((onError) => print('$onError'));
    }
  }
}