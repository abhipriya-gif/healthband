import 'package:firebase_auth/firebase_auth.dart';
import 'package:healthband/models/user.dart';

class AuthService{

final FirebaseAuth _auth = FirebaseAuth.instance;
User1? _userfromFirebase(User? user){
  return user != null ? User1(uid: user.uid): null;
}
//change user stream

  Stream<User1?> get user{
  return _auth.authStateChanges().map(_userfromFirebase);
  //map((User? user) => _userfromFirebase(user));
  }



  //sign in anonymously

  Future signInAnon() async {
  try{
    UserCredential result = await _auth.signInAnonymously();
  User user = result.user as User;
  return _userfromFirebase(user);

  }catch(e){
    print(e.toString());
    return null;
  }
}

  //sign iin with email

  Future signIn(String email, String password) async {
    try {
      UserCredential result = await _auth.signInWithEmailAndPassword(email: email, password: password);
      User user = result.user as User;
      return _userfromFirebase(user);
    } catch (e) {
      print(e.toString());
      return null;
    }
  }



  //register

  Future registerWithEmailAndPassword(String email, String password) async {
    try {
      UserCredential result = await _auth.createUserWithEmailAndPassword(
          email: email, password: password);
      User user = result.user as User;
      return _userfromFirebase(user);
    } catch (e) {
      print(e.toString());
      return null;
    }
  }


  //sign out
  Future signOut()async{
  try{
    return await _auth.signOut();

  }catch(e){
    print(e.toString());
    return null;
  }
  }

}