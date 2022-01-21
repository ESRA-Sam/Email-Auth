import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';


class ProfileFetch extends StatefulWidget {
  @override
  _ProfileFetchState createState() => _ProfileFetchState();
}

class _ProfileFetchState extends State<ProfileFetch> {
  bool reviewFlags = false;
  var profile;
  String firstName,middleName,lastName,email;


  @override
  void initState()
  {
    super.initState();
    loadProfile().then((QuerySnapshot docs)
    {
      if(docs.docs.isNotEmpty)
        {
          reviewFlags = true;
          profile = docs.docs[0].data();
          print(profile['FirstName']);
        }
    });
  }

  loadProfile()
  {
      return FirebaseFirestore.instance.collection('Users Collection')
          .where('uid', isEqualTo: FirebaseAuth.instance.currentUser.uid.toString())
          .get();

  }




  @override
  Widget build(BuildContext context) {

    return Scaffold(
        appBar: AppBar(
          title: Center(
            child: Text(
              'Profile'
            ),
          ),
        ),
        body: Center(
          child: Padding(
            padding: const EdgeInsets.all(20.0),
            child: Material(
              elevation: 7.0,
                borderRadius: BorderRadius.circular(7.0),
                child: Container(
                  height: 300.0,
                  padding: EdgeInsets.all(20.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[

                        Text('FirstName'), SizedBox(height: 15.0,),
                      Text('Middle Name'), SizedBox(height: 15.0,),
                      Text('Last Name'), SizedBox(height: 15.0,),
                      Container(
                        height: 0.5,
                        width: double.infinity,
                        color: Colors.red,
                      ),
                      SizedBox(height: 15.0,), Text('Email'),
                      Row(
                        children: <Widget>[
                          reviewFlags ?
                              Row(
                                children: <Widget>[
                                  Column(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: <Widget>[
                                      SizedBox( height: 5.0,),
                                      Text(profile['FirstName'],
                                      style: TextStyle(
                                        fontSize: 14.0,
                                      ),),
                                      SizedBox( height: 5.0,),
                                      Text(profile['MiddleName'],
                                        style: TextStyle(
                                          fontSize: 14.0,
                                        ),),
                                      SizedBox( height: 5.0,),
                                      Text(profile['LastName'],
                                        style: TextStyle(
                                          fontSize: 14.0,
                                        ),),
                                      SizedBox( height: 5.0,),
                                      Text(profile['Email'],
                                        style: TextStyle(
                                          fontSize: 14.0,
                                        ),),
                                    ],
                                  )
                                ],
                              ): Text('Loading...')
                        ],
                      )
                    ],
                  ),
                ),

            ),
          ),
        ),
    );
  }
}
