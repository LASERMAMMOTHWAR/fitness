class Bmi {
  final double bmi;
  final String health;
  final String healthyBmiRange;

  Bmi({
    required this.bmi,
    required this.health,
    required this.healthyBmiRange,
  });

  factory Bmi.fromJson(Map<String, dynamic> json){
    var bmi_data = json['data'];
    return Bmi(
        bmi: json['data']['bmi'],
        health: json['data']['health'],
        healthyBmiRange: json['data']['healthy_bmi_range'],
    );

  }
  //TODO implement Bmi.fromJson
}
