import 'package:coffee/models/PersonData.dart';
import 'package:coffee/services/DatabaseService.dart';
import 'package:coffee/shared/loading.dart';
import 'package:flutter/material.dart';
import 'package:coffee/shared/constants.dart';
import 'package:provider/provider.dart';
import '../../../models/Person.dart';

class SettingForm extends StatefulWidget {
  const SettingForm({Key? key}) : super(key: key);

  @override
  _SettingFormState createState() => _SettingFormState();
}

class _SettingFormState extends State<SettingForm> {

  final formKey = GlobalKey<FormState>();
  final List<String> sugars = ['0','1','2','3','4'];

  //form values
  String? currentname;
  String? currentsugar;
   int? currentstrength=100;


  @override
  Widget build(BuildContext context) {
    final user = Provider.of<Person?>(context);
    return StreamBuilder<PersonData>(
      stream: DatabaseServvice(uid: user?.uid).userData,
      builder: (context, snapshot) {
        print("snapshot:" + snapshot.hasData.toString());

        if(snapshot.hasData){
          PersonData? personData = snapshot.data;
          return Form(
            key: formKey,
            child: Column(
              children: <Widget>[
                Text('update your brew settings',style: TextStyle(fontSize: 18.0),),
                SizedBox(height: 20.0,),

                TextFormField(
                  initialValue: personData?.name,
                  decoration: textInputDecoration3,
                  validator: (val) => val!.isEmpty? 'please Enter a name':null,
                  onChanged: (val) => setState(() => currentname = val),
                ),

                SizedBox(height: 20.0,),

                //dropdown sugar
                DropdownButtonFormField(
                  decoration: textInputDecoration4,
                  value: currentsugar ?? personData?.sugars,
                  items: sugars.map((sugar){
                    return DropdownMenuItem(
                      value: sugar,
                      child: Text('$sugar sugars'),
                    );
                  }).toList(), onChanged: (String? value) {
                  setState(() {
                    currentsugar = value;
                  });
                },
                ),

                //slider
                Slider(
                  min: 100,
                  max: 900,
                  activeColor: Colors.brown[currentstrength ?? personData!.strength],
                  inactiveColor: Colors.brown[currentstrength ?? personData!.strength],
                  divisions: 8,
                  onChanged: (val) => setState(() => currentstrength = val.toInt()),
                  value: (currentstrength??personData!.strength).toDouble(),
                ),

                RaisedButton(
                  color: Colors.pinkAccent,
                  onPressed: () async {
                  if(formKey.currentState!.validate()){
                    await DatabaseServvice(uid: user?.uid).updateUserData(
                    currentsugar?? personData?.sugars,
                    currentname ?? personData?.name,
                    currentstrength?? personData?.strength);
                  }
                  Navigator.pop(context);
                  },
                  child: Text(
                    'update',style: TextStyle(color: Colors.white),
                  ),)

              ],
            ),

          );
        } else {
          return Loading();
        }


      }
    );
  }
}
