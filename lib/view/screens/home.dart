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
              icon: Icon(FeatherIcons.userPlus, size: 18), label: 'Attendence'),
          BottomNavigationBarItem(
              icon: Icon(FeatherIcons.shoppingCart, size: 18),
              label: 'Book Order'),
          BottomNavigationBarItem(
              icon: Icon(FeatherIcons.package, size: 18), label: 'Production'),
        ],
      ),
      appBar: AppBar(
        backgroundColor: MyColors.primary,
        title: const Text("DAIRY APP"),
        actions: [
          IconButton(
            icon: const Icon(
              Icons.calculate,
              size: 30,
            ),
            tooltip: 'Calculator',
            onPressed: () {
              Navigator.of(context).push(MaterialPageRoute(
                  builder: (context) => const UtilitiesScreen()));
            },
          ),
          const SizedBox(
            width: 15,
          )
        ],
      ),
      drawer: Drawer(
        child: Container(
          child: SafeArea(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Container(
                    margin: const EdgeInsets.symmetric(
                        horizontal: 25, vertical: 16),
                    child: const Text(
                      "CodeMarket.in",
                      style: TextStyle(
                          color: Colors.black45,
                          fontWeight: FontWeight.bold,
                          fontSize: 25),
                    )),
                const Divider(
                  color: Colors.white,
                ),
                ListTile(
                  title: const Text("ADD SUPPLIER"),
                  onTap: () {
                    Navigator.of(context).push(MaterialPageRoute(
                        builder: (context) => const AddMilkSupplierScreen()));
                  },
                ),
                const SizedBox(
                  height: 5,
                ),
                ListTile(
                  title: const Text("PURCHASE MILK"),
                  onTap: () {
                    Navigator.of(context).push(MaterialPageRoute(
                        builder: (context) => const MilkPurchaseScreen()));
                  },
                ),
                const SizedBox(
                  height: 5,
                ),
                ListTile(
                  title: const Text("NEW EMPLOYEE"),
                  onTap: () {
                    Navigator.of(context).push(MaterialPageRoute(
                        builder: (context) => const AddNewEmp_Screen()));
                  },
                ),
                const SizedBox(
                  height: 5,
                ),
                ListTile(
                  title: const Text("Utilities"),
                  onTap: () {
                    Navigator.of(context).push(MaterialPageRoute(
                        builder: (context) => const UtilitiesScreen()));
                  },
                ),
                ListTile(
                  title: const Text("Payment"),
                  onTap: () {
                    Navigator.of(context).push(MaterialPageRoute(
                        builder: (context) => const PaymentScreen()));
                  },
                ),
                ListTile(
                  title: const Text("Purchase Raw Material"),
                  onTap: () {
                    Navigator.of(context).push(MaterialPageRoute(
                        builder: (context) => const RmPurchaseScreen()));
                  },
                ),

                 ListTile(
                  title: const Text("Add new raw material"),
                  onTap: () {
                    Navigator.of(context).push(MaterialPageRoute(
                        builder: (context) =>  AddNewRm()));
                  },
                ),
              ],
            ),
          ),
        ),
      ),
      body: pageIndex[pageIdx],
    );
  }
}
