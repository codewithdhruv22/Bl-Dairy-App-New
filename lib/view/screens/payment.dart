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
        appBar: AppBar(),
        body: Padding(
          padding: const EdgeInsets.fromLTRB(15, 15, 15, 0),
          child: Column(
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
                  dropdownSearchDecoration: InputDecoration(
                    labelText: "Select Supplier",
                    border: OutlineInputBorder(),
                  ),
                ),
              ),
              const SizedBox(
                height: 15,
              ),
              TextFormField(
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Fill Amount';
                  }
                  return null;
                },
                decoration: const InputDecoration(
                  contentPadding:
                      EdgeInsets.symmetric(vertical: 0, horizontal: 15),
                  labelStyle: TextStyle(fontSize: 14),
                  labelText: 'Paid Amount',
                  border: OutlineInputBorder(),
                ),
                controller: amountController,
              ),
              const SizedBox(
                height: 15,
              ),
              ElevatedButton(
                  onPressed: () async {
                    await PaymentController.addPayment(PaymentModel(
                            SupplierName: suppNameEdCont.text,
                            PaidAmount: double.parse(amountController.text)))
                        .then((_) {
                      Get.snackbar("ENTRY ADDED SUCCESSFULLY",
                          "YOUR PAYMENT IS SUCCESSFULLY ADDED TO DATABASE");
                    });
                  },
                  child: const Text("Add Entry"))
            ],
          ),
        ));
  }
}
