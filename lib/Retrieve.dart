import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_app1/CardRet.dart';
import 'package:flutter_app1/FetchProfile.dart';
import 'package:flutter_app1/TextFormNew.dart';
class Retrieve extends StatefulWidget {
  @override
  _RetrieveState createState() => _RetrieveState();
}

class _RetrieveState extends State<Retrieve> {
  String _fistName;
  String _middleName;
  String _lastName;
  String _email;
  String _phoneNumber;
  String _password;
  String uid = FirebaseAuth.instance.currentUser.uid;
  CollectionReference users = FirebaseFirestore.instance.collection('users');
  final GlobalKey<FormState> _myFormKey = GlobalKey<FormState>();//to refer to the form we are creating.
  @override
  Widget build(BuildContext context) {
    return  Scaffold(
      appBar: AppBar(
        title: Text('Please Signup Here!',
            style: TextStyle(fontSize: 20, color: Colors.green)),
      ),
      body: SafeArea(
        child: Column(
          children: [
            Container(
              margin: EdgeInsets.all(24),
              child: Form(
                key: _myFormKey,
                child: Column(
                  // mainAxisAlignment: MainAxisAlignment.center,
                  children:<Widget> [

                    // _buildfirstName(),

                    /*SizedBox(height: 10),
                      _buildMiddleName(),
                      SizedBox(height: 10),
                      _buildLastName(),
                      SizedBox(height: 10),
                      _buildEmail(),
                      SizedBox(height: 10),
                      _buildPhoneNumber(),
                      SizedBox(height: 10),
                      _buildPassword(),
                      SizedBox(height: 10),*/

                    /*newwidget('Name'),
                      newwidget('Middle Name'),*/

                    TextFieldNew(
                      name: 'Name',
                      short: false,
                      hint: 'Enter your name here',

                    ),
                    TextFieldNew(
                      name: 'Middle Name',
                      short: false,
                      hint: 'Enter your name here',

                    ),
                    TextFieldNew(
                      name: 'Last Name',
                      short: false,
                      hint: 'Enter your name here',

                    ),
                    TextFieldNew(
                      name: 'Email',
                      short: false,
                      hint: 'Enter your name here',

                    ),
                    TextFieldNew(
                      name: 'PhoneNumber',
                      short: false,
                      hint: 'Enter your name here',

                    ),
                    TextFieldNew(
                      name: 'Password',
                      short: false,
                      hint: 'Enter your name here',

                    ),


                    RaisedButton(onPressed: (){

                      if(!_myFormKey.currentState.validate())
                      {
                        return;
                      }
                      else
                      {
                        _myFormKey.currentState.save();
                        addUsers();


                      }
                    },
                      child: Row(
                        children: <Widget>[
                          Icon(Icons.add, color: Colors.green, size: 40,),
                          SizedBox(width: 10),
                          Text('Submit',style: TextStyle(color: Colors.green,fontSize: 17,fontWeight: FontWeight.bold),),
                        ],
                      ),
                    ),
                     TextButton(onPressed: (){
                       Navigator.push(context, MaterialPageRoute(builder: (context) => CardRet()));
                     }, child: Text('Go to your profile'))

                  ],
                ),
              ),


            ),

          ],


        ),

      ),
    );


  }
  Future<void> addUsers()
  { final text= "successful";


  /*FirebaseAuth.instance.createUserWithEmailAndPassword(
      email: email, password: password)
      .then((value) => print('Successful'))
      .catchError((onError)=> print('$onError'));*/
  return users.doc(uid)
      .set(

      {
        'FirstName': firstName,
        'MiddleName': middleName,
        'LastName': lastName,
        'Email': FirebaseAuth.instance.currentUser.email.toString(),
        'PhoneNumber':phoneNumber,
        'Password':password,
        'uid':uid
      }

  )
      .then((value) =>print('Successfully Registered')) // onSuccessListner
      .catchError((error)=>print('$error')); //



  }
}
