import 'package:bl_dairy_app/view/screens/AddMilkSupplier.dart';
import 'package:bl_dairy_app/view/screens/milkPurchase.dart';
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
              icon: Icon(FeatherIcons.plus, size: 18), label: 'Add Milk Supplier'),
          BottomNavigationBarItem(
              icon: Icon(FeatherIcons.shoppingCart, size: 18),
              label: 'Book Order'),
          BottomNavigationBarItem(
              icon: Icon(FeatherIcons.package, size: 18), label: 'Production'),
        ],
      ),

      appBar: AppBar(
        title: Text("DAIRY APP"),

      ),
      drawer: Drawer(
        child: Container(

          child: SafeArea(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Container(
                    margin: EdgeInsets.symmetric(horizontal: 25, vertical: 16),
                    child: Text(
                      "CodeMarket.in",
                      style: TextStyle(
                        color: Colors.black45,
                          fontWeight: FontWeight.bold,
                          fontSize: 25),
                    )),
                Divider(
                  color: Colors.white,
                ),
             ListTile(
               title: Text("ADD SUPPLIER"),
               onTap: (){
                 Navigator.of(context).push(MaterialPageRoute(builder: (context)=>AddMilkSupplierScreen()));
               },
             ),
                SizedBox(height: 5,),
                ListTile(
                  title: Text("PURCHASE MILK"),
                  onTap: (){
                    Navigator.of(context).push(MaterialPageRoute(builder: (context)=>MilkPurchaseScreen()));
                  },
                ),
                SizedBox(height: 5,),

              ],
            ),
          ),
        ),
      ),
      body: pageIndex[pageIdx],
    );
  }
}
