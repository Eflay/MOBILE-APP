// ignore_for_file: prefer_const_constructors, use_key_in_widget_constructors, sized_box_for_whitespace

import 'package:contacts_service/contacts_service.dart';
import 'package:flutter/material.dart';
import 'package:lamascotte/event/event_2/code.dart';

class AddContactPage extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => _AddContactPageState();
}

class _AddContactPageState extends State<AddContactPage> {
  Contact contact = Contact();
  PostalAddress address = PostalAddress(label: "Home");
  
  @override
  Widget build(BuildContext context) {

    var size = MediaQuery.of(context).size;
    contact.givenName = "DaiLama";
    //contact.familyName = "Agence";
    contact.phones = [Item(label: "mobile", value: "0494361917")];
    return Center(
      child: Container(
        width: size.width/2,
        height: size.height/18,
        margin: EdgeInsets.only(bottom: size.height/50),
        child: ElevatedButton(
          style: ElevatedButton.styleFrom(
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(15)),
              backgroundColor: Color.fromARGB(255, 248, 235, 204)),
          child: Text(
            "Woody",
            style: TextStyle(fontSize: size.width/15, color: Colors.black),
          ),
          onPressed: () {
            ContactsService.addContact(contact);
            Navigator.pop(context);
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => CodePage()),
            );
        },
      ),
    ));
  }
}