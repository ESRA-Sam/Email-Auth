import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_auth/firebase_auth.dart';

class CardRet extends StatefulWidget {
  @override
  _CardRetState createState() => _CardRetState();
}

class _CardRetState extends State<CardRet> {
  String uid = FirebaseAuth.instance.currentUser.uid;
  var results;
  @override
  void initState()
  {
    super.initState();
    _getProfile(uid).then((QuerySnapshot docs)
    {
      if(docs.docs.isNotEmpty)
        {
              results = docs.docs[0].data();
        }
    });
  }
  _getProfile(String uid)
  {
    return FirebaseFirestore.instance.
    collection('users').
    where('uid',isEqualTo: uid)
        .get();

  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title:Text('Profile')),
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(15.0),
          child: Material(
           elevation: 7.0,
            borderRadius: BorderRadius.circular(7.0),
            child: Container(
              height: 300,
              padding: EdgeInsets.all(10.0),
              child: Column(
                children:<Widget> [
                  Text(
                    results['FirstName'],
                    style: TextStyle(
                      fontSize: 17.0
                    ),
                  ),
                  SizedBox(height: 10,),
                  Container(
                    height: 0.5,
                    width: double.infinity,
                    color:Colors.red
                  ),
                  SizedBox(height: 15.0,),
                  Text(results['PhoneNumber'],
                    style: TextStyle(
                      fontSize: 14.0,

                    ),
                  ),
                  SizedBox(height: 45.0,)
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
