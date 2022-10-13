import 'package:bl_dairy_app/controller/productionController.dart';
import 'package:bl_dairy_app/model/productionModel.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_feather_icons/flutter_feather_icons.dart';
import 'package:textfield_search/textfield_search.dart';
import 'package:velocity_x/velocity_x.dart';

import '../../constants/Theme.dart';

class ProductionScreen extends StatefulWidget {
  const ProductionScreen({Key? key}) : super(key: key);

  @override
  State<ProductionScreen> createState() => _ProductionScreenState();
}

class _ProductionScreenState extends State<ProductionScreen> {
  TextEditingController PrdNameController = TextEditingController();
  TextEditingController searchController = TextEditingController();

  TextEditingController RmController = TextEditingController();

  TextEditingController RmQtyController = TextEditingController();

  TextEditingController RmRateController = TextEditingController();

  TextEditingController RmAmntController = TextEditingController();

  List<RawMaterialModel> rawMaterialNeeded = [];
  final searchList = ['Item 1', 'Item 2', 'Item 3', 'Item 4', 'Item 5'];
  int grandTotal = 0;
  @override
  void dispose() {
    PrdNameController.dispose();
    searchController.dispose();
    RmAmntController.dispose();
    RmQtyController.dispose();
    RmController.dispose();
    RmRateController.dispose();
    RmAmntController.dispose();

    super.dispose();
  }

  // mocking a future
  Future<List> fetchSimpleData() async {
    await Future.delayed(const Duration(milliseconds: 2000));
    List list = <dynamic>[];
    // create a list from the text input of three items
    // to mock a list of items from an http call
    list.add('Test' ' Item 1');
    list.add('Test' ' Item 2');
    list.add('Test' ' Item 3');
    return list;
  }

  @override
  Widget build(BuildContext context) {
    final Size size = MediaQuery.of(context).size;

    return Scaffold(
      body: SingleChildScrollView(
        child: SafeArea(
          child: Padding(
            padding: const EdgeInsets.symmetric(vertical: 20, horizontal: 15),
            child: Column(
              children: [
                Row(
                  children: const [
                    Text(
                      'Production',
                      style:
                          TextStyle(fontSize: 25, fontWeight: FontWeight.bold),
                    )
                  ],
                ),
                const SizedBox(
                  height: 20,
                ),
                TextFieldSearch(
                  initialList: searchList,
                  label: 'Product Name',
                  controller: searchController,
                ),
                // TextField(
                //   controller: PrdNameController,
                //   decoration: const InputDecoration(
                //     contentPadding:
                //         EdgeInsets.symmetric(vertical: 0, horizontal: 15),
                //     labelStyle: TextStyle(fontSize: 14),
                //     labelText: 'Product Name',
                //     border: OutlineInputBorder(),
                //   ),
                // ),
                const SizedBox(
                  height: 20,
                ),
                Material(
                  elevation: 3,
                  borderRadius: BorderRadius.circular(5),
                  child: Container(
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(10),
                    ),
                    padding: const EdgeInsets.fromLTRB(10, 2, 10, 2),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        const Text('Create Order'),
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
                                      padding: const EdgeInsets.fromLTRB(
                                          20, 15, 20, 0),
                                      child: Column(
                                        children: [
                                          TextField(
                                            controller: RmController,
                                            decoration: const InputDecoration(
                                              contentPadding:
                                                  EdgeInsets.symmetric(
                                                      vertical: 0,
                                                      horizontal: 15),
                                              labelStyle:
                                                  TextStyle(fontSize: 14),
                                              labelText: 'Product',
                                              border: OutlineInputBorder(),
                                            ),

                                            // onChanged: (value) {
                                            //   BookOrderController.fetchItems(
                                            //       value);
                                            // },
                                          ),
                                          const SizedBox(
                                            height: 20,
                                          ),
                                          Row(
                                            mainAxisAlignment:
                                                MainAxisAlignment.spaceBetween,
                                            children: [
                                              Expanded(
                                                child: TextField(
                                                  controller: RmQtyController,
                                                  keyboardType:
                                                      TextInputType.number,
                                                  decoration:
                                                      const InputDecoration(
                                                    contentPadding:
                                                        EdgeInsets.symmetric(
                                                            vertical: 0,
                                                            horizontal: 15),
                                                    labelStyle:
                                                        TextStyle(fontSize: 14),
                                                    labelText: 'Quantity',
                                                    border:
                                                        OutlineInputBorder(),
                                                  ),
                                                  onChanged: (value) {
                                                    setState(() {
                                                      RmAmntController
                                                          .text = (int.parse(
                                                                  RmQtyController
                                                                      .text) *
                                                              int.parse(
                                                                  RmRateController
                                                                      .text))
                                                          .toString();
                                                    });
                                                  },
                                                  // controller: bQuantityController,
                                                ),
                                              ),
                                              const SizedBox(
                                                width: 8,
                                              ),
                                              Expanded(
                                                child: TextField(
                                                  controller: RmRateController,
                                                  onChanged: (value) {
                                                    setState(() {
                                                      RmAmntController
                                                          .text = (int.parse(
                                                                  RmQtyController
                                                                      .text) *
                                                              int.parse(
                                                                  RmRateController
                                                                      .text))
                                                          .toString();
                                                    });
                                                  },
                                                  decoration:
                                                      const InputDecoration(
                                                    contentPadding:
                                                        EdgeInsets.symmetric(
                                                            vertical: 0,
                                                            horizontal: 15),
                                                    labelStyle:
                                                        TextStyle(fontSize: 14),
                                                    labelText: 'Rate',
                                                    border:
                                                        OutlineInputBorder(),
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
                                              Expanded(
                                                child: TextField(
                                                  controller: RmAmntController,

                                                  decoration:
                                                      const InputDecoration(
                                                    contentPadding:
                                                        EdgeInsets.symmetric(
                                                            vertical: 0,
                                                            horizontal: 15),
                                                    labelStyle:
                                                        TextStyle(fontSize: 14),
                                                    labelText: 'Amount',
                                                    border:
                                                        OutlineInputBorder(),
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
                                                  // controller: bAmountController,
                                                ),
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
                                                      RmController.clear();
                                                      RmRateController.clear();
                                                      RmQtyController.clear();
                                                      Navigator.pop(context);
                                                    },
                                                    icon: const Icon(
                                                      FeatherIcons.trash2,
                                                      size: 18,
                                                    ),
                                                    label: const Text('Delete'),
                                                    style: ElevatedButton
                                                        .styleFrom(
                                                      padding: const EdgeInsets
                                                          .fromLTRB(0, 4, 0, 4),
                                                      backgroundColor:
                                                          MyColors.red,
                                                      shape:
                                                          RoundedRectangleBorder(
                                                        borderRadius:
                                                            BorderRadius
                                                                .circular(5),
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
                                                      grandTotal += int.parse(
                                                              RmQtyController
                                                                  .text) *
                                                          int.parse(
                                                              RmRateController
                                                                  .text);
                                                      rawMaterialNeeded.add(
                                                          RawMaterialModel(
                                                              Rm: RmController
                                                                  .text,
                                                              RmQty: int.parse(
                                                                  RmQtyController
                                                                      .text),
                                                              RmRate: int.parse(
                                                                  RmRateController
                                                                      .text)));

                                                      RmController.clear();
                                                      RmRateController.clear();
                                                      RmQtyController.clear();
                                                      setState(() {});
                                                      Navigator.pop(context);
                                                    },
                                                    icon: const Icon(
                                                      FeatherIcons.plus,
                                                      size: 18,
                                                    ),
                                                    label: const Text('Add'),
                                                    style: ElevatedButton
                                                        .styleFrom(
                                                      backgroundColor:
                                                          MyColors.green,
                                                      shape:
                                                          RoundedRectangleBorder(
                                                        borderRadius:
                                                            BorderRadius
                                                                .circular(5),
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
                  ),
                ),
                Column(
                  children: [
                    ListTile(
                      title: Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: const [
                          Text(
                            'Order Name',
                            style: TextStyle(
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                          Text(
                            'Quantity',
                            style: TextStyle(
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                          Text(
                            'Rate',
                            style: TextStyle(
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                          Text(
                            'Amount',
                            style: TextStyle(
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                        ],
                      ),
                    ),
                    const Divider(
                      thickness: 0.5,
                      color: Colors.grey,
                    ),
                  ],
                ),
                ListView.separated(
                    physics: const NeverScrollableScrollPhysics(),
                    shrinkWrap: true,
                    itemCount: rawMaterialNeeded.length,
                    separatorBuilder: (context, index) {
                      return const Divider(
                        thickness: 0.5,
                        color: Colors.grey,
                      );
                    },
                    itemBuilder: (context, index) {
                      final item = rawMaterialNeeded[index];
                      return ListTile(
                        title: Row(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(item.Rm),
                            Text(item.RmQty.toString()),
                            Text(item.RmRate.toString()),
                            Text((item.RmRate * item.RmQty).toString())
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
                      Text(grandTotal.toString()),
                    ],
                  ),
                ),
                ElevatedButton(
                    onPressed: () {
                      ProductionController.addProduction(Production(
                          FinishGoods: PrdNameController.text,
                          FinishGoodsQty: 12,
                          ProductionDate: Timestamp.now(),
                          rawMaterialList: rawMaterialNeeded));
                    },
                    child: const Text("Add To Production"))
              ],
            ),
          ),
        ),
      ),
    );
  }
}
