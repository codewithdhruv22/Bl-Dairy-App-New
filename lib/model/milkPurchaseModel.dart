import 'package:cloud_firestore/cloud_firestore.dart';

class MilkPurchaseModel{


  String SupplierName;
  Timestamp Date;
  String shift;
  String milkType;
  int milkQty;
  double fat;
  double snfVal;
  double totalAmnt;

  MilkPurchaseModel(
  {
    required this.Date,
    required this.fat,
    required this.milkQty,
    required this.milkType,
    required this.shift,
    required this.snfVal,
    required this.SupplierName,
    required this.totalAmnt

}
      );


  Map<String , dynamic> toJson()=> {
    "Date" : Date,
    "fat" : fat,
    "milkQty" : milkQty,
    "milkType" : milkType,
    "shift" : shift,
    "snfVal" : snfVal,
    "SupplierNam" : SupplierName,
"totalAmnt" : totalAmnt,

  };





  static MilkPurchaseModel fromSnap(DocumentSnapshot snap){
    var snapshot = snap.data() as Map<String , dynamic>;
    return MilkPurchaseModel(
      Date : snapshot["Date"] ?? "NO DATA",
      fat : snapshot["fat"] ?? "NO DATA",
      milkQty : snapshot["milkQty"] ?? "NO DATA",
      milkType : snapshot["milkType"] ?? "NO DATA",
      shift : snapshot["shift"] ?? "NO DATA",
      snfVal : snapshot["snfVal"] ?? "NO DATA",
      SupplierName : snapshot["SupplierName"] ?? "NO DATA",
        totalAmnt : snapshot["totalAmnt"],


    );
  }

}