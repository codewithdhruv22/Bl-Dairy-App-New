import 'package:cloud_firestore/cloud_firestore.dart';

class LedgerModel{

  String Name;
  String Mobile;
  String Village;
  String MilkType;
  String FatRate;


  LedgerModel(
  {
    required this.FatRate,
    required this.MilkType,
    required this.Mobile,
    required this.Name,
    required this.Village
}
      );


  Map<String , dynamic> toJson()=> {
    "FatRate" : FatRate,
    "MilkType": MilkType,
    "Mobile" : Mobile,
    "Name" : Name,
    "Village" : Village,

  };






  static LedgerModel fromSnap(DocumentSnapshot snap){
    var snapshot = snap.data() as Map<String , dynamic>;
    return LedgerModel(
      FatRate : snapshot["FatRate"] ?? "NO DATA",
      MilkType : snapshot["MilkType"] ?? "NO DATA",
      Mobile : snapshot["Mobile"] ?? "NO DATA",
      Name : snapshot["Name"] ?? "NO DATA",
      Village : snapshot["Village"] ?? "NO DATA",

    );
  }
}