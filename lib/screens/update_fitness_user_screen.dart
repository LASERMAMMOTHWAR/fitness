import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:fitness/utilities/api_calls.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';

import '../models/fitness_user.dart';
import '../models/model_theme.dart';
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
  final age_snackbar = SnackBar(
    content: Text('Invalid Age!'),
  );
  final weight_snackbar = SnackBar(
    content: Text('Invalid Weight!'),
  );
  final height_snackbar = SnackBar(
    content: Text('Invalid Height!'),
  );
  final List<String> genderList = <String>['Male', 'Female'];
  final List<String> activityLevelList = <String> ['1', '2', '3', '4', '5', '6'];
  final List<String> goalList = <String> ['Maintain Weight', 'Mild Weight Loss', 'Weight Loss', 'Extreme Weight Loss', 'Mild Weight Gain', 'Weight Gain', 'Extreme Weight Gain'];
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
    'Maintain Weight': 'maintain weight',
    'Mild Weight Loss': 'Mild weight loss',
    'Weight Loss': 'Weight loss',
    'Extreme Weight Loss': 'Extreme weight loss',
    'Mild Weight Gain': 'Mild weight gain',
    'Weight Gain': 'Weight gain',
    'Extreme Weight Gain': 'Extreme weight gain',
  };

  void getKeysFromMap(Map map){
    map.keys.forEach((key) {
      goalList.add(key);
    });
  }



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


    return Consumer<ModelTheme>(
      builder: (context, ModelTheme themeNotifier, child) {
        return Scaffold(
          bottomNavigationBar: MyBottomNavigationBar(selectedIndexNavBar: 2),
          body: Container(
            height: double.infinity,
            width: double.infinity,
            decoration: BoxDecoration(
              color: themeNotifier.isDark ? Colors.grey[100] : Colors.white,
              image: DecorationImage(
                  image: themeNotifier.isDark ? AssetImage("images/fitness_bg1.jpeg") : AssetImage("images/fitness_bg.jpeg"),
                  fit: BoxFit.cover),
            ),
            child: SafeArea(
              child: Container(
                padding: EdgeInsets.all(10),
                // color: Colors.black12,
                decoration: BoxDecoration(
                  color: Colors.black12,
                  borderRadius: BorderRadius.circular(20),
                ),
                margin: EdgeInsets.all(20),
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
                            decoration: const InputDecoration(labelText: 'Age', ),
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
                          SizedBox(height: 10,),
                          Column(
                            children: [
                            Text("Gender"),
                            Padding(
                              padding: EdgeInsets.fromLTRB(20, 0, 0, 0),
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                                children: [
                                  Container(
                                    child:Row(
                                      children: [
                                        Text("Male"),
                                        Radio(
                                          value: "Male",
                                          groupValue: value_gender,
                                          onChanged: (value){
                                            setState(() {
                                              value_gender = value;
                                            });
                                          } ,),
                                      ],
                                    ) ,
                                  ),
                                  Container(
                                    child: Row(
                                      children: [
                                        Text("Female"),
                                        Radio(
                                          value: "Female",
                                          groupValue: value_gender,
                                          onChanged: (value){
                                            setState(() {
                                              value_gender = value;
                                            });
                                          } ,),
                                      ],
                                    ),
                                  ),

                                ],
                              ),
                              // child: DropdownButton<String>(
                              //   hint: Text("Gender"),
                              //   value: value_gender,
                              //   underline: Container(
                              //     height: 1,
                              //     color: Colors.white,
                              //   ),
                              //   items: genderList
                              //       .map((desc) => DropdownMenuItem(
                              //     value: desc,
                              //     child: Text(desc),
                              //   ))
                              //       .toList(),
                              //   onChanged: (value) {
                              //     setState(() {
                              //       value_gender = value!;
                              //     });
                              //   },
                              // ),
                            ),
                          ],),
                          Row(
                            children: [
                              Padding(
                                padding: EdgeInsets.fromLTRB(0, 0, 20, 0),
                                  child: Text("Activity Level"),
                              ),
                              DropdownButton<String>(
                                value: value_activity ,
                                underline: Container(
                                  height: 1,
                                  color: Colors.grey,
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
                                  value: value_goal,
                                  underline: Container(
                                    height: 1,
                                    color: Colors.grey,
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


                          Container(
                            margin: EdgeInsets.fromLTRB(20, 10, 20, 10),
                            height: 30,
                            child: ElevatedButton(
                              style: ButtonStyle(
                                  shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                                      RoundedRectangleBorder(
                                          borderRadius: BorderRadius.circular(18.0),
                                          side: BorderSide(color: Colors.blue)
                                      )
                                  )
                              ),
                              child: const Text('Save', style: TextStyle(fontSize: 25),),
                              onPressed: () {
                                if ((int.parse(ageController.text) < 0 || int.parse(ageController.text) > 80)){
                                  ScaffoldMessenger.of(context).showSnackBar(age_snackbar);
                                }
                                else if (int.parse(weightController.text) < 40 || int.parse(weightController.text) > 160) {
                                  ScaffoldMessenger.of(context).showSnackBar(weight_snackbar);
                                }
                                else if (int.parse(heightController.text) < 130 || int.parse(heightController.text) > 230){
                                  ScaffoldMessenger.of(context).showSnackBar(height_snackbar);
                                }
                                else{
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
                                }
                              },
                            ),
                          ),
                          Text("* Activity Level (Intensity), the higher it is, the more calories burned"),
                        ],
                      );
                    },
                  ),
                ),
              ),
            ),
          ),
        );
      }
    );
  }
}

String find_key_value(Map<String, String> maps, String data){
  var key = maps.keys.firstWhere((k) => maps[k] == data);
  return key;
}

