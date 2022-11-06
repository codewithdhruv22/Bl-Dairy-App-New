import 'package:cloud_firestore/cloud_firestore.dart';

class Production{
  String FinishGoods;
  double FinishGoodsQty;
  Timestamp ProductionDate;
  List<RawMaterialModel> rawMaterialList;
  double costPerKG;


 Production({
    required this.FinishGoods,
   required this.FinishGoodsQty,
   required this.ProductionDate,
    required this.rawMaterialList,
    required this.costPerKG,
});


  Map<String , dynamic> toJson(){
    List<Map<String,dynamic>> DataBaseRawMaterial = [];
    rawMaterialList.forEach((rawMaterial) {

    DataBaseRawMaterial.add(rawMaterial.toJson());

    });

    return {
      "FinishGoods" : FinishGoods,
      "FinishGoodsQty": FinishGoodsQty as double,
      "ProductionDate" : ProductionDate,
      "RmList" : DataBaseRawMaterial,
      "costPerKG" : costPerKG

    };

  }



  static Production fromSnap(DocumentSnapshot snap){
    var snapshot = snap.data() as Map<String , dynamic>;

    List<RawMaterialModel> rawMaterialFromSnap = [];
    (snapshot["RmList"] as List<dynamic>).forEach((rawMaterial) {

      rawMaterialFromSnap.add(

          RawMaterialModel(Rm: rawMaterial["Rm"], RmQty: double.parse(rawMaterial["RmQty"].toString()), RmRate: double.parse(rawMaterial["RmRate"].toString()))



      );
    });

    return Production(

      FinishGoods : snapshot["FinishGoods"] ?? "NO DATA",
      FinishGoodsQty : double.parse(snapshot["FinishGoodsQty"].toString()),
      ProductionDate : snapshot["ProductionDate"],
      rawMaterialList: rawMaterialFromSnap,
      costPerKG : snapshot["costPerKG"] ?? 0.0,


    );
  }



}


class RawMaterialModel{

  String Rm;
  double RmQty;
  double RmRate;

  RawMaterialModel(
  {

    required this.Rm,required this.RmQty,
    required this.RmRate
});




  Map<String , dynamic> toJson()=> {
    "Rm" : Rm,
    "RmRate": RmRate,
    "RmQty" : RmQty

  };



  static RawMaterialModel fromSnap(DocumentSnapshot snap){
    var snapshot = snap.data() as Map<String , dynamic>;
    return RawMaterialModel(
      Rm : snapshot["Rm"] ?? "NO DATA",
      RmRate : snapshot["RmRate"] ?? 0.0,
      RmQty : snapshot["RmQty"] ?? 0.0,


    );
  }




}