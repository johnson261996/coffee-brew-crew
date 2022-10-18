
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:coffee/models/PersonData.dart';
import 'package:coffee/models/brew.dart';

class DatabaseServvice {

  final String uid;
  final CollectionReference brewCollection = FirebaseFirestore.instance.collection("brews");

  DatabaseServvice({ required this.uid});

  Future updateUserData(String? sugars,String? name,int? strength)async{
    return await brewCollection.doc(uid).set({
      'sugars': sugars,
      'name': name,
      'strength': strength,
    });
  }

  //brew list from snapshot
  List<Brew> brewListFromSnapshot(QuerySnapshot snapshot){
    try{
      return snapshot.docs.map((doc) {
        return Brew(
            name:doc.get('name') ?? '',
            strength: doc.get('strength')?? 0,
            sugars: doc.get('sugars')?? ''
        );
      }).toList();
    }catch(e){
      print(e.toString());
      return [];
    }

  }

  List<Brew> brewListSnapshot(QuerySnapshot snapshot){
    return snapshot.docs.map((doc){
      return Brew(
          name:doc.get('name') ?? '',
          strength: doc.get('strength')?? 0,
          sugars: doc.get('sugars')?? ''
      );
    }).toList();
  }

  //userdata from snapshot

  PersonData userDataFromSnapshot(DocumentSnapshot snapshot){
    return PersonData(
      uid: uid,
      name: snapshot.get('name'),
      sugars: snapshot.get('sugars'),
      strength: snapshot.get('strength'),
    );
  }

  //get brews data
 Stream<List<Brew>?> get brews {
    return brewCollection.snapshots().map(brewListFromSnapshot);
 }

 //get user doc stream
 Stream<PersonData> get userData {
    return brewCollection.doc(uid).snapshots().
   map(userDataFromSnapshot);
 }

 //get user doc stream


}