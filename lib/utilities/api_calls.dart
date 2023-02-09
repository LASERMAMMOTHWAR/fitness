import 'dart:convert';

import '../models/fitness_user.dart';
import '../models/bmi.dart';

import 'package:http/http.dart' as http;

import '../models/weather.dart';

class ApiCalls {
  Map<String, String> requestHeaders = {
    'X-RapidAPI-Host': 'fitness-calculator.p.rapidapi.com',
    'X-RapidAPI-Key': '6b23e0f469mshd2594defaa8bffap18cc7bjsn9e184f261bbe' //TODO
  };

  Future<Bmi> fetchBmi(FitnessUser user) async {
    String baseURL = 'https://fitness-calculator.p.rapidapi.com/bmi';

    Map<String, String> queryParams = {
      'age': user.age.toString(),
      'weight': user.weight.toString(),
      'height': user.height.toString(),
    };


    String queryString = Uri(queryParameters: queryParams).query;
    final response = await http.get(Uri.parse(baseURL + '?' + queryString), headers: requestHeaders);
    // print("test");

    if (response.statusCode == 200) {
      return Bmi.fromJson(jsonDecode(response.body));

      //TODO return Bmi object
    } else {
      throw Exception('Failed to load bmi');
    }
  }

  Future<double> fetchDailyCalorie(FitnessUser user) async {
    String baseURL = 'https://fitness-calculator.p.rapidapi.com/dailycalorie';

    Map<String, String> queryParams = {
      'age': user.age.toString(),
      'weight': user.weight.toString(),
      'height': user.height.toString(),
      'gender': user.gender.toString(),
      'activitylevel': user.activityLevel.toString(),
    };

    String user_goal = user.goal.toString();
    String queryString = Uri(queryParameters: queryParams).query;
    final response = await http.get(Uri.parse(baseURL + '?' + queryString), headers: requestHeaders);


    if (response.statusCode == 200) {
      Map<String, dynamic> calorie_data = jsonDecode(response.body);
      var calories_req = calorie_data['data']['goals'];
      if (user_goal == 'maintain weight'){
        return calories_req['maintain weight'].toDouble();
      }
      else {
        return calories_req[user_goal]['calory'].toDouble();
      }

    } else{
      throw Exception('Failed to load Calorie');
    }

    //TODO
  }

  Future<double> fetchBurnedCalories(String Exercise_id, double activitymin, int weight) async {
    String baseURL = 'https://fitness-calculator.p.rapidapi.com/burnedcalorie';

    Map<String, String> queryParams = {
      'activityid' : Exercise_id.toString(),
      'activitymin' : activitymin.toString(),
      'weight' : weight.toString(),

    };


    String queryString = Uri(queryParameters: queryParams).query;
    final response = await http.get(Uri.parse(baseURL + '?' + queryString), headers: requestHeaders);

    if (response.statusCode == 200) {
      Map<String, dynamic> burned_Calorie_data = jsonDecode(response.body);
      // print(jsonDecode(response.body));
      print(burned_Calorie_data['data']['burnedCalorie']);
      return double.parse(burned_Calorie_data['data']['burnedCalorie']);

    } else{
      throw Exception('Failed to load Calorie');
    }

    //TODO
  }


  Future<Weather> fetchWeather(String city) async {
    const apiKey = '5c0e46a0fddf4849a0aa1403daa7b169';
    const baseURL = 'https://api.openweathermap.org/data/2.5/weather';
    final response = await http
        .get(Uri.parse('$baseURL?q=$city&appid=$apiKey&units=metric'));
    if (response.statusCode == 200) {
      print(jsonDecode(response.body));
      return Weather.fromJson(jsonDecode(response.body));
    } else {
      throw Exception('Failed to load weather');
    }
  }
}
