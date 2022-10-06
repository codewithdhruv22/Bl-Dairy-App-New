import 'package:flutter/material.dart';
import 'package:flutter_feather_icons/flutter_feather_icons.dart';

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
              icon: Icon(FeatherIcons.home, size: 18), label: 'Home'),
          BottomNavigationBarItem(
              icon: Icon(FeatherIcons.alertOctagon, size: 18), label: 'Report'),
          BottomNavigationBarItem(
              icon: Icon(FeatherIcons.plus, size: 18), label: 'Add Ledger'),
          BottomNavigationBarItem(
              icon: Icon(FeatherIcons.shoppingCart, size: 18),
              label: 'Book Order'),
          BottomNavigationBarItem(
              icon: Icon(FeatherIcons.settings, size: 18), label: 'Settings'),
        ],
      ),
      body: pageIndex[pageIdx],
    );
  }
}
