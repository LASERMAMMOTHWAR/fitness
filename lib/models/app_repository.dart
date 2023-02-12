
import 'dart:collection';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../models/apps.dart';



class AllApps{

  UnmodifiableListView<App_widget> get allApps {
    return UnmodifiableListView(_allApps);
  }

  int get allAppsCount {
    return _allApps.length;
  }


  final List<App_widget> _allApps = [
    App_widget(
        name: "Weather",
        icon: Icon(Icons.cloud, size: 45,)
    ),
    App_widget(
        name: "Food",
        icon: Icon(Icons.food_bank, size: 45)
    ),
    App_widget(
        name: "Home Workout",
        icon: Icon(Icons.work_outline, size: 45)
    ),
    App_widget(
        name: "24/7 Hotline",
        icon: Icon(Icons.quick_contacts_dialer_rounded)
    ),
  ];
}

