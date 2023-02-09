import 'package:flutter/material.dart';

import '../widgets/navigation_bar.dart';
import 'check_weather_screen.dart';

class AdditionalScreen extends StatefulWidget {
  const AdditionalScreen({Key? key}) : super(key: key);

  @override
  State<AdditionalScreen> createState() => _AdditionalScreenState();
}

class _AdditionalScreenState extends State<AdditionalScreen> {

  List<String> app_name = ["Weather", "Food"];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Additional'),
      ),
      bottomNavigationBar: MyBottomNavigationBar(selectedIndexNavBar: 3),
      body: SafeArea(
        child: GridView.builder(
          gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 2,
            crossAxisSpacing: 10,
            mainAxisSpacing: 10,
            childAspectRatio: 3 / 4,
          ),
          itemCount: 2,
          itemBuilder: (context, index){
            final app = app_name[index];
            return Container(
              margin: EdgeInsets.fromLTRB(0, 10, 0, 0),
              child: Column(
                children: [
                  // Image.network(food.image),
                  ClipOval(
                    child: Material(
                      color: Colors.blue, // Button color
                      child: InkWell(
                        splashColor: Colors.red, // Splash color
                        onTap: () {
                          if (app == "Weather"){
                            showModalBottomSheet(
                              isScrollControlled: true,
                              context: context,
                              builder: (BuildContext context) {
                                return SingleChildScrollView(
                                  child: Container(
                                    padding: EdgeInsets.only(
                                        bottom: MediaQuery.of(context).viewInsets.bottom),
                                    child: check_weather(),
                                  ),
                                );
                              },
                            );
                          }
                        },
                        child: SizedBox(width: 56, height: 56, child: app == "Weather" ? Icon(Icons.cloud) : Icon(Icons.food_bank)),
                      ),
                    ),
                  ),
                  Text(
                    "${app}",
                    textAlign: TextAlign.center,
                  ),

                ],
              ),
            );
          },
        ),
      ),

    );
  }
}

























