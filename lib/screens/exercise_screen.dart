import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

import '../widgets/navigation_bar.dart';
import '../screens/add_exercise_screen.dart';
import '../utilities/firebase_calls.dart';

class ExerciseScreen extends StatefulWidget {
  const ExerciseScreen({Key? key}) : super(key: key);

  @override
  State<ExerciseScreen> createState() => _ExerciseScreenState();
}

class _ExerciseScreenState extends State<ExerciseScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      bottomNavigationBar: MyBottomNavigationBar(selectedIndexNavBar: 1),
      body: SafeArea(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Expanded(
              child: StreamBuilder<QuerySnapshot>(
                stream: exercisesCollection.where('userid', isEqualTo: auth.currentUser?.uid).snapshots(),
                builder: (context,snapshot){
                  if (snapshot.hasData && snapshot.data!.docs.length > 0){
                    print(snapshot.data!.docs[0]);
                    return ListView.builder(
                      scrollDirection: Axis.vertical,
                      shrinkWrap: true,
                      itemCount: snapshot.data!.docs.length,
                      itemBuilder: (context,index){
                        final Exercise =snapshot.data!.docs[index];
                        QueryDocumentSnapshot doc = snapshot.data!.docs[index];
                        return Dismissible(
                          key: Key(doc.id),
                          onDismissed: (direction){
                            FirebaseCalls().deleteExercise(doc.id);
                          },
                          child: ListTile(
                            onLongPress: () => FirebaseCalls().deleteExercise(doc.id),
                            title: Text(doc['description']),
                            subtitle: Text("${doc['duration']} mins"),
                            trailing: Text('${doc['burnedCalories']}'),
                          ),
                        );
                        // return Text(doc['description']);
                        },
                    );
                  } else{
                    return Text("You don't have any exercises yet!");
                  }
                },
              ),
            ),
            //TODO StreamBuilder to show documents in exercises collection
            Container(
              width: double.infinity,
              child: ElevatedButton(
                onPressed: () {
                  showModalBottomSheet(
                    isScrollControlled: true,
                    context: context,
                    builder: (BuildContext context) {
                      return SingleChildScrollView(
                        child: Container(
                          padding: EdgeInsets.only(
                              bottom: MediaQuery.of(context).viewInsets.bottom),
                          child: AddExerciseScreen(),
                        ),
                      );
                    },
                  );
                },
                child: Text('Add Exercise'),
              ),
            ),
            Container(
              width: double.infinity,
              child: ElevatedButton(
                child:const Text("Delete all Exercises") ,
                onPressed: (){
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
