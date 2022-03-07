import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:coffee/models/brew.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:flutter/cupertino.dart';

import 'BrewTile.dart';

class BrewList extends StatefulWidget {
  const BrewList({Key? key}) : super(key: key);

  @override
  _BrewListState createState() => _BrewListState();
}


class _BrewListState extends State<BrewList> {

  @override
  Widget build(BuildContext context) {
    final brews = Provider.of<List<Brew>?>(context)??[];
    print("Brew list"+  brews.length.toString());
    return ListView.builder(itemCount: brews.length,
      itemBuilder: (context,index){
        var local = brews;
        if (local != null) {
          print("brew Length:" + brews.length.toString());
          return BrewTile(brew: brews[index] );
        }else{
          return Container(
            decoration: new BoxDecoration(
              color: Colors.green,
                border: Border.all(
                    style: BorderStyle.solid,
                    color: Colors.white)),
              child: Center(child: Text("This is Expanded")
            ),
          );
        }

      }


    );
  }
}
