import 'package:coffee/models/brew.dart';
import 'package:coffee/screens/authenticate/home/brew_list.dart';
import 'package:coffee/screens/authenticate/home/settings_form.dart';
import 'package:coffee/services/auth.dart';
import 'package:flutter/material.dart';
import 'package:coffee/services/DatabaseService.dart';
import 'package:provider/provider.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

import '../../../models/Person.dart';

class Home extends StatelessWidget {

  final ButtonStyle raisedButtonStyle = ElevatedButton.styleFrom(
    onPrimary: Colors.black87,
    primary: Colors.brown[300],
    minimumSize: Size(88, 36),
    padding: EdgeInsets.symmetric(horizontal: 0),
  );

  final AuthService auth = AuthService();

  @override
  Widget build(BuildContext context) {
    final user = Provider.of<Person?>(context);
    void ShowSettingPanel() {
      showModalBottomSheet(context: context, builder: (context){
        return Container(
          padding: EdgeInsets.symmetric(vertical: 20.0,horizontal: 60.0),
          child: SettingForm(),
        );
      });
    }


    return StreamProvider<List<Brew>?>.value(
      value: DatabaseServvice(uid:user!.uid ).brews,
      initialData: null,
      child: Scaffold(
        backgroundColor: Colors.brown[50],
        appBar: AppBar(
          title: Text('home'),
          backgroundColor: Colors.brown[300],
          elevation: 0.0,
          actions:<Widget> [

            /*ElevatedButton(
              style: raisedButtonStyle,
              onPressed: () async{
                await auth.signOut();
              },

              child: Wrap(
                children: <Widget>[
                  Icon(
                    Icons.logout,
                    size: 24.0,
                  ),
                  SizedBox(
                    width:10,
                  ),
                  Text("Log out!", style:TextStyle(fontSize:20)),
                ],
              ),
            ),*/
            TextButton.icon(
                onPressed: ()async {
                  await auth.signOut();
                },
                icon: Icon(Icons.logout,color: Colors.white,),
                label: Text('Log out!',style: TextStyle(color: Colors.white))
            ),
            TextButton.icon(
                onPressed: (){
                  ShowSettingPanel();
                },
                icon: Icon(Icons.settings,color: Colors.white),
                label: Text('setting',style: TextStyle(color: Colors.white,),)
            )
          ],
        ),
        body:Container
          (
            decoration: BoxDecoration(
                image: DecorationImage(
                    image: AssetImage("assets/coffee_bg.png"), fit: BoxFit.cover)),
            child: BrewList()
        ),
      ),
    );
  }


}
