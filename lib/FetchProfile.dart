import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class FetchProfile extends StatefulWidget {
  @override
  _FetchProfileState createState() => _FetchProfileState();
}

class _FetchProfileState extends State<FetchProfile> {
  final String uid = FirebaseAuth.instance.currentUser.uid;
  final  profileRef = FirebaseFirestore.instance.collection('users');

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getProfile();
  }

  void getProfile()
  {
    profileRef.doc(uid).get().then((DocumentSnapshot doc)
    {
           print(doc.id);
    });
  }

  getProfileStream(String uid)
  {
    return FirebaseFirestore.instance
        .collection('Users Collection')
        .where('uid',isEqualTo: uid)
        .snapshots();
  }
  @override
   Widget build(BuildContext context) {
    final String uid = FirebaseAuth.instance.currentUser.uid;
    final  profileRef = FirebaseFirestore.instance.collection('users').doc(uid);
    return Scaffold(
      appBar: AppBar(
        title: Text('your profile'),
      ),
      body: Center(
        child: StreamBuilder(
          stream: getProfileStream(uid),
          builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot)
          {
            if(!snapshot.hasData)
            {
              return Text('No data found');
            }
            return ListView(
                children: snapshot.data.docs.map((user)
                {
                  return Material(
                    elevation: 7.0,
                    borderRadius: BorderRadius.circular(7.0),
                    child: Container(
                      height: 300.0,
                      padding: EdgeInsets.all(20.0),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: <Widget>[


                          Text('First Name    ' + user['FirstName']), SizedBox(height: 15.0,),
                          Text('Middle Name   '+user['MiddleName']), SizedBox(height: 15.0,),
                          Text('Last Name     '+user['LastName']), SizedBox(height: 15.0,),
                          Container(
                            height: 0.5,
                            width: double.infinity,
                            color: Colors.red,
                          ),
                          SizedBox(height: 15.0,), Text('Email     '+ user['Email']),
                        ],
                      ),
                    ),

                  );
                }).toList()
            );
          },

        )
      ),
    );
  }
}
