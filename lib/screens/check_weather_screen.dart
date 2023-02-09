import 'package:fitness/utilities/api_calls.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';


import '../models/weather.dart';
import '../utilities/constants.dart';

class check_weather extends StatefulWidget {
  const check_weather({Key? key}) : super(key: key);

  @override
  State<check_weather> createState() => _check_weatherState();
}

class _check_weatherState extends State<check_weather> {
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
      child: FutureBuilder<Weather>(
        future: ApiCalls().fetchWeather("Singapore"),
        builder: (context, snapshot){
          if (snapshot.hasData){
            return ListTile(
              leading: Image.network(snapshot.data!.icon),
              title: Text(
              snapshot.data!.cityName.toUpperCase(),
                style: kCityTextStyle,
              ),
              subtitle: Text(
                '${snapshot.data!.description}',
                style: kDescriptionTextStyle,
              ),
              trailing: Text(
                '${snapshot.data!.temperature}°C | ${snapshot.data!.humidity}%',
                style: kResultTextStyle,
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
}
