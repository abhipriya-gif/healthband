import 'package:flutter/material.dart';
import 'package:healthband/Screens/authenticate/authenticate.dart';
import 'package:healthband/Screens/home/home.dart';
import 'package:healthband/services/ble.dart';
import 'package:provider/provider.dart';
import 'package:healthband/models/user.dart';

class Wrapper extends StatelessWidget {
  const Wrapper({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final user = Provider.of<User1?>(context);
    print(user);

    if(user == null){
    //return either home or authenticate widget
    return Authenticate();
  }
    else {
      return Ble();
    }
    }
}
