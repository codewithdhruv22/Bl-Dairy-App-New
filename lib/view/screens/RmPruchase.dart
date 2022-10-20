import 'package:bl_dairy_app/controller/RmController.dart';
import 'package:bl_dairy_app/controller/productionController.dart';
import 'package:bl_dairy_app/model/RmModel.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:textfield_search/textfield_search.dart';
import 'package:get/get.dart';

class RmPurchaseScreen extends StatefulWidget {
  const RmPurchaseScreen({Key? key}) : super(key: key);

  @override
  State<RmPurchaseScreen> createState() => _RmPurchaseScreenState();
}

class _RmPurchaseScreenState extends State<RmPurchaseScreen> {
  TextEditingController RmNameController = TextEditingController();
  TextEditingController PricingController = TextEditingController();
  TextEditingController QtyController = TextEditingController();
  final searchList = [];

  @override
  void initState() {
    RmNameController.addListener(() async {
      final String value = RmNameController.value.text;
      searchList.clear();
      searchList.addAll(await ProductionController.fetchRmName(value));
      searchList.toSet().toList();
      setState(() {
        print(searchList);
      });
      // YOUR CODE
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
body : Column(
  children: [
    TextFieldSearch(
      initialList: searchList,
      itemsInView: 10,
      label: 'Product Name',
      controller: RmNameController,
      decoration: const InputDecoration(
        labelText: 'Product Name',
        border: OutlineInputBorder(),
      ),
    ),

    TextField(
      controller: PricingController,
      decoration: InputDecoration(
        hintText: "Pricing/Unit"
      ),
    ),
    TextField(
      controller: QtyController,
      decoration: InputDecoration(
          hintText: "Quantity"
      ),
    ),

    ElevatedButton(onPressed: ()async{
      await RmController.PurhcaseRm(RmModel(RmName: RmNameController.text, RmPrice: double.parse(PricingController.text), RmQty: double.parse(QtyController.text) , purchaseTime: Timestamp.now())).then((_){
        Get.snackbar("Raw Material Purchase Successful", "Price Updated and Entry Added To Database");
      });
    }, child:Text("Purhcase Raw Material"))
  ],
)

    );
  }
}
