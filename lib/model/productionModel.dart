import 'package:cloud_firestore/cloud_firestore.dart';

class Production{
  String FinishGoods;
  int FinishGoodsQty;
  Timestamp ProductionDate;
  List<RawMaterialModel> rawMaterialList;


 Production({
    required this.FinishGoods,
   required this.FinishGoodsQty,
   required this.ProductionDate,
    required this.rawMaterialList
});


  Map<String , dynamic> toJson(){
    List<Map<String,dynamic>> DataBaseRawMaterial = [];
    rawMaterialList.forEach((rawMaterial) {

    DataBaseRawMaterial.add(rawMaterial.toJson());

    });

    return {
      "FinishGoods" : FinishGoods,
      "FinishGoodsQty": FinishGoodsQty as int,
      "ProductionDate" : ProductionDate,
      "RmList" : DataBaseRawMaterial

    };

  }



  static Production fromSnap(DocumentSnapshot snap){
    var snapshot = snap.data() as Map<String , dynamic>;

    List<RawMaterialModel> rawMaterialFromSnap = [];
    (snapshot["RmList"] as List<dynamic>).forEach((rawMaterial) {

      rawMaterialFromSnap.add(

          RawMaterialModel(Rm: rawMaterial["Rm"], RmQty: rawMaterial["RmQty"], RmRate: rawMaterial["RmRate"])



      );
    });

    return Production(

      FinishGoods : snapshot["FinishGoods"] ?? "NO DATA",
      FinishGoodsQty : int.parse(snapshot["FinishGoodsQty"].toString()) ,
      ProductionDate : snapshot["ProductionDate"],


      rawMaterialList: rawMaterialFromSnap,


    );
  }



}


class RawMaterialModel{

  String Rm;
  int RmQty;
  int RmRate;

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
      RmRate : snapshot["RmRate"] ?? "NO DATA",
      RmQty : snapshot["RmQty"],


    );
  }




}