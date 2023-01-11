import 'package:bl_dairy_app/model/shopItemModel.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:fluttertoast/fluttertoast.dart';

class shopController {
  static void buyItem(itemModel item) {
    FirebaseFirestore.instance
        .collection("Sale")
        .doc("8969dgv8edsgvwf8sd6v")
        .collection("orders")
        .doc()
        .set(itemModel.itemModelfromAppToFBase(item))
        .then((value) {
      Fluttertoast.showToast(msg: "Order Placed Successfully");
    });
  }

  static Future<List<itemModel>> fetchShopItem() async {
    List<itemModel> shopItems = [];

    await FirebaseFirestore.instance
        .collection("ShopItems")
        .get()
        .then((value) {
      for (var doc in value.docs) {
        shopItems.add(itemModel.itemModelfromFBaseToApp(doc));
      }
    });

    return shopItems;
  }


  static Future<List<itemModel>> fetchBookedItem() async {
    List<itemModel> bookedShopItems = [];

    await FirebaseFirestore.instance
    //TODO: Add the current user ID here
        .collection("ShopItemsBooked").doc("8305393179").collection("orders")
        .get()
        .then((value) {
      for (var doc in value.docs) {
        bookedShopItems.add(itemModel.itemModelfromFBaseToApp(doc));
      }
    });

    return bookedShopItems;
  }

}
