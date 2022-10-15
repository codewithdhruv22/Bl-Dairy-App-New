import 'package:bl_dairy_app/controller/milkPurchaseController.dart';
import 'package:bl_dairy_app/model/milkPurchaseModel.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:textfield_search/textfield_search.dart';

import '../../constants/Theme.dart';

class MilkPurchaseScreen extends StatefulWidget {
  const MilkPurchaseScreen({Key? key}) : super(key: key);

  @override
  State<MilkPurchaseScreen> createState() => _MilkPurchaseScreenState();
}

final _formKey = GlobalKey<FormState>();
TextEditingController Suppliername = TextEditingController();
final searchList = ['Item 1', 'Item 2', 'Item 3', 'Item 4', 'Item 5'];

class _MilkPurchaseScreenState extends State<MilkPurchaseScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Form(
          key: _formKey,
          child: Padding(
            padding: const EdgeInsets.all(10.0),
            child: Column(
              children: [
                TextFieldSearch(
                  initialList: searchList,
                  itemsInView: 10,
                  label: 'Supplier Name',
                  controller: Suppliername,
                  decoration: const InputDecoration(
                    labelText: 'Supplier Name',
                    border: OutlineInputBorder(),
                  ),
                ),
                const SizedBox(
                  height: 10,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    SizedBox(
                      width: MediaQuery.of(context).size.width * 0.5,
                      child: TextFormField(
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return 'Select Shift';
                          }
                          return null;
                        },
                        decoration: const InputDecoration(
                          contentPadding:
                              EdgeInsets.symmetric(vertical: 0, horizontal: 15),
                          labelStyle: TextStyle(fontSize: 14),
                          labelText: 'Shift',
                          border: OutlineInputBorder(),
                        ),
                        // controller: advancePaymentController,
                      ),
                    ),
                    const SizedBox(
                      width: 12,
                    ),
                    InkWell(
                      // onTap: () => _selectDate(ref),
                      child: SizedBox(
                        width: MediaQuery.of(context).size.width * 0.4,
                        child: Container(
                          height: 49,
                          decoration: BoxDecoration(
                            border: Border.all(
                              color: MyColors.defaultColor,
                            ),
                            borderRadius: BorderRadius.circular(4),
                          ),
                          child: const Center(
                            child: Text(
                              'date',
                              // "${date.day}-${date.month}-${date.year}",
                              style: TextStyle(
                                fontSize: 16,
                              ),
                            ),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
                const SizedBox(
                  height: 10,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    SizedBox(
                      width: MediaQuery.of(context).size.width * 0.4,
                      child: TextFormField(
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
                          labelText: 'Milk Type',
                          border: OutlineInputBorder(),
                        ),
                        // controller: advancePaymentController,
                      ),
                    ),
                    const SizedBox(
                      width: 12,
                    ),
                    SizedBox(
                      width: MediaQuery.of(context).size.width * 0.45,
                      child: TextFormField(
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
                          labelText: 'Fat Rate',
                          border: OutlineInputBorder(),
                        ),
                        // controller: advancePaymentController,
                      ),
                    ),
                  ],
                ),
                const SizedBox(
                  height: 10,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    SizedBox(
                      width: MediaQuery.of(context).size.width * 0.4,
                      child: TextFormField(
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return 'Fill SNF Value';
                          }
                          return null;
                        },
                        decoration: const InputDecoration(
                          contentPadding:
                              EdgeInsets.symmetric(vertical: 0, horizontal: 15),
                          labelStyle: TextStyle(fontSize: 14),
                          labelText: 'SNF Value',
                          border: OutlineInputBorder(),
                        ),
                        // controller: advancePaymentController,
                      ),
                    ),
                    const SizedBox(
                      width: 12,
                    ),
                    SizedBox(
                      width: MediaQuery.of(context).size.width * 0.45,
                      child: TextFormField(
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return 'Fill Value';
                          }
                          return null;
                        },
                        decoration: const InputDecoration(
                          contentPadding:
                              EdgeInsets.symmetric(vertical: 0, horizontal: 15),
                          labelStyle: TextStyle(fontSize: 14),
                          labelText: 'Fat',
                          border: OutlineInputBorder(),
                        ),
                        // controller: advancePaymentController,
                      ),
                    ),
                  ],
                ),
                const SizedBox(
                  height: 10,
                ),
                const Align(
                    alignment: Alignment.topLeft,
                    child:
                        Text("TOTAL PRICE - Fat*Supplier Fat Rate * Quantity")),
                ElevatedButton(
                    onPressed: () {
                      MilkPurchaseController.addMilkPurchase(MilkPurchaseModel(
                          Date: Timestamp.now(),
                          fat: 4,
                          milkQty: 23,
                          milkType: "COW",
                          shift: "MORNING",
                          snfVal: 6.3,
                          SupplierName: "DHRUV"));
                    },
                    child: const Text("Complete"))
              ],
            ),
          ),
        ),
      ),
    );
  }
}
