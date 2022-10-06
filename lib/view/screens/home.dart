 
import 'package:flutter/material.dart';

import '../../constants/constants.dart';

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
        onTap: (index) {
          setState(() {
            pageIdx = index;
          });
        },
        selectedFontSize: 12,
        unselectedFontSize: 12,
        currentIndex: pageIdx,
        items: const [
          BottomNavigationBarItem(
              icon: Icon(Icons.home, size: 25), label: 'Home'),
          BottomNavigationBarItem(
              icon: Icon(Icons.report, size: 25), label: 'Report'),
          BottomNavigationBarItem(
              icon: Icon(Icons.add, size: 25), label: 'Add Ledger'),
          BottomNavigationBarItem(
              icon: Icon(Icons.shopping_cart, size: 25), label: 'Book Order'),
          BottomNavigationBarItem(
              icon: Icon(Icons.settings, size: 25), label: 'Settings'),
        ],
      ),
      body: pageIndex[pageIdx],
    );
  }
}
