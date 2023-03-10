import 'package:fitness/models/model_theme.dart';
import 'package:fitness/utilities/api_calls.dart';
import 'package:flutter/material.dart';
import  'package:intl/intl.dart';
import 'package:percent_indicator/linear_percent_indicator.dart';
import 'package:provider/provider.dart';



import 'dart:async';

import '../models/model_theme.dart';
import '../utilities/mytheme_preferences.dart';
import '../models/bmi.dart';
import '../utilities/firebase_calls.dart';
import '../widgets/navigation_bar.dart';
import '../utilities/constants.dart';





class HomeScreen extends StatefulWidget {
   const HomeScreen({Key? key}) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();



}

class _HomeScreenState extends State<HomeScreen> {
  final congrats_snackbar = SnackBar(
    content: Text('Congrats on Completeing your Goal!'),
  );
  @override
  Widget build(BuildContext context) {
    return Consumer<ModelTheme>(
      builder: (context, ModelTheme themeNotifier, child) {
        return Scaffold(
          appBar: AppBar(
            backgroundColor: !themeNotifier.isDark ? Colors.blue[900] : Colors.black12,
            title: const Text('Fitness'),
            actions: [
              IconButton(onPressed: (){
                themeNotifier.isDark = !themeNotifier.isDark;
              }, icon: Icon(themeNotifier.isDark ? Icons.nightlight_round : Icons.wb_sunny)),
              IconButton(
                onPressed: () {
                  auth.signOut();
                  Navigator.pushReplacementNamed(context, '/');
                },
                icon: const Icon(Icons.logout),
              ),
            ],
          ),
          bottomNavigationBar: MyBottomNavigationBar(selectedIndexNavBar: 0),
          body: SafeArea(
            child: Padding(
              padding: EdgeInsets.fromLTRB(10, 10, 10, 0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  DateWidget(),
                  Text(
                      "Summary",
                    style: kTitle(themeNotifier.isDark),
                  ),
                  Text(
                    'Welcome ${auth.currentUser?.displayName}',
                    style: kUserGreet,
                  ),
                  BMI_widget(Themeis_dark: themeNotifier.isDark),
                  FutureBuilder(
                    future: FirebaseCalls().totalCalories(),
                    builder: (context, snapshot){
                      if (snapshot.hasData)  {
                        double value_ = snapshot.data!;
                        if (value_ > 1){
                          return Container(
                            margin: EdgeInsets.fromLTRB(0, 10, 0, 0),
                            child: Column(
                              children: [
                                LinearPercentIndicator(
                                  width: MediaQuery.of(context).size.width - 50,
                                  animation: true,
                                  lineHeight: 20.0,
                                  animationDuration: 2000,
                                  percent: 1,
                                  center: Text("100%"),
                                  progressColor: Colors.greenAccent,
                                ),
                                Text("Congrats on Completeing your Goals!")
                              ],
                            ),
                          );

                        } else{
                          return Container(
                            margin: EdgeInsets.fromLTRB(0, 10, 0, 0),
                            child: LinearPercentIndicator(
                              width: MediaQuery.of(context).size.width - 20,
                              animation: true,
                              lineHeight: 20.0,
                              animationDuration: 2000,
                              percent: value_,
                              center: Text("${(value_*100).toStringAsFixed(2)}%"),
                              progressColor: Colors.greenAccent,
                            ),
                          );
                        }
                      }
                      return CircularProgressIndicator();
                    },
                  ),


                  //TODO widget to show bmi, health and healthyBmiRange
                  // TODO widget to show daily calorie requirement of user
                ],
              ),
            ),
          ),
        );
      }
    );
  }
}

class DateWidget extends StatefulWidget{
  @override
  _DateWidgetState createState()=> _DateWidgetState();

}

class _DateWidgetState extends State
{
  late String _timeString;

  @override
  void initState(){
    _timeString = "${DateTime.now().hour} : ${DateTime.now().minute} :${DateTime.now().second}";
    Timer.periodic(Duration(seconds:1), (Timer t)=>_getCurrentTime());
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Text(
            "${DateFormat("EEEE, MMM dd").format(DateTime.now()).toUpperCase()}",
          style: kDate,
        )
      ],
    );
  }

  void _getCurrentTime()  {
    setState(() {
      _timeString = "${DateTime.now().hour} : ${DateTime.now().minute} :${DateTime.now().second}";
    });
  }
}

class BMI_widget extends StatelessWidget {
   BMI_widget({Key? key,
    required this.Themeis_dark,
  }) : super(key: key);

   bool Themeis_dark;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.fromLTRB(10, 10, 0, 10),
      alignment: Alignment.centerLeft,
      decoration: BoxDecoration(
          color: Themeis_dark ? Colors.grey[800]: Colors.grey[600],
          borderRadius: BorderRadius.only(
            topLeft: Radius.circular(20.0),
            topRight: Radius.circular(20.0),
            bottomLeft: Radius.circular(20.0),
            bottomRight: Radius.circular(20.0),
          )
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          FutureBuilder(
            future: ApiCalls().fetchBmi(fitnessUser),
            builder: (context,snapshot){
              if (snapshot.hasData){
                return Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    SizedBox(height: 10,),
                    const Text(
                      "Your BMI: ",
                    ),
                    Text(
                      '${snapshot.data!.bmi}',
                      style: kBmi_info(Themeis_dark),
                    ),
                    SizedBox(height: 10,),
                    const Text(
                      "Weight Status: ",
                    ),
                    Text(
                      snapshot.data!.health,
                      style: kBmi_info(Themeis_dark),
                    ),
                    SizedBox(height: 10,),
                    const Text(
                      "Healthy BMI Range: ",
                    ),
                    Text(
                      snapshot.data!.healthyBmiRange,
                      style: kBmi_info(Themeis_dark),
                    ),

                  ],
                );
              }
              return CircularProgressIndicator();
            },
          ),
          SizedBox(height: 10,),
          FutureBuilder(
            future: ApiCalls().fetchDailyCalorie(fitnessUser),
            builder: (context, snapshot){
              if (snapshot.hasData){
                return Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text("Daily Calorie is: "),
                    Text(
                      '${snapshot.data!.toStringAsFixed(2)}',
                      style: kDaily_calo(Themeis_dark),
                    ),
                    SizedBox(height: 10,),
                  ],
                );
              }
              return CircularProgressIndicator();
            },
          ),


        ],
      ),
    );
  }
}
