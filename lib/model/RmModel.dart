import 'package:cloud_firestore/cloud_firestore.dart';

class RmModel{

  String RmName;
  double RmPrice;
  double RmQty;
  Timestamp purchaseTime;


  RmModel({
    required this.RmName,
    required this.RmPrice,
    required this.RmQty,
    required this.purchaseTime

});

  Map<String , dynamic> toJson()=>{
    "RmName" : RmName,
    "RmPrice" : RmPrice,
    "RmQty" : RmQty,
    "purchaseTime" : purchaseTime

  };

  static RmModel fromSnap(DocumentSnapshot snap){
    var snapshot = snap.data() as Map<String , dynamic>;
    return RmModel(RmName:  snapshot["RmName"] ?? "NO DATA", RmPrice:  snapshot["RmPrice"] ?? 0.0 ,
        RmQty:  snapshot["RmQty"] ?? 0.0 , purchaseTime: snapshot["purchaseTime"] ?? Timestamp.now());

  }



}