import 'package:bl_dairy_app/controller/shopController.dart';
import 'package:bl_dairy_app/model/shopItemModel.dart';
import 'package:bl_dairy_app/view/widgets/ShopItemTile.dart';
import 'package:flutter/material.dart';

class MyOrders extends StatefulWidget {
  const MyOrders({super.key});

  @override
  State<MyOrders> createState() => _MyOrdersState();
}

class _MyOrdersState extends State<MyOrders> {
  List<itemModel> BookedShopItems = [];

  fetchShopItems() async {
    await shopController.fetchBookedItem().then((items) {
      setState(() {
        BookedShopItems = items;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Column(children: [
          Text("Your Delivery OTP is - 5666"),
          Expanded(
            child: ListView.builder(
                shrinkWrap: true,
                itemCount: BookedShopItems.length,
                itemBuilder: (context, index) {
                  final item = BookedShopItems[index];
                  return ShopItemCard(
                      context: context,
                      orderName: item.itemName,
                      isPerKg: item.isKg,
                      orderPrice: item.itemPricePerKgorL,
                      orderPic: item.itemPic,
                      orderCategory: item.itemCat);
                }),
          ),
        ]),
      ),
    );
  }
}
