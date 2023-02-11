import 'package:fitness/screens/watch_video.dart';
import 'package:flutter/material.dart';
import 'package:fitness/models/model_theme.dart';
import 'package:provider/provider.dart';


import '../widgets/navigation_bar.dart';
import 'check_weather_screen.dart';

class AdditionalScreen extends StatefulWidget {
  const AdditionalScreen({Key? key}) : super(key: key);

  @override
  State<AdditionalScreen> createState() => _AdditionalScreenState();
}

class _AdditionalScreenState extends State<AdditionalScreen> {

  List<String> app_name = ["Weather", "Food", "Home Workout"];

  @override
  Widget build(BuildContext context) {
    return Consumer<ModelTheme>(
      builder: (context, ModelTheme themeNotifier, child) {
        return Scaffold(
          appBar: AppBar(
            backgroundColor: !themeNotifier.isDark ? Colors.blue[900] : Colors.black12,
            title: const Text('Additional'),
          ),
          bottomNavigationBar: MyBottomNavigationBar(selectedIndexNavBar: 3),
          body: SafeArea(
            child: GridView.builder(
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 2,
                crossAxisSpacing: 10,
                mainAxisSpacing: 10,
              ),
              itemCount: app_name.length,
              itemBuilder: (context, index){
                final app = app_name[index];
                return Container(
                  margin: EdgeInsets.fromLTRB(0, 10, 0, 0),
                  child: Column(
                    children: [
                      // Image.network(food.image),
                      ClipOval(
                        child: Material(
                          color: themeNotifier.isDark ? Colors.blue[600] : Colors.blue[900], // Button color
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
                              } else if (app == "Home Workout"){
                                showModalBottomSheet(
                                  isScrollControlled: true,
                                  context: context,
                                  builder: (BuildContext context) {
                                    return SingleChildScrollView(
                                      child: Container(
                                        padding: EdgeInsets.only(
                                            bottom: MediaQuery.of(context).viewInsets.vertical),
                                        child: Video_Player(),
                                      ),
                                    );
                                  },
                                );

                              }
                            },
                            child: SizedBox(width: 70, height: 70, child: app == "Weather" ? Icon(Icons.cloud, size: 45,) : app == "Food"  ? Icon(Icons.food_bank, size: 45) : Icon(Icons.work_outline, size: 45)),
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
    );
  }
}

























