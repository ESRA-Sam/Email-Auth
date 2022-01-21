import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_app1/Retrieve.dart';

class Profile extends StatefulWidget {


  @override
  _ProfileState createState() => _ProfileState();
}

class _ProfileState extends State<Profile> {
  final String uid = FirebaseAuth.instance.currentUser.uid;
  final  profileRef = FirebaseFirestore.instance.collection('Users Collection');


  var results;
  @override
  void initState()
  {
    super.initState();
    String uid = FirebaseAuth.instance.currentUser.uid;
    fetchProfile(uid).then((QuerySnapshot docs)
    {
      if(docs.docs.isNotEmpty)
      {  print(uid);
        results = docs.docs[0].data();
      }
    });
  }
  fetchProfile(String uid)
  {
    return FirebaseFirestore.instance.
    collection('Users Collection').
    where('uid',isEqualTo: uid)
        .get();

  }

  void getProfile()
  {
    profileRef.doc(uid).get().then((DocumentSnapshot doc)
    {
      print(doc.id);
    });
  }



  Future fetch() async
  {
    List profileList = [];
    try
    {
      await profileRef.doc(uid).get().then((value)
      {});
    }
    catch(e)
    {
      print(e.toString());
    }
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
