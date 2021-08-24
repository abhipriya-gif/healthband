import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:healthband/services/auth.dart';
import 'package:healthband/services/auth.dart';

class Home extends StatelessWidget {


  final AuthService _auth = AuthService();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Healthband"),
        backgroundColor: Color(0xff008080),
        elevation: 0.0,
        actions: <Widget>[
          TextButton.icon(
            icon: Icon(Icons.person),
              label: Text('Logout'),
              onPressed: () async {
              await _auth.signOut();
              })
        ]
      ),
    );
  }
}
