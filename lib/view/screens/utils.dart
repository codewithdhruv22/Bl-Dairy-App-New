import 'package:bl_dairy_app/controller/book_order.dart';
import 'package:bl_dairy_app/model/BookOrderModel.dart';
import 'package:flutter/material.dart';
import 'package:flutter_feather_icons/flutter_feather_icons.dart';
import 'package:searchfield/searchfield.dart';
import 'package:velocity_x/velocity_x.dart';

import '../../constants/Theme.dart';

class UtilitiesScreen extends StatefulWidget {
  const UtilitiesScreen({Key? key}) : super(key: key);

  @override
  State<UtilitiesScreen> createState() => _UtilitiesScreenState();
}

final _formKey = GlobalKey<FormState>();

class _UtilitiesScreenState extends State<UtilitiesScreen> {
  TextEditingController WaReqFat = TextEditingController();
  TextEditingController WaMilkQty = TextEditingController();
  TextEditingController WaFat = TextEditingController();

  TextEditingController CsReqFat = TextEditingController();
  TextEditingController CsMilkQty = TextEditingController();
  TextEditingController CsFat = TextEditingController();

  TextEditingController bQuantityController = TextEditingController();
  TextEditingController bFatController = TextEditingController();

  List<double> QuantityList = [];
  List<double> FatList = [];

  double WaResult = 0.0;
  double CsResult = 0.0;
  double AvResult = 0.0;

  @override
  Widget build(BuildContext context) {
    final Size size = MediaQuery.of(context).size;
    return SafeArea(
        child: DefaultTabController(
            length: 3,
            child: Scaffold(
              appBar: AppBar(
                backgroundColor: MyColors.primary,
                title: const Text('Calculators'),
                bottom: const TabBar(tabs: [
                  Tab(
                    text: 'Water Addition',
                    icon: Icon(FeatherIcons.droplet),
                  ),
                  Tab(
                    text: 'Cream Seperation',
                    icon: Icon(FeatherIcons.cloudRain),
                  ),
                  Tab(
                    text: 'Average Fat',
                    icon: Icon(FeatherIcons.layers),
                  ),
                ]),
              ),
              body: Padding(
                padding: const EdgeInsets.all(15.0),
                child: TabBarView(
                  children: [
                    SingleChildScrollView(
                      child: Column(
                        children: [
                          TextFormField(
                            keyboardType: TextInputType.number,
                            controller: WaReqFat,
                            validator: (value) {
                              if (value == null || value.isEmpty) {
                                return 'Fill This';
                              }
                              return null;
                            },
                            decoration: const InputDecoration(
                              contentPadding: EdgeInsets.symmetric(
                                  vertical: 0, horizontal: 15),
                              labelStyle: TextStyle(fontSize: 14),
                              labelText: 'Required Fat',
                              border: OutlineInputBorder(),
                            ),
                            // controller: advancePaymentController,
                          ),
                          const SizedBox(
                            height: 20,
                          ),
                          TextFormField(
                            keyboardType: TextInputType.number,
                            controller: WaMilkQty,
                            validator: (value) {
                              if (value == null || value.isEmpty) {
                                return 'Fill This';
                              }
                              return null;
                            },
                            decoration: const InputDecoration(
                              contentPadding: EdgeInsets.symmetric(
                                  vertical: 0, horizontal: 15),
                              labelStyle: TextStyle(fontSize: 14),
                              labelText: 'Milk Quantity',
                              border: OutlineInputBorder(),
                            ),
                            // controller: advancePaymentController,
                          ),
                          const SizedBox(
                            height: 20,
                          ),
                          TextFormField(
                            keyboardType: TextInputType.number,
                            controller: WaFat,
                            validator: (value) {
                              if (value == null || value.isEmpty) {
                                return 'Fill This';
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
                          const SizedBox(
                            height: 20,
                          ),
                          Text("${WaResult.toStringAsFixed(2)} Liters"),
                          const SizedBox(
                            height: 20,
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Expanded(
                                child: ElevatedButton.icon(
                                  onPressed: () {
                                    WaReqFat.clear();
                                    WaMilkQty.clear();
                                    WaFat.clear();
                                    setState(() {
                                      WaResult = 0;
                                    });
                                  },
                                  icon: const Icon(
                                    FeatherIcons.refreshCcw,
                                    size: 18,
                                  ),
                                  label: const Text('Reset'),
                                  style: ElevatedButton.styleFrom(
                                    padding:
                                        const EdgeInsets.fromLTRB(0, 4, 0, 4),
                                    backgroundColor: MyColors.red,
                                    shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(5),
                                    ),
                                  ),
                                ),
                              ),
                              const SizedBox(
                                width: 20,
                              ),
                              Expanded(
                                child: ElevatedButton.icon(
                                  onPressed: () {
                                    setState(() {
                                      WaResult = (((double.parse(WaFat.text) *
                                                  double.parse(
                                                      WaMilkQty.text)) /
                                              double.parse(WaReqFat.text)) -
                                          (double.parse(WaMilkQty.text)));
                                    });
                                  },
                                  icon: const Icon(
                                    FeatherIcons.plus,
                                    size: 18,
                                  ),
                                  label: const Text('Calculate'),
                                  style: ElevatedButton.styleFrom(
                                    backgroundColor: MyColors.green,
                                    shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(5),
                                    ),
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                    Column(
                      children: [
                        TextFormField(
                          keyboardType: TextInputType.number,
                          controller: CsReqFat,
                          validator: (value) {
                            if (value == null || value.isEmpty) {
                              return 'Fill This';
                            }
                            return null;
                          },
                          decoration: const InputDecoration(
                            contentPadding: EdgeInsets.symmetric(
                                vertical: 0, horizontal: 15),
                            labelStyle: TextStyle(fontSize: 14),
                            labelText: 'Required Fat',
                            border: OutlineInputBorder(),
                          ),
                          // controller: advancePaymentController,
                        ),
                        const SizedBox(
                          height: 20,
                        ),
                        TextFormField(
                          keyboardType: TextInputType.number,
                          controller: CsMilkQty,
                          validator: (value) {
                            if (value == null || value.isEmpty) {
                              return 'Fill This';
                            }
                            return null;
                          },
                          decoration: const InputDecoration(
                            contentPadding: EdgeInsets.symmetric(
                                vertical: 0, horizontal: 15),
                            labelStyle: TextStyle(fontSize: 14),
                            labelText: 'Milk Quantity',
                            border: OutlineInputBorder(),
                          ),
                          // controller: advancePaymentController,
                        ),
                        const SizedBox(
                          height: 20,
                        ),
                        TextFormField(
                          keyboardType: TextInputType.number,
    
                          controller: CsFat,
                          validator: (value) {
                            if (value == null || value.isEmpty) {
                              return 'Fill This';
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
                        const SizedBox(
                          height: 20,
                        ),
                        Text("${CsResult.toStringAsFixed(2)} Cream"),
                        const SizedBox(
                          height: 20,
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Expanded(
                              child: ElevatedButton.icon(
                                onPressed: () {
                                  CsReqFat.clear();
                                  CsMilkQty.clear();
                                  CsFat.clear();
                                  setState(() {
                                    CsResult = 0.0;
                                  });
                                },
                                icon: const Icon(
                                  FeatherIcons.refreshCcw,
                                  size: 18,
                                ),
                                label: const Text('Reset'),
                                style: ElevatedButton.styleFrom(
                                  padding:
                                      const EdgeInsets.fromLTRB(0, 4, 0, 4),
                                  backgroundColor: MyColors.red,
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(5),
                                  ),
                                ),
                              ),
                            ),
                            const SizedBox(
                              width: 20,
                            ),
                            Expanded(
                              child: ElevatedButton.icon(
                                onPressed: () {
                                  setState(() {
                                    CsResult =
                                        ((double.parse(CsMilkQty.text) *
                                                double.parse(CsReqFat.text)) /
                                            double.parse(CsFat.text));
                                  });
                                },
                                icon: const Icon(
                                  FeatherIcons.plus,
                                  size: 18,
                                ),
                                label: const Text('Calculate'),
                                style: ElevatedButton.styleFrom(
                                  backgroundColor: MyColors.green,
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(5),
                                  ),
                                ),
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                    SingleChildScrollView(
                      child: Column(
                        children: [
                          Text(
                              "Average Fat is - ${AvResult.toStringAsFixed(2)}"),
    
                          Material(
                            elevation: 3,
                            borderRadius: BorderRadius.circular(5),
                            child: Container(
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(10),
                              ),
                              padding:
                                  const EdgeInsets.fromLTRB(10, 2, 10, 2),
                              child: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  const Text('Enter Sample Data'),
                                  ElevatedButton(
                                    onPressed: () {
                                      VxBottomSheet.bottomSheetView(
                                        context,
                                        elevation: 20,
                                        isDismissible: true,
                                        backgroundColor: Colors.white,
                                        isSafeAreaFromBottom: true,
                                        child: SizedBox(
                                          height: MediaQuery.of(context)
                                              .size
                                              .height,
                                          child: Column(
                                            children: <Widget>[
                                              Material(
                                                elevation: 2,
                                                child: Align(
                                                  alignment:
                                                      Alignment.centerRight,
                                                  child: IconButton(
                                                    onPressed: () {
                                                      Navigator.pop(context);
                                                    },
                                                    icon: const Icon(
                                                      FeatherIcons.x,
                                                      color: MyColors
                                                          .defaultColor,
                                                    ),
                                                  ),
                                                ),
                                              ),
                                              const SizedBox(
                                                height: 5,
                                              ),
                                              Padding(
                                                padding:
                                                    const EdgeInsets.fromLTRB(
                                                        20, 15, 20, 0),
                                                child: Column(
                                                  children: [
                                                    const SizedBox(
                                                      height: 20,
                                                    ),
    
                                                    Text(
                                                      "Enter ${(FatList.length + 1)} Sample Details",
                                                      style: TextStyle(
                                                          fontSize: 20,
                                                          fontWeight:
                                                              FontWeight
                                                                  .bold),
                                                      textAlign:
                                                          TextAlign.start,
                                                    ),
                                                    const SizedBox(
                                                      height: 20,
                                                    ),
                                                    Row(
                                                      mainAxisAlignment:
                                                          MainAxisAlignment
                                                              .spaceBetween,
                                                      children: [
                                                        Expanded(
                                                          child:
                                                              TextFormField(
                                                            keyboardType:
                                                                TextInputType
                                                                    .number,
                                                            decoration:
                                                                const InputDecoration(
                                                              contentPadding:
                                                                  EdgeInsets.symmetric(
                                                                      vertical:
                                                                          0,
                                                                      horizontal:
                                                                          15),
                                                              labelStyle:
                                                                  TextStyle(
                                                                      fontSize:
                                                                          14),
                                                              labelText:
                                                                  'Quantity',
                                                              border:
                                                                  OutlineInputBorder(),
                                                            ),
                                                            controller:
                                                                bQuantityController,
                                                          ),
                                                        ),
                                                        const SizedBox(
                                                          width: 8,
                                                        ),
                                                        Expanded(
                                                          child:
                                                              TextFormField(
                                                            keyboardType:
                                                                TextInputType
                                                                    .number,
                                                            decoration:
                                                                const InputDecoration(
                                                              contentPadding:
                                                                  EdgeInsets.symmetric(
                                                                      vertical:
                                                                          0,
                                                                      horizontal:
                                                                          15),
                                                              labelStyle:
                                                                  TextStyle(
                                                                      fontSize:
                                                                          14),
                                                              labelText:
                                                                  'Fat',
                                                              border:
                                                                  OutlineInputBorder(),
                                                            ),
                                                            controller:
                                                                bFatController,
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
                                                          MainAxisAlignment
                                                              .spaceBetween,
                                                      children: [
                                                        Expanded(
                                                          child: SizedBox(
                                                            height:
                                                                size.height *
                                                                    0.06,
                                                            width:
                                                                size.width *
                                                                    0.4,
                                                            child:
                                                                ElevatedButton
                                                                    .icon(
                                                              onPressed: () {
                                                                bQuantityController
                                                                    .clear();
                                                                bFatController
                                                                    .clear();
                                                                Navigator.pop(
                                                                    context);
                                                              },
                                                              icon:
                                                                  const Icon(
                                                                FeatherIcons
                                                                    .trash2,
                                                                size: 18,
                                                              ),
                                                              label: const Text(
                                                                  'Delete'),
                                                              style: ElevatedButton
                                                                  .styleFrom(
                                                                padding:
                                                                    const EdgeInsets
                                                                            .fromLTRB(
                                                                        0,
                                                                        4,
                                                                        0,
                                                                        4),
                                                                backgroundColor:
                                                                    MyColors
                                                                        .red,
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
                                                            height:
                                                                size.height *
                                                                    0.06,
                                                            width:
                                                                size.width *
                                                                    0.4,
                                                            child:
                                                                ElevatedButton
                                                                    .icon(
                                                              onPressed: () {
                                                                QuantityList.add(
                                                                    double.parse(
                                                                        bQuantityController
                                                                            .text));
    
                                                                FatList.add(double.parse(
                                                                    bFatController
                                                                        .text));
    
                                                                bQuantityController
                                                                    .clear();
                                                                bFatController
                                                                    .clear();
    
                                                                double
                                                                    numerator =
                                                                    0;
                                                                for (var i =
                                                                        0;
                                                                    i <
                                                                        QuantityList
                                                                            .length;
                                                                    i++) {
                                                                  numerator += QuantityList[
                                                                          i] *
                                                                      FatList[
                                                                          i];
                                                                }
    
                                                                double den =
                                                                    QuantityList.reduce(
                                                                        (a, b) =>
                                                                            a +
                                                                            b);
    
                                                                setState(() {
                                                                  AvResult =
                                                                      numerator /
                                                                          den;
    
                                                                  print(
                                                                      "AV RESULT IS HERE");
                                                                  print(
                                                                      AvResult);
                                                                  print(
                                                                      QuantityList);
                                                                  print(
                                                                      FatList);
                                                                });
    
                                                                Navigator.pop(
                                                                    context);
                                                              },
                                                              icon:
                                                                  const Icon(
                                                                FeatherIcons
                                                                    .plus,
                                                                size: 18,
                                                              ),
                                                              label: const Text(
                                                                  'Calculate'),
                                                              style: ElevatedButton
                                                                  .styleFrom(
                                                                backgroundColor:
                                                                    MyColors
                                                                        .green,
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
                                          borderRadius:
                                              BorderRadius.circular(5)),
                                    ),
                                    child: const Text('   Add +   '),
                                  ),
                                ],
                              ),
                            ),
                          ),
    
                          const SizedBox(
                            height: 20,
                          ),
    
                          ElevatedButton(
                            onPressed: () {
                              QuantityList.clear();
                              FatList.clear();
    
                              setState(() {
                                AvResult = 0.0;
                              });
                            },
                            style: ElevatedButton.styleFrom(
                              backgroundColor: MyColors.red,
                              shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(5)),
                            ),
                            child: const Text('  Reset Results '),
                          ),
                          const SizedBox(
                            height: 20,
                          ),
                          // row with text feild end
                        ],
                      ),
                    )
                  ],
                ),
              ),
            )
            )
            );
  }
}
