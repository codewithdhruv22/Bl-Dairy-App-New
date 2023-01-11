import 'package:cloud_firestore/cloud_firestore.dart';

class itemModel {
  String itemPic;
  String itemName;
  String itemPricePerKgorL;
  bool isKg;
  String itemCat;

  itemModel({
    required this.itemCat,
    required this.itemName,
    required this.itemPic,
    required this.itemPricePerKgorL,
    required this.isKg,
  });

  static Map<String, dynamic> itemModelfromAppToFBase(itemModel item) {
    return {
      "itemPic": item.itemPic,
      "itemName": item.itemName,
      "itemPricePerKgorL": item.itemPricePerKgorL,
      "isKg": item.isKg,
      "itemCat": item.itemCat,
    };
  }

  static itemModel itemModelfromFBaseToApp(DocumentSnapshot documentSnapshot) {
    return itemModel(
        itemCat: documentSnapshot["itemCat"],
        itemName: documentSnapshot["itemName"],
        itemPic: documentSnapshot["itemPic"],
        itemPricePerKgorL: documentSnapshot["itemPricePerKgorL"],
        isKg: documentSnapshot["isKg"]);
  }
}
