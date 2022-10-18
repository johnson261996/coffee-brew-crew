import 'package:coffee/services/auth.dart';
import 'package:coffee/shared/constants.dart';
import 'package:coffee/shared/loading.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class Register extends StatefulWidget {

  final Function toggleView;

  const Register({Key? key,required this.toggleView}) : super(key: key);

  @override
  _RegisterState createState() => _RegisterState();
}

class _RegisterState extends State<Register> {

  final AuthService _auth = AuthService();
  final formkey = GlobalKey<FormState>();

  //text field state
  String email = '';
  String password = '';
  String error='';
  bool loading = false;

  @override
  Widget build(BuildContext context) {
    return loading ? Loading() : Scaffold(
        backgroundColor: Colors.brown[100],
        appBar: AppBar(
          backgroundColor: Colors.brown[300],
          elevation: 0.0,
          title: Text('Sign up in Coffee Brew'),
          actions: <Widget>[
            TextButton .icon(onPressed: (){
              widget.toggleView();
            }, icon: Icon(Icons.person,color: Colors.white,), label: Text('Sign in',style:TextStyle(color: Colors.white,),))
          ],
        ),
        body: Container(
            //padding: EdgeInsets.symmetric(vertical: 20.0,horizontal: 50.0),
        child: Form(
          key:formkey,
          child: Column(
            children: <Widget>[
              SizedBox(
                height: 20.0,
              ),
              TextFormField(
                  decoration: textInputDecoration,
                  validator: (val)=>val!.isEmpty? 'Enter an Email':null,
                  onChanged: (val) {
                setState(() => email = val);
              }),
              SizedBox(
                height: 20.0,
              ),
              TextFormField(
                decoration: textInputDecoration2,
                validator: (val)=>val!.length < 6? 'Enter the password 6 char':null,
                obscureText: true,
                onChanged: (val) {
                  setState(() => password = val);
                },
              ),
              TextButton (
                  style: TextButton.styleFrom(
                    foregroundColor: Colors.pink,
                    backgroundColor: Colors.brown,
                    textStyle: const TextStyle(fontSize: 20),
                  ),
                  child: Text(
                    'Sign up',
                    style: TextStyle(color: Colors.white),
                  ),
                  onPressed: () async {
                    if(formkey.currentState!.validate()){
                      setState(() => loading = true);
                      dynamic result = await _auth.registerEmailPassword(email, password);
                      if(result==null){

                        setState((){
                          error = 'please supply a valid email';
                          loading = false;
                        });
                      }
                      print(email + "\n" + password);
                    }

                  }),
              SizedBox(height: 12.0,),
              Text(error,style: TextStyle(color:Colors.pink,fontSize: 14.0),)
            ],
          ),
        )));
  }
}
