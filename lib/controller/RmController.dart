import 'package:bl_dairy_app/model/RmModel.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class RmController{


  static Future<void> PurhcaseRm(RmModel rmModel) async{
    // await FirebaseFirestore.instance.collection("ProductList").where("ProductCategory" , isEqualTo : "Raw Material").get().then((RmList) async {
    await FirebaseFirestore.instance.collection("ProductList").get().then((RmList) async {
      print("I AM STARTING");
      for (var Rm in RmList.docs)  {
        // print(Rm["ProductCategory"]);
        if(Rm["ProductCategory"] == "Raw Material") {
          print(" I AM HERE");
          print(RmModel
              .fromSnap(Rm)
              .RmName
              .toLowerCase() );
          print(rmModel.RmName.toLowerCase());
          if (Rm["ProductName"] == rmModel.RmName.toLowerCase()) {
            print("PRODUCT FOUND");
            print(Rm.id);
            await FirebaseFirestore.instance.collection("ProductList").doc(
                Rm.id).update(
                {"Price": rmModel.RmPrice}).then((_) {
              print("PRICE UPDATED SUCESSFULLY");
            });
            break;
          }
        }
      }
    });


    await FirebaseFirestore.instance.collection("NewRmPurchase").add(rmModel.toJson()).then((_){
      print("RM PURCHASE ENTRY SUCCESSFUL");
    });
  }

}

