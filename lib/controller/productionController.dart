import 'package:bl_dairy_app/model/productionModel.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class ProductionController{
  
  static addProduction(Production productionModel) async{
    await FirebaseFirestore.instance.collection("Production").add(productionModel.toJson());
    print("PRODUCTION DATA ADDED SUCCESSFULLY");
  }


  static Future<List<Production>> fetchProduction() async{
List<Production> all_Production = [];

await FirebaseFirestore.instance.collection("Production").where("FinishGoods",isEqualTo: "DORACAKE").get().then((querySnapshots){
  querySnapshots.docs.forEach((entity) {
    all_Production.add(Production.fromSnap(entity));
  });
});

return all_Production;

  }



  static Future<List<String>> fetchFinishGoodsName(String query) async {
    print("CALLING");
    List<String> result_items = [];
    await FirebaseFirestore.instance.collection("Production").where("FinishGoods" , isGreaterThanOrEqualTo: query).get().then((
        querSnapshots) {
      querSnapshots.docs.forEach((item) {
        result_items.add(item["FinishGoods"]);


      });
    });

    return result_items;
  }

}