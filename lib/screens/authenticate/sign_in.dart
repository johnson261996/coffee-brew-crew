import 'package:coffee/services/auth.dart';
import 'package:coffee/shared/constants.dart';
import 'package:coffee/shared/loading.dart';
import 'package:flutter/material.dart';

class SignIn extends StatefulWidget {

  final Function toggleView;

  const SignIn({Key? key,required this.toggleView}) : super(key: key);

  @override
  _SignInState createState() => _SignInState();
}

class _SignInState extends State<SignIn> {
  final AuthService _authService = AuthService();

  final formkey = GlobalKey<FormState>();
  String error='';
  final AuthService _auth = AuthService();
  //text field state
  String email = '';
  String password = '';
  bool loading = false;


  @override
  Widget build(BuildContext context) {
    return loading ? Loading() : Scaffold(
      backgroundColor: Colors.brown[100],
      appBar: AppBar(
        backgroundColor: Colors.brown[300],
        elevation: 0.0,
        title: Text('Sign in Coffee Brew'),
        actions: <Widget>[
          FlatButton.icon(onPressed: (){
            widget.toggleView();
          }, icon: Icon(Icons.person), label: Text('Register'))
        ],
      ),
      body: Container(
        //padding: EdgeInsets.symmetric(vertical: 20.0,horizontal: 50.0),
        child: Form(
          key: formkey,
          child: Column(
            children:<Widget> [
              SizedBox(height: 20.0,),
              TextFormField( decoration: textInputDecoration,
                  validator: (val)=>val!.isEmpty? 'Enter an Email':null,
                onChanged: (val){
                  setState(() => email = val);
                }
              ),
              SizedBox(height: 20.0,),
              TextFormField(decoration: textInputDecoration2,
                validator: (val)=>val!.isEmpty? 'Enter an password':null,
                obscureText: true,
                onChanged: (val){
                  setState(() => password = val);
                },
              ),
              RaisedButton(
                color: Colors.pink,
                  child: Text(
                    'Sign in',
                    style: TextStyle(color: Colors.white),
                  ),
                  onPressed:() async{
                    if(formkey.currentState!.validate()){
                      setState(() => loading = true);
                      dynamic result = await _auth.signInEmailPassword(email, password);
                      if(result == null){
                        setState((){
                          error='could not sign in with wrong email and password';
                          loading = false;
                        });
                      }
                     print('valid');
                      print(email + "\n" + password);
                    }
                  }
              ),
              SizedBox(height: 12.0,),
              Text(error,style: TextStyle(color:Colors.pink,fontSize: 14.0),)

            ],
          ),
        )
        /* RaisedButton(
          onPressed: ()async {
            dynamic result = await _authService.signInAnon();
            if(result == null){
              print("error while Login");
            }else{
              print(" signed in");
              print(result);
            }
          },
          child: Text('Sign in anonymous '),
        ),*/
      ),
    );
  }
}
