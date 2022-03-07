import 'package:flutter/material.dart';
import 'package:coffee/models/brew.dart';
import 'package:provider/provider.dart';

class BrewTile extends StatelessWidget {
  final Brew brew;
  const BrewTile({required this.brew,Key? key}) : super(key: key);


  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Padding(
      padding: EdgeInsets.only(top:8.0),
      child: Card(
        margin: EdgeInsets.fromLTRB(20.0, 6.0, 20.0, 0.0),
        child: ListTile(
          leading: CircleAvatar(
            radius: 25.0,
            backgroundColor: Colors.brown[brew.strength],
            backgroundImage: AssetImage('assets/coffee_icon.png'),
          ),
          title: Text(brew.name),
          subtitle: Text("take ${brew.sugars} sugar"),
        ),
      ),
    );
  }
}


