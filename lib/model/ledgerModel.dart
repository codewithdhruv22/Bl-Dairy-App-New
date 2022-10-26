import 'package:cloud_firestore/cloud_firestore.dart';

class MilkSupplierModel{

  String Name;
  String Mobile;
  String Village;
  String MilkType;
  String Rate;
  bool isCowMilk;
  String SNFDedPrice;
  String FatDedPrice;
 


  MilkSupplierModel(
  {
    required this.Rate,
    required this.MilkType,
    required this.Mobile,
    required this.Name,
    required this.Village,
    required this.isCowMilk,
    required this.SNFDedPrice,
    required this.FatDedPrice,

}
      );


  Map<String , dynamic> toJson()=> {
    "Rate" : Rate,
    "MilkType": MilkType,
    "Mobile" : Mobile,
    "Name" : Name,
    "Village" : Village,
    "isCowMilk" : isCowMilk,
    "SNFDedPrice" : SNFDedPrice,
    "FatDedPrice" : FatDedPrice,

  

  };






  static MilkSupplierModel fromSnap(DocumentSnapshot snap){
    var snapshot = snap.data() as Map<String , dynamic>;
    return MilkSupplierModel(
      Rate : snapshot["Rate"] ?? "NO DATA",
      MilkType : snapshot["MilkType"] ?? "NO DATA",
      Mobile : snapshot["Mobile"] ?? "NO DATA",
      Name : snapshot["Name"] ?? "NO DATA",
      Village : snapshot["Village"] ?? "NO DATA",
      SNFDedPrice : snapshot["SNFDedPrice"] ?? "0",
      FatDedPrice : snapshot["FatDedPrice"] ?? "0",
      isCowMilk : snapshot["Village"] == 1 ? true : false ,
      


    );
  }
}