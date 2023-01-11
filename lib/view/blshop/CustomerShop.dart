import 'package:bl_dairy_app/controller/shopController.dart';
import 'package:bl_dairy_app/model/shopItemModel.dart';
import 'package:bl_dairy_app/view/widgets/ShopItemTile.dart';
import 'package:flutter/material.dart';

class CustomerShop extends StatefulWidget {
  const CustomerShop({super.key});

  @override
  State<CustomerShop> createState() => _CustomerShopState();
}

class _CustomerShopState extends State<CustomerShop> {
  List<itemModel> ShopItem = [];

  fetchShopItems() async {
    await shopController.fetchShopItem().then((items) {
      setState(() {
        ShopItem = items;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(children: [
        Expanded(
          child: ListView.builder(
              shrinkWrap: true,
              itemCount: ShopItem.length,
              itemBuilder: (context, index) {
                final item = ShopItem[index];
                return ShopItemCard(
                    context: context,
                    orderName: item.itemName,
                    isPerKg: item.isKg,
                    orderPrice: item.itemPricePerKgorL,
                    orderPic:
                        item.itemPic,
                    orderCategory: item.itemCat);
              }),
        ),
      ]),
    );
  }
}
