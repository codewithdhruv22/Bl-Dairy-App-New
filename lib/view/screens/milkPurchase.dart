import 'package:bl_dairy_app/controller/milkPurchaseController.dart';
import 'package:bl_dairy_app/controller/milkSupplierController.dart';
import 'package:bl_dairy_app/model/ledgerModel.dart';
import 'package:bl_dairy_app/model/milkPurchaseModel.dart';
import 'package:bl_dairy_app/view/screens/home.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dropdown_search/dropdown_search.dart';
import 'package:flutter/material.dart';
import 'package:flutter_feather_icons/flutter_feather_icons.dart';

import '../../constants/Theme.dart';

class MilkPurchaseScreen extends StatefulWidget {
  const MilkPurchaseScreen({Key? key}) : super(key: key);

  @override
  State<MilkPurchaseScreen> createState() => _MilkPurchaseScreenState();
}

final _formKey = GlobalKey<FormState>();
final List<MilkSupplierModel> searchList = [];
const List<String> milktyplist = <String>['Cow', 'Buffalow'];
const List<String> shiftlist = <String>['Morning', 'Evening'];
String dropdownValue = milktyplist.first;
String dropdownValue1 = shiftlist.first;

TextEditingController suppNameEdCont = TextEditingController();
TextEditingController shiftEdCont = TextEditingController();
TextEditingController milkTypeEdCont = TextEditingController();
TextEditingController fatEdCont = TextEditingController();
TextEditingController snfEdCont = TextEditingController();
TextEditingController qtyEdCont = TextEditingController();

double totalAmnt = 0.0;
double fatRate = 0.0;

class _MilkPurchaseScreenState extends State<MilkPurchaseScreen> {
  @override
  void initState() {
    suppNameEdCont.addListener(() async {
      final String value = suppNameEdCont.value.text;
      searchList.clear();
      searchList.addAll(await milkSupplierController.fetchOneLedger(value));

      searchList.toSet().toList();

      // YOUR CODE
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Column(
          children: [
            Material(
              elevation: 4,
              child: Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    IconButton(
                      onPressed: () {
                        Navigator.pop(context);
                      },
                      icon: const Icon(
                        FeatherIcons.arrowLeft,
                        color: MyColors.black,
                      ),
                    ),
                    const Text(
                      'Milk Purchase',
                      style: TextStyle(fontSize: 15),
                    ),
                  ]),
            ),
            Form(
              key: _formKey,
              child: Padding(
                padding: const EdgeInsets.all(10.0),
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

                          fatRate += double.parse(data.FatRate.toString());
                        });
                      },
                      dropdownDecoratorProps: const DropDownDecoratorProps(
                        dropdownSearchDecoration:
                            InputDecoration(labelText: "Select Supplier"),
                      ),
                    ),

//                 SearchField(
//                   suggestionState: Suggestion.expand,
//                   textInputAction: TextInputAction.next,
// controller: suppNameEdCont,
// suggestions: searchList.map((e) => SearchFieldListItem(e.Name)).toList(),
//                   suggestionAction: SuggestionAction.unfocus,
//                   onSuggestionTap: (value){
//
//                   },
//                 ),
                    const SizedBox(
                      height: 10,
                    ),
                    // TextFieldSearch(
                    //
                    //   controller : suppNameEdCont,
                    //   initialList: searchList,
                    //   itemsInView: 10,
                    //   label: 'Supplier Name',
                    //   decoration: const InputDecoration(
                    //     labelText: 'Supplier Name',
                    //     border: OutlineInputBorder(),
                    //   ),
                    // ),
                    const SizedBox(
                      height: 10,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        SizedBox(
                          width: MediaQuery.of(context).size.width * 0.5,
                          child: DropdownButton<String>(
                            onChanged: (String? value) {
                              // This is called when the user selects an item.
                              setState(() {
                                dropdownValue1 = value!;
                                shiftEdCont.text = value;
                              });
                            },
                            hint: const Text('Milk Type'),
                            items: shiftlist
                                .map<DropdownMenuItem<String>>((String value) {
                              return DropdownMenuItem<String>(
                                value: value,
                                child: Text(value),
                              );
                            }).toList(),
                            value: dropdownValue1,
                            icon: const Icon(Icons.arrow_downward),
                            elevation: 16,
                            style: const TextStyle(color: Colors.deepPurple),
                            underline: Container(
                              height: 2,
                              color: Colors.deepPurpleAccent,
                            ),

                            // decoration: const InputDecoration(
                            //   contentPadding:
                            //       EdgeInsets.symmetric(vertical: 0, horizontal: 15),
                            //   labelStyle: TextStyle(fontSize: 14),
                            //   labelText: 'Milk Type',
                            //   border: OutlineInputBorder(),
                            // ),
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
                                  "Today's Date",
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
                      children: [
                        SizedBox(
                          width: MediaQuery.of(context).size.width * 0.4,
                          child: DropdownButton<String>(
                            onChanged: (String? value) {
                              // This is called when the user selects an item.
                              setState(() {
                                dropdownValue = value!;
                                milkTypeEdCont.text = value;
                              });
                            },
                            hint: const Text('Milk Type'),
                            items: milktyplist
                                .map<DropdownMenuItem<String>>((String value) {
                              return DropdownMenuItem<String>(
                                value: value,
                                child: Text(value),
                              );
                            }).toList(),
                            value: dropdownValue,
                            icon: const Icon(Icons.arrow_downward),
                            elevation: 16,
                            style: const TextStyle(color: Colors.deepPurple),
                            underline: Container(
                              height: 2,
                              color: Colors.deepPurpleAccent,
                            ),

                            // decoration: const InputDecoration(
                            //   contentPadding:
                            //       EdgeInsets.symmetric(vertical: 0, horizontal: 15),
                            //   labelStyle: TextStyle(fontSize: 14),
                            //   labelText: 'Milk Type',
                            //   border: OutlineInputBorder(),
                            // ),
                            // controller: advancePaymentController,
                          ),
                        ),
                        const SizedBox(
                          width: 10,
                        ),
                        Expanded(
                          child: TextFormField(
                            keyboardType: TextInputType.number,
                            controller: fatEdCont,
                            validator: (value) {
                              if (value == null || value.isEmpty) {
                                return 'Fill Rate';
                              }
                              return null;
                            },
                            decoration: const InputDecoration(
                              contentPadding: EdgeInsets.symmetric(
                                  vertical: 0, horizontal: 15),
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
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        SizedBox(
                          width: MediaQuery.of(context).size.width * 0.4,
                          child: TextFormField(
                            keyboardType: TextInputType.number,
                            controller: snfEdCont,
                            validator: (value) {
                              if (value == null || value.isEmpty) {
                                return 'Fill SNF Value';
                              }
                              return null;
                            },
                            decoration: const InputDecoration(
                              contentPadding: EdgeInsets.symmetric(
                                  vertical: 0, horizontal: 15),
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
                            controller: qtyEdCont,
                            onChanged: (value) {
                              setState(() {
                                totalAmnt = double.parse(fatEdCont.text) *
                                    fatRate *
                                    double.parse(qtyEdCont.text);
                              });
                            },
                            keyboardType: TextInputType.number,
                            validator: (value) {
                              if (value == null || value.isEmpty) {
                                return 'Fill Value';
                              }
                              return null;
                            },
                            decoration: const InputDecoration(
                              contentPadding: EdgeInsets.symmetric(
                                  vertical: 0, horizontal: 15),
                              labelStyle: TextStyle(fontSize: 14),
                              labelText: 'Quantity',
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
                    Align(
                        alignment: Alignment.topLeft,
                        child: Text(
                            "TOTAL PRICE - ${double.parse((totalAmnt).toStringAsFixed(2))}")),

                    ElevatedButton(
                        onPressed: () {
                          MilkPurchaseController.addMilkPurchase(
                              MilkPurchaseModel(
                            Date: Timestamp.now(),
                            fat: double.parse(fatEdCont.text),
                            milkQty: int.parse(qtyEdCont.text),
                            milkType: milkTypeEdCont.text,
                            shift: shiftEdCont.text,
                            snfVal: double.parse(snfEdCont.text),
                            SupplierName: suppNameEdCont.text,
                            totalAmnt: totalAmnt,
                          ));

                          fatRate = 0;
                          fatEdCont.clear();
                          qtyEdCont.clear();
                          milkTypeEdCont.clear();
                          shiftEdCont.clear();
                          snfEdCont.clear();
                          suppNameEdCont.clear();
                          totalAmnt = 0;

                          ScaffoldMessenger.of(context).showSnackBar(
                            const SnackBar(content: Text('Done')),
                          );
                          setState(() {});
                        },
                        child: const Text("Complete"))
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
