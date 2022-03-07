import 'package:coffee/models/Person.dart';
import 'package:coffee/services/auth.dart';
import 'package:provider/provider.dart';
import 'package:coffee/screens/authenticate/wrapper.dart';
import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return
        // Initialize FlutterFire
        StreamProvider<Person?>.value(
          value: AuthService().user,
          //create: (BuildContext context) {  },
          initialData: null,
          child: MaterialApp(
            home: Wrapper(),
          ),
        );

    }
}

