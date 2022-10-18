import 'package:flutter/material.dart';
import 'package:flutter_feather_icons/flutter_feather_icons.dart';

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

  TextEditingController AvQty1 = TextEditingController();
  TextEditingController AvQty2 = TextEditingController();
  TextEditingController AvQty3 = TextEditingController();
  TextEditingController AvQty4 = TextEditingController();
  TextEditingController AvFat1 = TextEditingController();
  TextEditingController AvFat2 = TextEditingController();
  TextEditingController AvFat3 = TextEditingController();
  TextEditingController AvFat4 = TextEditingController();

  double WaResult = 0.0;
  double CsResult = 0.0;
  double AvResult = 0.0;

  @override
  Widget build(BuildContext context) {
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
                                    CsResult = ((double.parse(CsMilkQty.text) *
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
                          // row with text feild
                          const Align(
                              alignment: Alignment.centerLeft,
                              child: Text('First Sample')),
                          const SizedBox(
                            height: 10,
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Expanded(
                                child: TextFormField(
                                  keyboardType: TextInputType.number,
                                  controller: AvQty1,
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
                                    labelText: 'Quantity',
                                    border: OutlineInputBorder(),
                                  ),
                                  // controller: advancePaymentController,
                                ),
                              ),
                              const SizedBox(
                                width: 20,
                              ),
                              Expanded(
                                child: TextFormField(
                                  keyboardType: TextInputType.number,
                                  controller: AvFat1,
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
                              ),
                            ],
                          ),
                          const SizedBox(
                            height: 20,
                          ),
                          // row with text feild end
                          // row with text feild
                          const Align(
                              alignment: Alignment.centerLeft,
                              child: Text('Second Sample')),
                          const SizedBox(
                            height: 10,
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Expanded(
                                child: TextFormField(
                                  keyboardType: TextInputType.number,
                                  controller: AvQty2,
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
                                    labelText: 'Quantity',
                                    border: OutlineInputBorder(),
                                  ),
                                  // controller: advancePaymentController,
                                ),
                              ),
                              const SizedBox(
                                width: 20,
                              ),
                              Expanded(
                                child: TextFormField(
                                  keyboardType: TextInputType.number,
                                  controller: AvFat2,
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
                              ),
                            ],
                          ),
                          const SizedBox(
                            height: 20,
                          ),
                          // row with text feild end
                          // row with text feild
                          const Align(
                              alignment: Alignment.centerLeft,
                              child: Text('Third Sample')),
                          const SizedBox(
                            height: 10,
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Expanded(
                                child: TextFormField(
                                  keyboardType: TextInputType.number,
                                  controller: AvQty3,
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
                                    labelText: 'Quantity',
                                    border: OutlineInputBorder(),
                                  ),
                                  // controller: advancePaymentController,
                                ),
                              ),
                              const SizedBox(
                                width: 20,
                              ),
                              Expanded(
                                child: TextFormField(
                                  keyboardType: TextInputType.number,
                                  controller: AvFat3,
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
                              ),
                            ],
                          ),
                          const SizedBox(
                            height: 20,
                          ),
                          // row with text feild end
                          // row with text feild
                          const Align(
                              alignment: Alignment.centerLeft,
                              child: Text('Fourth Sample')),
                          const SizedBox(
                            height: 10,
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Expanded(
                                child: TextFormField(
                                  keyboardType: TextInputType.number,
                                  controller: AvQty4,
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
                                    labelText: 'Quantity',
                                    border: OutlineInputBorder(),
                                  ),
                                  // controller: advancePaymentController,
                                ),
                              ),
                              const SizedBox(
                                width: 20,
                              ),
                              Expanded(
                                child: TextFormField(
                                  keyboardType: TextInputType.number,
                                  controller: AvFat4,
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
                              ),
                            ],
                          ),
                          const SizedBox(
                            height: 20,
                          ),

                          Text(
                              "Average Fat is : ${AvResult.toStringAsFixed(2)}"),
                          const SizedBox(
                            height: 20,
                          ),
                          // row with text feild end
                          // row with button
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Expanded(
                                child: ElevatedButton.icon(
                                  onPressed: () {
                                    AvQty1.clear();
                                    AvQty2.clear();
                                    AvQty3.clear();
                                    AvQty4.clear();
                                    AvFat1.clear();
                                    AvFat2.clear();
                                    AvFat3.clear();
                                    AvFat4.clear();
                                    setState(() {
                                      AvResult = 0.0;
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
                                    if (AvFat1.text.isEmpty) {
                                      AvFat1.text = "0";
                                    }

                                    if (AvFat2.text.isEmpty) {
                                      AvFat2.text = "0";
                                    }
                                    if (AvFat3.text.isEmpty) {
                                      AvFat3.text = "0";
                                    }

                                    if (AvFat4.text.isEmpty) {
                                      AvFat4.text = "0";
                                    }

                                    if (AvQty1.text.isEmpty) {
                                      AvQty1.text = "0";
                                    }

                                    if (AvQty2.text.isEmpty) {
                                      AvQty2.text = "0";
                                    }

                                    if (AvQty3.text.isEmpty) {
                                      AvQty3.text = "0";
                                    }

                                    if (AvQty4.text.isEmpty) {
                                      AvQty4.text = "0";
                                    }

                                    setState(() {
                                      AvResult = ((double.parse(AvFat1.text) *
                                          double.parse(AvQty1.text)) +
                                          (double.parse(AvFat2.text) *
                                              double.parse(AvQty2.text)) +
                                          (double.parse(AvFat3.text) *
                                              double.parse(AvQty3.text)) +
                                          (double.parse(AvFat4.text) *
                                              double.parse(AvQty4.text))) /
                                          (double.parse(AvQty1.text) +
                                              double.parse(AvQty2.text) +
                                              double.parse(AvQty3.text) +
                                              double.parse(AvQty4.text));
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
                    )
                  ],
                ),
              ),
            )));
  }
}