import 'package:flutter/material.dart';
import 'package:healthband/Screens/wrapper.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:healthband/services/auth.dart';
import 'package:provider/provider.dart';
import 'package:healthband/models/user.dart';
//import 'package:flutter_blue/flutter_blue.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
 
  @override
  Widget build(BuildContext context) {
    return StreamProvider<User1?>.value(
      value: AuthService().user,
     initialData: null,
     child: MaterialApp(
       theme: ThemeData(fontFamily: 'Montserrat'),
       home: Wrapper(),

     ),


        );
  }
}
// class MyHomePage extends StatefulWidget {
//   MyHomePage({Key? key}) : super(key: key);
//   final FlutterBlue flutterBlue = FlutterBlue.instance;
//   final List<BluetoothDevice> devicesList = new List<BluetoothDevice>.filled(length, fill);
//   @override
//   _MyHomePageState createState() => _MyHomePageState();
// }
//
// class _MyHomePageState extends State<MyHomePage> {
//   @override
//
//   Widget build(BuildContext context) {
//     return Container();
//   }
// }





