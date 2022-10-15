import 'package:bl_dairy_app/model/milkPurchaseModel.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class MilkPurchaseController{


  static addMilkPurchase(MilkPurchaseModel milkPurchaseModel) async{
    await FirebaseFirestore.instance.collection("MilkPurchase").add(
      milkPurchaseModel.toJson()
    ).then((_){
      print("MILK PURCHASED");
    });



  }


  static Future<List<MilkPurchaseModel>?> fetchAllMilkPurchase() async {
    List<MilkPurchaseModel> all_milkPurchase = [];
    await FirebaseFirestore.instance.collection("MilkPurchase").orderBy("Date").get().then((
        querSnapshots) {
      querSnapshots.docs.forEach((order) {
        all_milkPurchase.add(MilkPurchaseModel.fromSnap(order));
      });
    });
    return all_milkPurchase;
  }






  static Future<List<String>> fetchSearchMilkPurchase(String query) async {
    print("CALLING");
    List<String> result_milkPurchase = [];
    await FirebaseFirestore.instance.collection("MilkPurchase").where("SupplierName" , isGreaterThanOrEqualTo: query).get().then((
        querSnapshots) {
      querSnapshots.docs.forEach((item) {
        result_milkPurchase.add(MilkPurchaseModel.fromSnap(item).SupplierName);


      });
    });

    return result_milkPurchase;
  }


}