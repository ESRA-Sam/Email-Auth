import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_app1/FetchProfile.dart';
import 'package:flutter_app1/Profile.dart';
import 'package:flutter_app1/ProfileFetch.dart';
import 'package:flutter_app1/Retrieve.dart';
import 'package:flutter_app1/Signup.dart';


class Auth extends StatefulWidget {
  @override
  _AuthState createState() => _AuthState();
}
Widget buidEmail()
{
return TextFormField(
  decoration: InputDecoration(
    hintText: 'Write your email address',
  ),
  onSaved: (value)
  {
    email = value;
  },
  validator: (value)
  {
    if(value == null)
      {
        return 'Email is required!';
      }

  },
);
}
String email;
String password;
Widget buildPassword()
{
  return TextFormField(
    decoration: InputDecoration(
      hintText: 'Write your password here',

    ),
    obscureText: true,
    onSaved: (value)
    {
      password = value;
    },
    validator: (value)
    {
      if(value == null)
        {
          return 'Password is required!';
        }
    },
  );
}
final GlobalKey<FormState> _key = GlobalKey<FormState>();
class _AuthState extends State<Auth> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Welcome!'),
      ),
      body: Center(
        child: Form(
          key: _key,
          child: Column(
            children:<Widget> [
              buidEmail(), SizedBox(height: 10,),buildPassword(),SizedBox(height: 10,),
              TextButton(onPressed: ()
              {
                if(_key.currentState.validate())
                { _key.currentState.save();
                  login();
                }
                else
                  {
                    return;
                  }
              },
                  child: Text('Login')),
              SizedBox(height: 10,),
              TextButton(onPressed: (){Navigator.push(context, MaterialPageRoute(builder: (context)=>Signup()));}, child: Text('Signup')),
            ],
          ),
        ),
      ),
    );
  }
  login  ()
  async  {
  await FirebaseAuth.instance.signInWithEmailAndPassword(email: email, password: password)
      .then((value) => Navigator.push(context, MaterialPageRoute(builder: (context) => FetchProfile())))
      .catchError((onError)=>print('$onError'));

  }
}
