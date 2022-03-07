import 'package:coffee/screens/authenticate/register.dart';
import 'package:coffee/screens/authenticate/sign_in.dart';
import 'package:flutter/material.dart';


class Authenticate extends StatefulWidget {
  @override
  _AuthenticateState createState() => _AuthenticateState();
}

class _AuthenticateState extends State<Authenticate> {

  bool showSignin = true;
  void toggleView(){
    setState(() => showSignin = !showSignin);
  }

  @override
  Widget build(BuildContext context) {
    if(showSignin){
      return Container(
        child: SignIn(toggleView:toggleView),
      );
    }else{
      return Container(
        child: Register(toggleView:toggleView),
      );
    }

  }
}


