import 'package:fitness/utilities/api_calls.dart';
import 'package:flutter/material.dart';
import 'package:fitness/models/model_theme.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';


import '../models/weather.dart';
import '../utilities/constants.dart';

class check_weather extends StatelessWidget {
  const check_weather({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Consumer<ModelTheme>(
      builder: (context, ModelTheme themeNotifier, child) {
        return Container(
          height: MediaQuery.of(context).size.width,
          padding: const EdgeInsets.all(20.0),
          decoration: BoxDecoration(
            color: themeNotifier.isDark ? Colors.grey[800]: Colors.grey[900],
            borderRadius: BorderRadius.only(
              topRight: Radius.circular(20.0),
              topLeft: Radius.circular(20.0),
            ),
          ),
          child: FutureBuilder<Weather>(
            future: ApiCalls().fetchWeather("Singapore"),
            builder: (context, snapshot){
              if (snapshot.hasData){
                return ListTile(
                  leading: Image.network(snapshot.data!.icon),
                  title: Text(
                  snapshot.data!.cityName.toUpperCase(),
                    style: kCityTextStyle(themeNotifier.isDark),
                  ),
                  subtitle: Text(
                    '${snapshot.data!.description}',
                    style: kDescriptionTextStyle(themeNotifier.isDark),
                  ),
                  trailing: Text(
                    '${snapshot.data!.temperature}°C | ${snapshot.data!.humidity}%',
                    style: kResultTextStyle(themeNotifier.isDark),
                  ),

                );
              } else if  (snapshot.hasError){
                return Text('${snapshot.error}');
              }
              return CircularProgressIndicator();
            },
          )
        );
      }
    );
  }
}
