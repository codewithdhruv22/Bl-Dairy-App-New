import 'package:bl_dairy_app/controller/milkSupplierController.dart';
import 'package:bl_dairy_app/controller/paymentController.dart';
import 'package:bl_dairy_app/model/ledgerModel.dart';
import 'package:bl_dairy_app/model/paymentModel.dart';
import 'package:dropdown_search/dropdown_search.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class PaymentScreen extends StatefulWidget {
  const PaymentScreen({Key? key}) : super(key: key);

  @override
  State<PaymentScreen> createState() => _PaymentScreenState();
}

class _PaymentScreenState extends State<PaymentScreen> {

  TextEditingController amountController = TextEditingController();
  TextEditingController suppNameEdCont = TextEditingController();

  final List<MilkSupplierModel> searchList = [];

  @override
  void initState() {

    super.initState();
  }



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
                print("FAT RATE IS HERE");
                print(data!.Name);
                print(data.FatRate);
                suppNameEdCont.text = data.Name;

              });
            },
            dropdownDecoratorProps: const DropDownDecoratorProps(
              dropdownSearchDecoration:
              InputDecoration(labelText: "Select Supplier"),
            ),
          ),



          TextField(
            controller: amountController,
            decoration: InputDecoration(
              hintText: "Paid Amount"
            ),
          ),
          ElevatedButton(onPressed: ()async{
            await PaymentController.addPayment(PaymentModel(SupplierName:   suppNameEdCont.text, PaidAmount: double.parse(amountController.text))).then((_){
              Get.snackbar("ENTRY ADDED SUCCESSFULLY", "YOUR PAYMENT IS SUCCESSFULLY ADDED TO DATABASE");
            });

          }, child: Text("Add Entry"))
        ],
      )
    );
  }
}
