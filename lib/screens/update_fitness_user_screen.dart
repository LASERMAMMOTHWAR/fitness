import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:fitness/utilities/api_calls.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import '../models/fitness_user.dart';
import '../widgets/navigation_bar.dart';
import '../utilities/firebase_calls.dart';

class UpdateFitnessUserScreen extends StatefulWidget {
  const UpdateFitnessUserScreen({Key? key}) : super(key: key);

  @override
  State<UpdateFitnessUserScreen> createState() =>
      _UpdateFitnessUserScreenState();
}

class _UpdateFitnessUserScreenState extends State<UpdateFitnessUserScreen> {
  //TODO add gender, activityLevel, goal throughout this screen
  final List<String> genderList = <String>['Male', 'Female'];
  final List<String> activityLevelList = <String> ['1', '2', '3', '4', '5', '6'];
  final List<String> goalList = <String> ['maintain', 'mildlose', 'weightlose', 'extremelose', 'mildgain', 'weightgain', 'extremegain'];
  final Map<String, String> gender =
  {
    'Male': 'male',
    'Female': 'female',
  };

  final Map<String, String> activityLevel =
  {
    '1': 'level_1',
    '2': 'level_2',
    '3': 'level_3',
    '4': 'level_4',
    '5': 'level_5',
    '6': 'level_6',
  };

  final Map<String, String> goal =
  {
    'maintain': 'maintain weight',
    'mildlose': 'Mild weight loss',
    'weightlose': 'Weight loss',
    'extremelose': 'Extreme weight loss',
    'mildgain': 'Mild weight gain',
    'weightgain': 'Weight gain',
    'extremegain': 'Extreme weight gain',
  };



  TextEditingController ageController = TextEditingController();
  TextEditingController weightController = TextEditingController();
  TextEditingController heightController = TextEditingController();
  TextEditingController Stored_agecontroller = TextEditingController();
  String? value_gender;
  String? value_activity ;
  String? value_goal ;
  String? Stored_gender;
  String? Stored_activity;
  String? Stored_goal;

  @override
  Widget build(BuildContext context) {


    return Scaffold(
      bottomNavigationBar: MyBottomNavigationBar(selectedIndexNavBar: 2),
      body: SafeArea(
        child: SingleChildScrollView(
          child: StreamBuilder<QuerySnapshot>(
            stream: fitnessUsersCollection
                .where('userid', isEqualTo: auth.currentUser?.uid)
                .snapshots(),
            builder: (context, snapshot) {
              if (snapshot.hasData) {
                if (snapshot.data!.docs.isNotEmpty) {
                  QueryDocumentSnapshot doc = snapshot.data!.docs[0];
                  Stored_gender = find_key_value(gender, doc.get('gender').toString());
                  Stored_activity = find_key_value(activityLevel, doc.get('activityLevel').toString());
                  Stored_goal = find_key_value(goal, doc.get('goal').toString());

                  if (value_gender == null && value_activity == null && value_goal == null){
                    value_gender = Stored_gender;
                    value_activity = Stored_activity;
                    value_goal = Stored_goal;
                    ageController.text = doc.get('age').toString();
                    weightController.text = doc.get('weight').toString();
                    heightController.text = doc.get('height').toString();
                  }


                } else{
                  value_gender = 'Male';
                  value_activity = '1';
                  value_goal = 'maintain';

                }
              }
              return Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: <Widget>[
                  const Text(
                    'Update Fitness User',
                    textAlign: TextAlign.center,
                  ),
                  TextField(
                    textAlign: TextAlign.center,
                    decoration: const InputDecoration(labelText: 'Age'),
                    keyboardType: TextInputType.number,
                    inputFormatters: <TextInputFormatter>[
                      FilteringTextInputFormatter.digitsOnly
                    ],
                    controller: ageController,
                  ),
                  TextField(
                    textAlign: TextAlign.center,
                    decoration: const InputDecoration(labelText: 'Weight'),
                    keyboardType: TextInputType.number,
                    inputFormatters: <TextInputFormatter>[
                      FilteringTextInputFormatter.digitsOnly
                    ],
                    controller: weightController,
                  ),
                  TextField(
                    textAlign: TextAlign.center,
                    decoration: const InputDecoration(labelText: 'Height'),
                    keyboardType: TextInputType.number,
                    inputFormatters: <TextInputFormatter>[
                      FilteringTextInputFormatter.digitsOnly
                    ],
                    controller: heightController,
                  ),
                  // dropDownWidget(Value_: value_gender, list_select: genderList),
                  // dropDownWidget(Value_: value_activity, list_select: activityLevelList),
                  // dropDownWidget(Value_: value_goal, list_select: goalList),
                  Row(
                    children: [
                    Text("Gender"),
                    Padding(
                      padding: EdgeInsets.fromLTRB(20, 0, 0, 0),
                      child: DropdownButton<String>(
                        hint: Text("Gender"),
                        value: value_gender,
                        underline: Container(
                          height: 2,
                          color: Colors.white,
                        ),
                        items: genderList
                            .map((desc) => DropdownMenuItem(
                          value: desc,
                          child: Text(desc),
                        ))
                            .toList(),
                        onChanged: (value) {
                          setState(() {
                            value_gender = value!;
                          });
                        },
                      ),
                    ),
                  ],),
                  Row(
                    children: [
                      Padding(
                        padding: EdgeInsets.fromLTRB(0, 0, 20, 0),
                          child: Text("Activity Level"),
                      ),
                      DropdownButton<String>(
                        hint: Text("Activity Level"),
                        value: value_activity ,
                        underline: Container(
                          height: 2,
                          color: Colors.white,
                        ),
                        items: activityLevelList
                            .map((desc) => DropdownMenuItem(
                          value: desc,
                          child: Text(desc),
                        ),)
                            .toList(),
                        onChanged: (value) {
                          setState(() {
                            value_activity = value!;
                          });
                        },
                      ),
                    ],
                  ),
                  Row(
                    children: [
                      Text("Goals"),
                      Padding(
                        padding: EdgeInsets.fromLTRB(20, 0, 0, 0),
                        child: DropdownButton<String>(
                          hint: Text("Goals"),
                          value: value_goal,
                          underline: Container(
                            height: 2,
                            color: Colors.white,
                          ),
                          items: goalList
                              .map((desc) => DropdownMenuItem(
                            value: desc,
                            child: Text(desc),
                          ))
                              .toList(),
                          onChanged: (value) {
                            setState(() {
                              value_goal = value!;
                            });
                          },
                        ),
                      ),
                    ],
                  ),


                  ElevatedButton(
                    child: const Text('Save'),
                    onPressed: () {
                      fitnessUser = FitnessUser(
                        age: int.parse(ageController.text),
                        weight: int.parse(weightController.text),
                        height: int.parse(heightController.text),
                        gender: gender[value_gender].toString(),
                        // gender: dropDownWidget(Value_: value_gender, list_select: genderList).Value_.toString(),
                        goal: goal[value_goal].toString(),
                        activityLevel: activityLevel[value_activity].toString(),

                      );
                      FirebaseCalls().updateFitnessUser(fitnessUser);
                      Navigator.pushReplacementNamed(context, '/home');
                    },
                  ),
                ],
              );
            },
          ),
        ),
      ),
    );
  }
}

String find_key_value(Map<String, String> maps, String data){
  var key = maps.keys.firstWhere((k) => maps[k] == data);
  return key;
}
//
// class dropDownWidget extends StatefulWidget {
//   dropDownWidget({Key? key,
//     required this.Value_,
//     required this.list_select,
//
//   }) : super(key: key);
//
//   String? Value_;
//   List<String> list_select;
//
//   @override
//   State<dropDownWidget> createState() => _dropDownWidgetState();
// }
//
// class _dropDownWidgetState extends State<dropDownWidget> {
//   @override
//   Widget build(BuildContext context) {
//     return DropdownButton(
//         value: widget.Value_ ?? widget.list_select.first,
//         items: widget.list_select.map((Map_info) => DropdownMenuItem(
//           value: Map_info,
//           child: Text(Map_info),
//         )).toList(),
//       onChanged: (value){
//           setState(() {
//             widget.Value_ = value!;
//           });
//       },
//
//     );
//   }
// }





// DropdownButton<String>(
//   value: value_gender ?? genderList.first,
//   items: genderList.map((desc) => DropdownMenuItem(value: desc, child: Text(desc),)).toList(),
//   onChanged: (value){
//     setState(() {
//       value_gender = value!;
//     });
//   },
// ),
// DropdownButton<String>(
//   value: value_activity ?? activityLevelList.first,
//   items: activityLevelList.map((desc) => DropdownMenuItem(value: desc, child: Text(desc),)).toList(),
//   onChanged: (value){
//     setState(() {
//       value_activity = value!;
//     });
//   },
// ),
// DropdownButton<String>(
//   value: value_goal ?? goalList.first,
//   items: goalList.map((desc) => DropdownMenuItem(value: desc, child: Text(desc),)).toList(),
//   onChanged: (value){
//     setState(() {
//       value_goal = value!;
//       print(value_goal);
//     });
//   },
// ),