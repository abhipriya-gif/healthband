import 'package:flutter/material.dart';
import 'package:healthband/services/auth.dart';

class Register extends StatefulWidget {
  final Function toggleView;
  Register({required this.toggleView});

  @override
  _RegisterState createState() => _RegisterState();
}

class _RegisterState extends State<Register> {

  final AuthService _auth = AuthService();
  final _formkey = GlobalKey<FormState>();

  String email = '';
  String password = '';
  String nickname = '';
  String error = '';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Color(0xffEEEEEE),
      appBar: AppBar(
        backgroundColor: Color(0xffEEEEEE),
        elevation: 0.0,
        actions: [
          ElevatedButton(
            style: ElevatedButton.styleFrom(
            primary: Color(0xffeeeeee)),
            child: Icon(Icons.arrow_back_ios, color: Colors.black),
              onPressed: (){
                widget.toggleView();
              },

              )

        ],
      ),
      body: Container(
        padding: EdgeInsets.symmetric(vertical: 20, horizontal: 50),
        child: Form(
          key: _formkey,
          child: Column(
            children: [
              SizedBox(height: 20.0,),
              TextFormField(
                decoration: InputDecoration(
                  hintText: 'Enter Email'
                ),
                validator: (val) => val?.isEmpty?? true? 'Enter an email' : null,
                onChanged: (val){
                  setState(() => email =  val);
                },

              ), //username
              SizedBox(height: 20.0),
              TextFormField(
                  decoration: InputDecoration(
                      hintText: 'Enter Password'
                  ),
                  obscureText: true,
                  validator: (val) => (val?.length ?? -1) < 8 ? 'Minimum 8 characters' : null,
                  onChanged: (val){
                    setState(() => password =  val);
                  }), //password
              Text('Password must contain digits and numbers (at least 8 characters)'),
              SizedBox(height: 25.0,),
              TextFormField(
                  decoration: InputDecoration(
                      hintText: 'Enter verification code'
                  ),
                  onChanged: (val){
                    setState(() => nickname =  val);
                  }),
              SizedBox(height: 50.0),
              ElevatedButton(
                  style: ElevatedButton.styleFrom(
                      primary: Color(0xff008080), // background
                      onPrimary: Colors.white, // foreground
                      shape: RoundedRectangleBorder( borderRadius: BorderRadius.circular(18) ),
                      fixedSize: Size(302, 36)),
                  onPressed: () async {
                    if(_formkey.currentState!.validate()){
                     dynamic result = await _auth.registerWithEmailAndPassword(email, password);
                     if (result == null){
                        setState(() => error = 'provide valid email');
                        }
                     }
                    },

                  child: Text('Register')
              ),
            //SizedBox(height: 20.0),
            Text(error,
            style: TextStyle(color: Colors.red)),
            ],
          ),
        ),
      ),
    );
  }
}
