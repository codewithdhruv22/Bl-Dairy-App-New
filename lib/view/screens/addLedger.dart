import 'package:bl_dairy_app/controller/ledgerController.dart';
import 'package:bl_dairy_app/model/ledgerModel.dart';
import 'package:flutter/material.dart';

class addLedger extends StatelessWidget {
  const addLedger({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          Text("Name"),
          TextField(),
          Text("Village"),
          TextField(),
          Text("Mobile"),
          TextField(),
          Text("MilkType"),
          TextField(),
          Text("FatRate"),
          TextField(),

ElevatedButton(onPressed: (){
  LedgerController.addLedger(LedgerModel(FatRate: "2.5", MilkType: "Cow", Mobile: "9999888", Name: "DEMO NAME", Village: "DEMO VILLAGE"));
}, child: Text("Add Ledger"))
        ],
      ),
    );
  }
}
