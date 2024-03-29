import 'package:bl_dairy_app/controller/RmController.dart';
import 'package:bl_dairy_app/controller/productionController.dart';
import 'package:bl_dairy_app/model/RmModel.dart';
import 'package:bl_dairy_app/view/screens/AddRmItem.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:searchfield/searchfield.dart';
import 'package:get/get.dart';
import 'package:velocity_x/velocity_x.dart';
import '../../constants/Theme.dart';
import 'package:flutter_feather_icons/flutter_feather_icons.dart';

class RmPurchaseScreen extends StatefulWidget {
  const RmPurchaseScreen({Key? key}) : super(key: key);

  @override
  State<RmPurchaseScreen> createState() => _RmPurchaseScreenState();
}

class _RmPurchaseScreenState extends State<RmPurchaseScreen> {
  TextEditingController RmNameController = TextEditingController();
  TextEditingController PricingController = TextEditingController();
  TextEditingController QtyController = TextEditingController();
  List<RmModel> RmList = [];
  var searchList = [];
  double grandTotal = 0;

  GetRmName() async {
    searchList.clear();
    searchList = await ProductionController.fetchAllRmName();

    setState(() {
      print(searchList);
    });
  }

  @override
  void initState() {
    GetRmName();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final Size size = MediaQuery.of(context).size;
    return Scaffold(
        floatingActionButton: ElevatedButton(
          onPressed: () {
            Navigator.push(
                context, MaterialPageRoute(builder: (context) => AddNewRm()));
          },
          child: Text("Add New Item"),
        ),
        appBar: AppBar(
          title: const Text('Raw material Purchase'),
          backgroundColor: MyColors.primary,
        ),
        body: Padding(
          padding: const EdgeInsets.fromLTRB(15, 15, 15, 0),
          child: Column(
            children: [
              const SizedBox(
                height: 15,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  const Text('Purchase Raw Material'),
                  ElevatedButton(
                    onPressed: () {
                      VxBottomSheet.bottomSheetView(
                        context,
                        elevation: 20,
                        isDismissible: true,
                        backgroundColor: Colors.white,
                        isSafeAreaFromBottom: true,
                        child: SizedBox(
                          height: MediaQuery.of(context).size.height,
                          child: Column(
                            children: <Widget>[
                              Material(
                                elevation: 2,
                                child: Align(
                                  alignment: Alignment.centerRight,
                                  child: IconButton(
                                    onPressed: () {
                                      Navigator.pop(context);
                                    },
                                    icon: const Icon(
                                      FeatherIcons.x,
                                      color: MyColors.defaultColor,
                                    ),
                                  ),
                                ),
                              ),
                              const SizedBox(
                                height: 5,
                              ),
                              Padding(
                                padding:
                                    const EdgeInsets.fromLTRB(20, 15, 20, 0),
                                child: Column(
                                  children: [
                                    SearchField(
                                      controller: RmNameController,

                                      suggestions: searchList
                                          .map((e) => SearchFieldListItem(e))
                                          .toList(),

                                      // searchList.map((e) {
                                      //   print(e);
                                      //   return SearchFieldListItem(e);
                                      // }).toList(),

                                      suggestionState: Suggestion.hidden,
                                      textInputAction: TextInputAction.next,
                                      hint: 'Raw Material Name',
                                      hasOverlay: false,
                                      searchStyle: TextStyle(
                                        fontSize: 18,
                                        color: Colors.black.withOpacity(0.8),
                                      ),
                                      validator: (x) {
                                        if (!searchList.contains(x) ||
                                            x!.isEmpty) {
                                          return 'Please Enter a valid State';
                                        }
                                        return null;
                                      },
                                      searchInputDecoration: InputDecoration(
                                        focusedBorder: OutlineInputBorder(
                                          borderSide: BorderSide(
                                            color:
                                                Colors.black.withOpacity(0.8),
                                          ),
                                        ),
                                        border: const OutlineInputBorder(
                                          borderSide:
                                              BorderSide(color: Colors.red),
                                        ),
                                      ),
                                      maxSuggestionsInViewPort: 6,
                                      itemHeight: 50,
                                      onSuggestionTap: (TappedName) {
                                        print(
                                            "TAPPED NAME TAPPED NAME TAPPED NAME");
                                        print(TappedName.searchKey);
                                      },
                                    ),

                                    // TextFieldSearch(
                                    //   controller: RmNameController,
                                    //   initialList: searchList,
                                    //   itemsInView: 10,
                                    //   label: 'Raw Material Name',
                                    //   decoration: const InputDecoration(
                                    //     labelText: "Raw Material Name",
                                    //     border: OutlineInputBorder(),
                                    //   ),
                                    // ),

                                    // TextField(
                                    //   controller: RmController,
                                    //   decoration: const InputDecoration(
                                    //     contentPadding:
                                    //         EdgeInsets.symmetric(
                                    //             vertical: 0,
                                    //             horizontal: 15),
                                    //     labelStyle:
                                    //         TextStyle(fontSize: 14),
                                    //     labelText: 'Product',
                                    //     border: OutlineInputBorder(),
                                    //   ),

                                    //   // onChanged: (value) {
                                    //   //   BookOrderController.fetchItems(
                                    //   //       value);
                                    //   // },
                                    // ),
                                    const SizedBox(
                                      height: 20,
                                    ),
                                    Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      children: [
                                        Expanded(
                                          child: TextField(
                                            controller: QtyController,
                                            keyboardType: TextInputType.number,
                                            decoration: const InputDecoration(
                                              contentPadding:
                                                  EdgeInsets.symmetric(
                                                      vertical: 0,
                                                      horizontal: 15),
                                              labelStyle:
                                                  TextStyle(fontSize: 14),
                                              labelText: 'Quantity',
                                              border: OutlineInputBorder(),
                                            ),
                                            onChanged: (value) {
                                              setState(() {});
                                            },
                                            // controller: bQuantityController,
                                          ),
                                        ),
                                        const SizedBox(
                                          width: 8,
                                        ),
                                        Expanded(
                                          child: TextField(
                                            controller: PricingController,

                                            keyboardType: TextInputType.number,
                                            decoration: const InputDecoration(
                                              contentPadding:
                                                  EdgeInsets.symmetric(
                                                      vertical: 0,
                                                      horizontal: 15),
                                              labelStyle:
                                                  TextStyle(fontSize: 14),
                                              labelText: 'Rate',
                                              border: OutlineInputBorder(),
                                            ),
                                            // onChanged: (value) {
                                            //   setState(() {
                                            //     bAmountController
                                            //         .text = (int.parse(
                                            //                 bRateController
                                            //                     .text) *
                                            //             int.parse(
                                            //                 bQuantityController
                                            //                     .text))
                                            //         .toString();
                                            //   });
                                            // },
                                            // controller: bRateController,
                                          ),
                                        ),
                                        const SizedBox(
                                          width: 8,
                                        ),
                                      ],
                                    ),
                                    const SizedBox(
                                      height: 20,
                                    ),
                                    //
                                    Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      children: [
                                        Expanded(
                                          child: SizedBox(
                                            height: size.height * 0.06,
                                            width: size.width * 0.4,
                                            child: ElevatedButton.icon(
                                              onPressed: () {
                                                RmNameController.clear();
                                                PricingController.clear();
                                                QtyController.clear();
                                                Navigator.pop(context);
                                              },
                                              icon: const Icon(
                                                FeatherIcons.trash2,
                                                size: 18,
                                              ),
                                              label: const Text('Delete'),
                                              style: ElevatedButton.styleFrom(
                                                padding:
                                                    const EdgeInsets.fromLTRB(
                                                        0, 4, 0, 4),
                                                backgroundColor: MyColors.red,
                                                shape: RoundedRectangleBorder(
                                                  borderRadius:
                                                      BorderRadius.circular(5),
                                                ),
                                              ),
                                            ),
                                          ),
                                        ),
                                        const SizedBox(
                                          width: 20,
                                        ),
                                        Expanded(
                                          child: SizedBox(
                                            height: size.height * 0.06,
                                            width: size.width * 0.4,
                                            child: ElevatedButton.icon(
                                              onPressed: () {
                                                setState(() {
                                                  RmList.add(RmModel(
                                                      RmName:
                                                          RmNameController.text,
                                                      RmPrice: double.parse(
                                                          PricingController
                                                              .text),
                                                      RmQty: double.parse(
                                                          QtyController.text),
                                                      purchaseTime:
                                                          Timestamp.now()));
                                                  grandTotal += double.parse(
                                                          PricingController
                                                              .text) *
                                                      double.parse(
                                                          QtyController.text);
                                                });
                                                RmNameController.clear();
                                                PricingController.clear();
                                                QtyController.clear();

                                                Navigator.pop(context);
                                              },
                                              icon: const Icon(
                                                FeatherIcons.plus,
                                                size: 18,
                                              ),
                                              label: const Text('Add'),
                                              style: ElevatedButton.styleFrom(
                                                backgroundColor: MyColors.green,
                                                shape: RoundedRectangleBorder(
                                                  borderRadius:
                                                      BorderRadius.circular(5),
                                                ),
                                              ),
                                            ),
                                          ),
                                        ),
                                      ],
                                    ),
                                  ],
                                ),
                              ),
                            ],
                          ),
                        ),
                      );
                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: MyColors.green,
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(5)),
                    ),
                    child: const Text('   Add +   '),
                  )
                ],
              ),
              ListView.separated(
                  physics: const NeverScrollableScrollPhysics(),
                  shrinkWrap: true,
                  itemCount: RmList.length,
                  separatorBuilder: (context, index) {
                    return const Divider(
                      thickness: 0.5,
                      color: Colors.grey,
                    );
                  },
                  itemBuilder: (context, index) {
                    final item = RmList[index];

                    return ListTile(
                      title: Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(item.RmName),
                          Text(item.RmQty.toString()),
                          Text(item.RmPrice.toString()),
                          Text((item.RmPrice * item.RmQty).toString())
                        ],
                      ),
                    );
                  }),
              ListTile(
                title: Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    const Text('Grand Total'),
                    const Text('--'),
                    const Text('--'),
                    Text(grandTotal.toStringAsFixed(2)),
                  ],
                ),
              ),
              ElevatedButton(
                  onPressed: () async {
                    if (RmList.isEmpty) {
                      Get.snackbar("Purchase Failed",
                          "Please Add Some Raw Material First");
                    } else {
                      for (var Rm in RmList) {
                        await RmController.PurhcaseRm(RmModel(
                                RmName: Rm.RmName,
                                RmPrice: Rm.RmPrice,
                                RmQty: Rm.RmQty,
                                purchaseTime: Rm.purchaseTime))
                            .then((_) {
                          print("ADDED");
                        });
                      }
                      setState(() {
                        RmList.clear();
                        grandTotal = 0;
                      });

                      Get.snackbar("Raw Material Purchase Successful",
                          "Price Updated and Entry Added To Database");
                    }
                  },
                  child: const Text("Purhcase Raw Material")),
            ],
          ),
        ));
  }
}
