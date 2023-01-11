import 'package:bl_dairy_app/model/RmModel.dart';
import 'package:bl_dairy_app/model/productionModel.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class RmController {
  static Future<void> PurhcaseRm(RmModel rmModel) async {
    // await FirebaseFirestore.instance.collection("ProductList").where("ProductCategory" , isEqualTo : "Raw Material").get().then((RmList) async {
    await FirebaseFirestore.instance
        .collection("ProductList")
        .get()
        .then((RmList) async {
      print("I AM STARTING");
      for (var Rm in RmList.docs) {
        // print(Rm["ProductCategory"]);
        if (Rm["ProductCategory"] == "Raw Material") {
          print(" I AM HERE");
          print(Rm["ProductName"]);

          if (Rm["ProductName"].toString().toLowerCase() ==
              rmModel.RmName.toLowerCase()) {
            print("PRODUCT FOUND");
            print(Rm.id);
            await FirebaseFirestore.instance
                .collection("ProductList")
                .doc(Rm.id)
                .update({"Price": rmModel.RmPrice}).then((_) {
              print("PRICE UPDATED SUCESSFULLY");
            });
            break;
          }
        }
      }
    });

    await FirebaseFirestore.instance
        .collection("NewRmPurchase")
        .add(rmModel.toJson())
        .then((_) {
      print("RM PURCHASE ENTRY SUCCESSFUL");
    });
  }

  static Future<void> addNewRm(
      {required String RmName,
      required double RmPrice,
      required String RmType}) async {
    await FirebaseFirestore.instance.collection("ProductList").add({
      "Price": RmPrice,
      "ProductCategory": RmType,
      "ProductName": RmName
    }).then((_) {
      print("NEW RM ADDED SUCCESSFULLY");
    });
  }
}
