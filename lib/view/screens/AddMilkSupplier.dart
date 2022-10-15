import 'package:bl_dairy_app/controller/milkSupplierController.dart';
import 'package:bl_dairy_app/model/ledgerModel.dart';
import 'package:flutter/material.dart';


class AddMilkSupplierScreen extends StatefulWidget {
  const AddMilkSupplierScreen({Key? key}) : super(key: key);

  @override
  State<AddMilkSupplierScreen> createState() => _AddMilkSupplierScreenState();
}

class _AddMilkSupplierScreenState extends State<AddMilkSupplierScreen> {
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
            milkSupplierController.addNewMilkSupplier(MilkSupplierModel(FatRate: "2.5", MilkType: "Cow", Mobile: "9999888", Name: "DEMO NAME", Village: "DEMO VILLAGE"));
          }, child: Text("Add Ledger"))
        ],
      ),
    );
  }
}
