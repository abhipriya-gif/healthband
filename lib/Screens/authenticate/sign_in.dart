import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:healthband/services/auth.dart';

class SignIn extends StatefulWidget {
  final Function toggleView;
  SignIn({required this.toggleView});

  @override
  _SignInState createState() => _SignInState();
}

class _SignInState extends State<SignIn> {

  final AuthService _auth = AuthService();
  final _formkey = GlobalKey<FormState>();
  String email = '';
  String password = '';
  String error = '';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xffEEEEEE),

      body: Container(
        padding: EdgeInsets.symmetric(vertical: 80, horizontal: 50),
        child: Form(
          key: _formkey,
          child: Column(
            children: [
              SizedBox(height: 20.0,),
              TextFormField(
                decoration: InputDecoration(
                    hintText: 'Enter e-mail address'
                ),
                validator: (val) => val?.isEmpty?? true? 'Enter an email' : null,
                onChanged: (val){
                  setState(() => email =  val);
                  },

              ), //username
            SizedBox(height: 20.0,),
            TextFormField(
                decoration: InputDecoration(
                    hintText: 'Enter password'
                ),
              obscureText: true,
                validator: (val) => (val?.length ?? -1) < 6 ? 'Minimum 6 characters' : null,
                onChanged: (val){
              setState(() => password =  val);
          }), //password

              SizedBox(height: 40.0),
              ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    primary: Color(0xff008080), // background
                    onPrimary: Colors.white, // foreground
                      shape: RoundedRectangleBorder( borderRadius: BorderRadius.circular(18) ),
                      fixedSize: Size(302, 36)
                  ),
                  onPressed: () async {
                    if(_formkey.currentState!.validate()){
                      dynamic result = await _auth.signIn(email, password);
                       if (result == null){
                        setState(() => error = 'incorrect email or password');
                       }
                    }
                  print(email);
                  print(password);
                  },
                  child: Text('Sign in', style: TextStyle(fontFamily: 'Montserrat'))
              ),
              SizedBox(height: 10.0),
              ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    primary: Colors.white, // background
                    onPrimary: Color(0xff707070),// foreground
                    side: BorderSide(width:1, color:Color(0xff707070)),
                    shape: RoundedRectangleBorder( borderRadius: BorderRadius.circular(18) ),
                    fixedSize: Size(302, 36)
                  ),
                  onPressed: (){
                              widget.toggleView();
                            },
                  child: Text('Create an account now', style: TextStyle(fontFamily: 'Montserrat'))),
              SizedBox(height: 20.0),
              Text(error),
            ],
          ),
        ),
      ),
    );
  }
}
