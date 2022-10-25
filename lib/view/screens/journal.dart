import 'package:bl_dairy_app/controller/milkSupplierController.dart';
import 'package:dropdown_search/dropdown_search.dart';
import 'package:flutter/material.dart';

import '../../model/ledgerModel.dart';

class JournalScreen extends StatefulWidget {
  const JournalScreen({Key? key}) : super(key: key);

  @override
  State<JournalScreen> createState() => _JournalScreenState();
}

class _JournalScreenState extends State<JournalScreen> {

  late String whoPaidSuppName;
  late String toPaidSuppName;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body : Column(
        children: [
          DropdownSearch<MilkSupplierModel>(
            asyncItems: (String filter) =>
                milkSupplierController.fetchOneLedger(filter),
            itemAsString: (MilkSupplierModel u) => u.Name,
            onChanged: (MilkSupplierModel? data) {
              setState(() {
whoPaidSuppName  = data!.Name;
                print(data.Name);
                print(data.FatRate);

              });
            },
            dropdownDecoratorProps: const DropDownDecoratorProps(
              dropdownSearchDecoration:
              InputDecoration(labelText: "Person Who Paid"),
            ),
          ),



          DropdownSearch<MilkSupplierModel>(
            asyncItems: (String filter) =>
                milkSupplierController.fetchOneLedger(filter),
            itemAsString: (MilkSupplierModel u) => u.Name,
            onChanged: (MilkSupplierModel? data) {
              setState(() {
                 toPaidSuppName = data!.Name;
                print(data.Name);
                print(data.FatRate);

              });
            },
            dropdownDecoratorProps: const DropDownDecoratorProps(
              dropdownSearchDecoration:
              InputDecoration(labelText: "Person To Paid"),
            ),
          ),


          ElevatedButton(onPressed: (){}, child: Text("Credit")),
          ElevatedButton(onPressed: (){}, child: Text("Debit"))
        ],
      )
    );
  }
}
