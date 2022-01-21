import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';

String firstName;
String middleName;
String lastName;
String email;
String phoneNumber;
String password;





class newwidget extends StatelessWidget {


  // ignore: use_key_in_widget_constructors
  newwidget(this.labelName);

  String labelName;
  @override
  Widget build(BuildContext context) {
    return TextFormField(
      decoration: InputDecoration(label: Text(labelName)),
      onSaved: (value) {
        if (labelName == "Name")
           firstName = value;
        else if (labelName == "Middle Name")
          middleName = value;
        else if (labelName == "Last Name") lastName = value;
        else if(labelName=="Email") email=value;
        else if(labelName=="PhoneNumber") phoneNumber=value;
        else if(labelName=="Password") password = value;

      },

      validator: (value)
      {
        if(value.isEmpty)
          {
            return 'Empty values are not allowed';
          }
      },
    );
  }
}






class TextFieldNew extends StatelessWidget {
  TextFieldNew(
      { this.name,
         this.short,
         this.hint,
         //this.mycontroller
   });

  final String name;
  final bool short;
  final String hint;
  //final TextEditingController mycontroller;

  @override
  Widget build(BuildContext context) {
    var brightness = MediaQuery.of(context).platformBrightness;
    bool isDarkMode = brightness == Brightness.dark;

    return Container(
      width: 250,
      child: TextFormField(
        onSaved: (value) {
          if (name == "Name")
            firstName = value;
          else if (name == "Middle Name")
            middleName = value;
          else if (name == "Last Name") lastName = value;
          else if(name=="Email") email=value;
          else if(name=="PhoneNumber") phoneNumber=value;
          else if(name=="Password") password = value;

         // print(firstName + middleName + lastName + email + phoneNumber + password);

        },

        validator: (value)
        {
          if(value.isEmpty)
          {
            return 'Empty values are not allowed';
          }
        },

        cursorColor: Color(0xFF082534),
        decoration: InputDecoration(
          hintText: hint,
          hintStyle: TextStyle(
            color: Theme.of(context).primaryColor,
          ),
          enabledBorder: UnderlineInputBorder(
              borderSide: BorderSide(
                  color: isDarkMode
                      ? Colors.white.withOpacity(0.7)
                      : Color(0xFF082534).withOpacity(0.5))),
          focusedBorder: UnderlineInputBorder(
              borderSide: BorderSide(
                  color: isDarkMode
                      ? Colors.white.withOpacity(0.5)
                      : Color(0xFF082534))),
          labelText: name,
          labelStyle: TextStyle(
              fontSize: 13,
              fontFamily: "Poppins",
              color: Theme.of(context).primaryColor),
        ),
      ),
    );
  }
}