import 'package:bl_dairy_app/controller/productionController.dart';
import 'package:bl_dairy_app/model/productionModel.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_feather_icons/flutter_feather_icons.dart';
import 'package:velocity_x/velocity_x.dart';

import '../../constants/Theme.dart';

class ProductionScreen extends StatelessWidget {
  const ProductionScreen({Key? key}) : super(key: key);

  ProductionPrinter() async {
    await ProductionController.fetchProduction().then((production) {
      for (var element in production) {
        print(element.FinishGoods.toString());
        print(element.ProductionDate.toString());
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    final Size size = MediaQuery.of(context).size;
    ProductionPrinter();

    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(vertical: 20, horizontal: 15),
          child: Column(
            children: [
              Row(
                children: const [
                  Text(
                    'Production',
                    style: TextStyle(fontSize: 25, fontWeight: FontWeight.bold),
                  )
                ],
              ),
              const SizedBox(
                height: 20,
              ),
              TextFormField(
                decoration: const InputDecoration(
                  contentPadding:
                      EdgeInsets.symmetric(vertical: 0, horizontal: 15),
                  labelStyle: TextStyle(fontSize: 14),
                  labelText: 'Product Name',
                  border: OutlineInputBorder(),
                ),
              ),
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
                                        TextFormField(
                                          decoration: const InputDecoration(
                                            contentPadding:
                                                EdgeInsets.symmetric(
                                                    vertical: 0,
                                                    horizontal: 15),
                                            labelStyle: TextStyle(fontSize: 14),
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
                                              child: TextFormField(
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
                                                  border: OutlineInputBorder(),
                                                ),
                                                // controller: bQuantityController,
                                              ),
                                            ),
                                            const SizedBox(
                                              width: 8,
                                            ),
                                            Expanded(
                                              child: TextFormField(
                                                decoration:
                                                    const InputDecoration(
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
                                            Expanded(
                                              child: TextFormField(
                                                decoration:
                                                    const InputDecoration(
                                                  contentPadding:
                                                      EdgeInsets.symmetric(
                                                          vertical: 0,
                                                          horizontal: 15),
                                                  labelStyle:
                                                      TextStyle(fontSize: 14),
                                                  labelText: 'Amount',
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
                                                    // Navigator.pop(context);
                                                  },
                                                  icon: const Icon(
                                                    FeatherIcons.trash2,
                                                    size: 18,
                                                  ),
                                                  label: const Text('Delete'),
                                                  style:
                                                      ElevatedButton.styleFrom(
                                                    padding: const EdgeInsets
                                                        .fromLTRB(0, 4, 0, 4),
                                                    backgroundColor:
                                                        MyColors.red,
                                                    shape:
                                                        RoundedRectangleBorder(
                                                      borderRadius:
                                                          BorderRadius.circular(
                                                              5),
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
                                                  onPressed: () {},
                                                  //   int amount = int.parse(
                                                  //           bRateController
                                                  //               .text) *
                                                  //       int.parse(
                                                  //           bQuantityController
                                                  //               .text);
                                                  //   grandTotal += amount;
                                                  //   setState(() {
                                                  //     OrderItemLocal.add(OrderModel(
                                                  //         Rate: int.parse(
                                                  //             bRateController
                                                  //                 .text),
                                                  //         Quantity: int.parse(
                                                  //             bQuantityController
                                                  //                 .text),
                                                  //         Amount: amount,
                                                  //         OrderName:
                                                  //             bProductNameController
                                                  //                 .text));
                                                  //     databaseOrderItem.add({
                                                  //       "Rate": int.parse(
                                                  //           bRateController
                                                  //               .text),
                                                  //       "Quantity": int.parse(
                                                  //           bQuantityController
                                                  //               .text),
                                                  //       "Amount": amount,
                                                  //       "OrderName":
                                                  //           bProductNameController
                                                  //               .text
                                                  //     });
                                                  //   });

                                                  //   bProductNameController
                                                  //       .clear();
                                                  //   bQuantityController.clear();
                                                  //   bRateController.clear();
                                                  //   bAmountController.clear();
                                                  //   Navigator.pop(context);
                                                  // },
                                                  icon: const Icon(
                                                    FeatherIcons.plus,
                                                    size: 18,
                                                  ),
                                                  label: const Text('Add'),
                                                  style:
                                                      ElevatedButton.styleFrom(
                                                    backgroundColor:
                                                        MyColors.green,
                                                    shape:
                                                        RoundedRectangleBorder(
                                                      borderRadius:
                                                          BorderRadius.circular(
                                                              5),
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
              ListTile(
                title: Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: const [
                    Text('Grand Total'),
                    Text('--'),
                    Text('--'),
                    Text('grandTotal.toString()'),
                  ],
                ),
              ),
              ElevatedButton(
                  onPressed: () {
                    ProductionController.addProduction(Production(
                        FinishGoods: "DORACAKE",
                        FinishGoodsQty: 12,
                        ProductionDate: Timestamp.now(),
                        rawMaterialList: [
                          RawMaterialModel(Rm: "Ras", RmQty: 66, RmRate: 25),
                          RawMaterialModel(Rm: "Malai", RmQty: 6, RmRate: 5),
                          RawMaterialModel(Rm: "Water", RmQty: 9, RmRate: 2),
                        ]));
                  },
                  child: const Text("Add To Production"))
            ],
          ),
        ),
      ),
    );
  }
}
