import 'package:flutter/material.dart';
import 'package:fitness/models/model_theme.dart';
import 'package:provider/provider.dart';


class MyBottomNavigationBar extends StatefulWidget {
  MyBottomNavigationBar({Key? key, required this.selectedIndexNavBar})
      : super(key: key);
  int selectedIndexNavBar;

  @override
  State<MyBottomNavigationBar> createState() => _MyBottomNavigationBarState();
}

class _MyBottomNavigationBarState extends State<MyBottomNavigationBar> {
  void _onTap(int index) {
    widget.selectedIndexNavBar = index;
    setState(() {
      switch (index) {
        case 0:
          Navigator.pushReplacementNamed(context, '/home');
          break;
        case 1:
          Navigator.pushReplacementNamed(context, '/exercise');
          break;
        case 2:
          Navigator.pushReplacementNamed(context, '/user');
          break;

        case 3:
          Navigator.pushReplacementNamed(context, '/more');
          break;
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<ModelTheme>(
      builder: (context, ModelTheme themeNotifier, child) {
        return BottomNavigationBar(
          selectedItemColor: themeNotifier.isDark ? Colors.cyanAccent : Colors.cyan,
          // backgroundColor: Colors.blue,
          items:  [
            BottomNavigationBarItem(
              backgroundColor: themeNotifier.isDark ? Colors.blueGrey: Colors.blue[900],
              label: 'Home',
              icon: Icon(Icons.home),
            ),
            BottomNavigationBarItem(
              backgroundColor: themeNotifier.isDark ? Colors.blueGrey: Colors.blue[900],
              label: 'Exercise',
              icon: Icon(Icons.directions_run),
            ),
            BottomNavigationBarItem(
              backgroundColor: themeNotifier.isDark ? Colors.blueGrey: Colors.blue[900],
              label: 'User',
              icon: Icon(Icons.person),
            ),
            BottomNavigationBarItem(
              backgroundColor: themeNotifier.isDark ? Colors.blueGrey: Colors.blue[900],
              label: 'More',
              icon: Icon(Icons.more_horiz, ),
            ),
          ],
          currentIndex: widget.selectedIndexNavBar,
          onTap: _onTap,
        );
      }
    );
  }
}