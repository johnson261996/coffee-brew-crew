import 'package:coffee/models/Person.dart';
import 'package:coffee/services/DatabaseService.dart';
import 'package:firebase_auth/firebase_auth.dart';

class AuthService {

  final FirebaseAuth _auth = FirebaseAuth.instance;

  //create user obj based on Firebaseuser
  Person? _userfromFirebaseUser(User? user){
    return user != null ? Person(uid: user.uid):null;
  }

  Stream<Person?> get user {
    return _auth.authStateChanges().map((User? user) => _userfromFirebaseUser(user));
  }

  //sign in anonyomously
  Future signInAnon() async {
    try {
      UserCredential result = await _auth.signInAnonymously();
      User? user = result.user;
      return _userfromFirebaseUser(user!);
    }catch(e){
      print(e.toString());
      return null;
    }
  }
  //sign in with email and password
  Future signInEmailPassword(String email,String password)async{
    try{
      UserCredential result = await _auth.signInWithEmailAndPassword(email: email, password: password);
      User? user = result.user;
      return _userfromFirebaseUser(user);
    }catch(e){
      print(e.toString());
      return null;
    }

  }

 //register with email and password
  Future registerEmailPassword(String email,String password)async{
    try{
      UserCredential result = await _auth.createUserWithEmailAndPassword(email: email, password: password);
      User? user = result.user;
      await DatabaseServvice(uid: user!.uid).updateUserData('0', "new brew member", 100);
      return _userfromFirebaseUser(user);
    }catch(e){
      print(e.toString());
      return null;
    }

  }

  //sign out
 Future signOut() async{
   try{
     return await _auth.signOut();
   }catch(e){
     print(e.toString());
   }
 }

}