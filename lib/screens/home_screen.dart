import 'package:fitness/utilities/api_calls.dart';
import 'package:flutter/material.dart';

import '../models/bmi.dart';
import '../utilities/firebase_calls.dart';
import '../widgets/navigation_bar.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Fitness'),
        actions: [
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
        child: Column(
          children: [
            Text('Welcome ${auth.currentUser?.displayName}'),
            FutureBuilder(
              future: ApiCalls().fetchBmi(fitnessUser),
              builder: (context,snapshot){
                if (snapshot.hasData){
                  return Column(
                    children: [
                      Text(
                        'Your BMI is ${snapshot.data!.bmi}',
                      ),
                      Text(
                        '${snapshot.data!.health}'
                      ),
                      Text(
                        'Healthy BMI Range: ${snapshot.data!.healthyBmiRange}'
                      )
                    ],
                  );
                }
                return CircularProgressIndicator();
              },
            ),
            FutureBuilder(
              future: ApiCalls().fetchDailyCalorie(fitnessUser),
              builder: (context, snapshot){
                if (snapshot.hasData){
                  return Column(
                    children: [
                      Text("Your Daily Calorie is ${snapshot.data!.toStringAsFixed(2)}")
                    ],
                  );
                }
                return CircularProgressIndicator();
              },
            )


            //TODO widget to show bmi, health and healthyBmiRange
            //TODO widget to show daily calorie requirement of user
          ],
        ),
      ),
    );
  }
}
