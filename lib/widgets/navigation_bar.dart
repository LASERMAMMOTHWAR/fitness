import 'package:flutter/material.dart';

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
    return BottomNavigationBar(
      selectedItemColor: Colors.cyanAccent,
      // backgroundColor: Colors.blue,
      items:  [
        BottomNavigationBarItem(
          backgroundColor: Colors.blueGrey,
          label: 'Home',
          icon: Icon(Icons.home),
        ),
        BottomNavigationBarItem(
          backgroundColor: Colors.blueGrey,
          label: 'Exercise',
          icon: Icon(Icons.directions_run),
        ),
        BottomNavigationBarItem(
          backgroundColor: Colors.blueGrey,
          label: 'User',
          icon: Icon(Icons.person),
        ),
        BottomNavigationBarItem(
          backgroundColor: Colors.blueGrey,
          label: 'More',
          icon: Icon(Icons.more_horiz, ),
        ),
      ],
      currentIndex: widget.selectedIndexNavBar,
      onTap: _onTap,
    );
  }
}