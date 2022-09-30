import 'package:bl_dairy_app/constants.dart';
import 'package:flutter/material.dart';

class Home extends StatefulWidget {
  const Home({Key? key}) : super(key: key);

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {

  int pageIdx = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      bottomNavigationBar: BottomNavigationBar(
        type: BottomNavigationBarType.fixed,
        backgroundColor: Colors.white,
        onTap: (index){
          setState(() {
            pageIdx = index;
          });


        },
        currentIndex: pageIdx,

        items: [
          BottomNavigationBarItem(icon: Icon(Icons.home, size : 25 ) , label : 'Home'),
          BottomNavigationBarItem(icon: Icon(Icons.report, size : 25 ) , label : 'Report'),
          BottomNavigationBarItem(icon: Icon(Icons.people, size : 25 ) , label : 'Attendance'),
          BottomNavigationBarItem(icon: Icon(Icons.help, size : 25 ) , label : 'Help'),
          BottomNavigationBarItem(icon: Icon(Icons.settings, size : 25 ) , label : 'Settings'),

        ],
      ),
      body: pageIndex[pageIdx],
    );
  }
}
