import 'package:fitness/screens/contact_us.dart';
import 'package:fitness/screens/food_website.dart';
import 'package:fitness/screens/watch_video.dart';
import 'package:flutter/material.dart';
import 'package:fitness/models/model_theme.dart';
import 'package:provider/provider.dart';


import '../widgets/navigation_bar.dart';
import '../models/app_repository.dart';
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
              itemCount: AllApps().allAppsCount,
              itemBuilder: (context, index){
                final app_list = AllApps().allApps;
                final app = app_list[index];
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
                              if (app.name == "Weather"){
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
                              } else if (app.name == "Home Workout"){
                                showModalBottomSheet(
                                  isScrollControlled: true,
                                  context: context,
                                  builder: (BuildContext context) {
                                    return SingleChildScrollView(
                                      child: Container(
                                        padding: EdgeInsets.only(
                                            bottom: MediaQuery.of(context).size.width),
                                        child: Video_Player(),
                                      ),
                                    );
                                  },
                                );

                              } else if (app.name == "Food"){
                                showModalBottomSheet(
                                  isScrollControlled: true,
                                  context: context,
                                  builder: (BuildContext context) {
                                    return SingleChildScrollView(
                                      child: Container(
                                        padding: EdgeInsets.only(
                                            bottom: MediaQuery.of(context).viewInsets.bottom),
                                        child: Food_website(),
                                      ),
                                    );
                                  },
                                );
                              } else{
                                showModalBottomSheet(
                                  isScrollControlled: true,
                                  context: context,
                                  builder: (BuildContext context) {
                                    return SingleChildScrollView(
                                      child: Container(
                                        padding: EdgeInsets.only(
                                            bottom: MediaQuery.of(context).viewInsets.bottom),
                                        child: ContactUs(),
                                      ),
                                    );
                                  },
                                );
                              }
                            },
                            // child: SizedBox(width: 70, height: 70, child: app == "Weather" ? Icon(Icons.cloud, size: 45,) : app == "Food"  ? Icon(Icons.food_bank, size: 45) : Icon(Icons.work_outline, size: 45)),
                            child: SizedBox(width: 70, height: 70, child: app.icon,),
                          ),
                        ),
                      ),
                      Text(
                        "${app.name}",
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

























