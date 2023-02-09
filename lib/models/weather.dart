class Weather {
  String cityName;
  int temperature;
  int humidity;
  String icon;
  String description;

  Weather({
    required this.cityName,
    required this.temperature,
    required this.humidity,
    required this.icon,
    required this.description,
  });

  factory Weather.fromJson(Map<String, dynamic> json) {
    num temp = json['main']['temp'];
    return Weather(
      cityName: json['name'],
      temperature: temp.toInt(),
      humidity: json['main']['humidity'],
      icon: 'http://openweathermap.org/img/wn/${json['weather'][0]['icon']}.png',
      description: json['weather'][0]['description'],
    );
  }
}