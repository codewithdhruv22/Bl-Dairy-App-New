import 'package:bl_dairy_app/controller/productionController.dart';
import 'package:bl_dairy_app/model/productionModel.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class ProductionScreen extends StatelessWidget {
  const ProductionScreen({Key? key}) : super(key: key);


  ProductionPrinter() async{

    await ProductionController.fetchProduction().then((production){
      production.forEach((element) {
        print(element.FinishGoods.toString());
        print(element.ProductionDate.toString());
      });
    });
  }


  @override
  Widget build(BuildContext context) {

    ProductionPrinter();

    return Scaffold(


      body: Column(
        children: [
          TextField(),
          TextField(),
          TextField(),
          TextField(),



          ElevatedButton(onPressed: (){

            ProductionController.addProduction(Production(FinishGoods: "DORACAKE",
                FinishGoodsQty: 12, ProductionDate: Timestamp.now(),
            rawMaterialList:

            [

            RawMaterialModel(Rm: "Ras", RmQty:66, RmRate:25),
              RawMaterialModel(Rm: "Malai", RmQty:6, RmRate:5),
              RawMaterialModel(Rm: "Water", RmQty:9, RmRate:2),

            ]
            ));
          }, child: Text("Add To Production"))
        ],
      ),
    );
  }
}
