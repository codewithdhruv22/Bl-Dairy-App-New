import 'package:bl_dairy_app/model/ledgerModel.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class LedgerController{

  static addLedger(LedgerModel ledgerModel) async{
await FirebaseFirestore.instance.collection("MilkSupplier").add(ledgerModel.toJson());
  }



 static Future<List<LedgerModel>> fetchAllLedger() async{
    List<LedgerModel> all_ledgers = [];
    await FirebaseFirestore.instance.collection("MilkSupplier").get().then((querySnapshots){
      querySnapshots.docs.forEach((order) {
        all_ledgers.add(LedgerModel.fromSnap(order));
      });
    });

    return all_ledgers;
  }




  static Future<List<LedgerModel>> fetchOneLedger(String ledgerQuery) async{

    List<LedgerModel> result_ledger = [];
    await FirebaseFirestore.instance.collection("MilkSupplier").where("Name" ,isGreaterThanOrEqualTo: ledgerQuery).get().then((querySnapshots){
      querySnapshots.docs.forEach((order) {
        result_ledger.add(LedgerModel.fromSnap(order));
      });
    });
    return result_ledger;
    
  }


}