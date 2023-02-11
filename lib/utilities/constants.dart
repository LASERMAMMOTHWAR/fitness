import 'package:flutter/material.dart';


kTitle(bool isDark) {
  if (isDark){
    return TextStyle(
      fontSize: 40,
      color: Colors.red,
    );
  } else{
    return TextStyle(
      fontSize: 40,
      color: Colors.red[900],
    );
  }
}

const kDate = TextStyle(
  color: Colors.grey,
);

const kUserGreet = TextStyle(
  fontSize: 20,

);

kDaily_calo(bool isDark) {
  if (isDark){
    return TextStyle(
      fontSize: 25,
      color: Colors.red,
      fontWeight: FontWeight.bold,
    );
  } else{
    return TextStyle(
      fontSize: 25,
      color: Colors.red[900],
      fontWeight: FontWeight.bold,
    );
  }
}

kBmi_info(bool isDark){
  if (isDark){
    return TextStyle(
      color: Colors.grey,
      fontSize: 20,
      fontWeight: FontWeight.bold,
    );
  } else{
    return TextStyle(
      color: Colors.grey[900],
      fontSize: 20,
      fontWeight: FontWeight.bold,
    );
  }
}

kCityTextStyle(bool isDark){
  if (isDark){
    return TextStyle(
      fontSize: 20.0,
      fontWeight: FontWeight.bold,
    );
  } else{
    return TextStyle(
      fontSize: 20.0,
      color: Colors.white,
      fontWeight: FontWeight.bold,
    );
  }
}

kDescriptionTextStyle(bool isDark){
  if (isDark){
    return TextStyle(
      fontSize: 16.0,
    );
  } else{
    return TextStyle(
      color: Colors.white,
      fontSize: 16.0,
    );
  }
}

kResultTextStyle(bool isDark){
  if (isDark){
    return TextStyle(
      fontSize: 20.0,
    );
  } else{
    return TextStyle(
      color: Colors.white,
      fontSize: 20.0,
    );
  }
}