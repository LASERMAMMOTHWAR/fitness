import 'package:fitness/models/exercise.dart';
import 'package:fitness/utilities/api_calls.dart';
import 'package:fitness/utilities/firebase_calls.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import '../models/exercise_type.dart';


class AddExerciseScreen extends StatefulWidget {
  const AddExerciseScreen({Key? key}) : super(key: key);

  @override
  State<AddExerciseScreen> createState() => _AddExerciseScreenState();

}


class _AddExerciseScreenState extends State<AddExerciseScreen> {
  final TextEditingController durationController = TextEditingController();

  //TODO Shortlist your exercises
  final List<ExerciseType> _exercises = <ExerciseType>[
    ExerciseType(id: 'ru_5', description: 'Running, 4 mph (13 min/mile)'),
    ExerciseType(id: 'ru_6', description: 'Running, 5 mph (12 min/mile)'),
    ExerciseType(id: 'ru_7', description: 'Running, 5.2 mph (11.5 min/mile)'),
    ExerciseType(id: 'ru_8', description: 'Running, 6 mph (10 min/mile)'),
    ExerciseType(id: 'sp_113', description: 'Volleyball'),
    ExerciseType(id: 'sp_12', description: 'Billiards'),
    ExerciseType(id: 'sp_29', description: 'Fencing'),
    ExerciseType(id: 'sp_89', description: 'Rollerblading, in-line skating, 14.4 km/h (9.0 mph), recreational pace'),
  ];

  ExerciseType? _selectedExercise;

  @override
  Widget build(BuildContext context) {
    return Container(
        padding: const EdgeInsets.all(20.0),
        decoration: BoxDecoration(
        color: Colors.grey[800],
        borderRadius: BorderRadius.only(
        topRight: Radius.circular(20.0),
        topLeft: Radius.circular(20.0),
        ),
        ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text("Choose your activity: "),
              SizedBox(height: 10,),
              DropdownButton<ExerciseType>(
                isExpanded: true,
                underline: Container(
                  height: 1,
                  color: Colors.grey,
                ),
                value: _selectedExercise,
                items: _exercises
                    .map(
                      (desc) => DropdownMenuItem(
                    value: desc,
                    child: Text(desc.description,),
                  ),
                )
                    .toList(),
                onChanged: (value) {
                  setState(() {
                    _selectedExercise = value!;
                  });
                },
              ),
            ],
          ),
          TextField(
            textAlign: TextAlign.center,
            decoration: const InputDecoration(
              enabledBorder: UnderlineInputBorder(
                borderSide: BorderSide(color: Colors.grey),
              ),
                labelText: 'Duration',
            ),
            keyboardType: TextInputType.number,
            inputFormatters: <TextInputFormatter>[
              FilteringTextInputFormatter.digitsOnly
            ],
            controller: durationController,
          ),
          ElevatedButton(
            child: const Text("ADD"),
            onPressed: () async {
              // if (durationController.text.runtimeType == String){
              //   print("Test1111");
              // }
              double burned_calo = await ApiCalls().fetchBurnedCalories(_selectedExercise!.id, double.parse(durationController.text), fitnessUser.weight);
              FirebaseCalls().addExercise(Exercise(id: _selectedExercise!.id, description: _selectedExercise!.description, duration: int.parse(durationController.text), burnedCalories: burned_calo));
              Navigator.pop(context);
              //TODO ApiCalls().fetchBurnedCalories()
              //TODO FirebaseCalls().addExercise()
            },
          ),
        ],
      ),
    );
  }
}
