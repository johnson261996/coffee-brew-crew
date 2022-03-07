
import 'package:provider/provider.dart';
import 'package:coffee/models/Person.dart';
import 'package:coffee/screens/authenticate/authenticate.dart';
import 'package:flutter/cupertino.dart';
import 'package:firebase_core/firebase_core.dart';
import 'home/home.dart';

class Wrapper extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
    // Initialize FlutterFire
    future: Firebase.initializeApp(),
    builder: (context, snapshot) {
      final user =Provider.of<Person?>(context);
      print("Wrapper:" + user.toString());
      if(user==null){
        return Authenticate();
      }else {
        return Home();
      }

    }
    );

  }


}

