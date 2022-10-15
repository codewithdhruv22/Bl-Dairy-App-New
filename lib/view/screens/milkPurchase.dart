import 'package:bl_dairy_app/controller/milkPurchaseController.dart';
import 'package:bl_dairy_app/model/milkPurchaseModel.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class MilkPurchaseScreen extends StatelessWidget {
  const MilkPurchaseScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          Text("Supplier Name (SEARCHABLE)"),
          TextField(),
          Text("DATE SELECTOR"),
          TextField(),
          Text("SHIFT FETCHED FROM SUPPLIER DETAILS"),
          TextField(),
          Text("MILK TYPE FETCHED FROM SUPPLIER DETAILS"),
          TextField(),
          Text("MILK Qty"),
          TextField(),
          Text("Fat"),
          TextField(),
          Text("SNF Value"),
          TextField(),
          SizedBox(height: 50,),
          Text("TOTAL PRICE - Fat*Supplier Fat Rate * Quantity"),
          ElevatedButton(onPressed: (){
         MilkPurchaseController.addMilkPurchase(MilkPurchaseModel(Date: Timestamp.now(), fat: 4, milkQty: 23, milkType: "COW", shift: "MORNING", snfVal: 6.3, SupplierName: "DHRUV"));

          }, child: Text("Complete"))
        ],
      ),
    );
  }
}
