import 'package:bl_dairy_app/model/ledgerModel.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class milkSupplierController{

  static addNewMilkSupplier(MilkSupplierModel milkSupplierModel) async{
await FirebaseFirestore.instance.collection("MilkSupplier").add(milkSupplierModel.toJson());
print("NEW MILK SUPPLIER ADDED SUCCESSFULLY");
  }



 static Future<List<MilkSupplierModel>> fetchAllLedger() async{
    List<MilkSupplierModel> all_ms = [];
    await FirebaseFirestore.instance.collection("MilkSupplier").get().then((querySnapshots){
      querySnapshots.docs.forEach((order) {
        all_ms.add(MilkSupplierModel.fromSnap(order));
      });
    });

    return all_ms;
  }




  static Future<List<MilkSupplierModel>> fetchOneLedger(String ledgerQuery) async{

    List<MilkSupplierModel> result_ms = [];
    await FirebaseFirestore.instance.collection("MilkSupplier").where("Name" ,isGreaterThanOrEqualTo: ledgerQuery).get().then((querySnapshots){
      querySnapshots.docs.forEach((order) {
        result_ms.add(MilkSupplierModel.fromSnap(order));
      });
    });
    return result_ms;
    
  }


}