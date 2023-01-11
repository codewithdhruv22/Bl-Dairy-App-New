import 'package:bl_dairy_app/constants/Theme.dart';
import 'package:bl_dairy_app/view/screens/AddMilkSupplier.dart';
import 'package:bl_dairy_app/view/screens/AddRmItem.dart';
import 'package:bl_dairy_app/view/screens/RmPruchase.dart';
import 'package:bl_dairy_app/view/screens/addNewEmp.dart';
import 'package:bl_dairy_app/view/screens/milkPurchase.dart';
import 'package:bl_dairy_app/view/screens/payment.dart';
import 'package:bl_dairy_app/view/screens/utils.dart';
import 'package:flutter/material.dart';
import 'package:flutter_feather_icons/flutter_feather_icons.dart';

import '../../constants/constants.dart';

class ShopMain extends StatefulWidget {
  int initialIndex;
   ShopMain({Key? key, required this.initialIndex}) : super(key: key);

  @override
  State<ShopMain> createState() => _ShopMainState();
}

class _ShopMainState extends State<ShopMain> {


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      bottomNavigationBar: BottomNavigationBar(
        type: BottomNavigationBarType.fixed,
        backgroundColor: Colors.white,
        onTap: (index) {
          setState(() {
            widget.initialIndex = index;
          });
        },
        selectedFontSize: 12,
        unselectedFontSize: 12,
        currentIndex: widget.initialIndex,
        items: const [
          BottomNavigationBarItem(
              icon: Icon(FeatherIcons.home, size: 18), label: 'Home'),
          BottomNavigationBarItem(
              icon: Icon(FeatherIcons.shoppingBag, size: 18), label: 'My Orders'),
          BottomNavigationBarItem(
              icon: Icon(FeatherIcons.user, size: 18), label: 'Profile'),

        ],
      ),
      appBar: AppBar(
        backgroundColor: MyColors.primary,
        title: const Text("BhagyaLaxmi Mini Shop"),
       
      ),
    
      body: shopMainIndex[widget.initialIndex],
    );
  }
}
