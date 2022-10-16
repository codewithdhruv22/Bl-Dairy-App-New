import 'package:bl_dairy_app/controller/milkSupplierController.dart';
import 'package:bl_dairy_app/model/ledgerModel.dart';
import 'package:flutter/material.dart';
import 'package:flutter_feather_icons/flutter_feather_icons.dart';

import '../../constants/Theme.dart';

class UtilitiesScreen extends StatefulWidget {
  const UtilitiesScreen({Key? key}) : super(key: key);

  @override
  State<UtilitiesScreen> createState() => _UtilitiesScreenState();
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

class _UtilitiesScreenState extends State<UtilitiesScreen> {
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
    return SafeArea(
        child: DefaultTabController(
            length: 3,
            child: Scaffold(
              appBar: AppBar(
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
                    icon: Icon(FeatherIcons.airplay),
                  ),
                ]),
              ),
              body: TabBarView(
                children: [
                  Padding(
                    padding: const EdgeInsets.all(10.0),
                    child: Column(
                      children: [
                        TextFormField(
                          controller: null,
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
                          controller: null,
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
                          controller: null,
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
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Expanded(
                              child: ElevatedButton.icon(
                                onPressed: () {
                                  // Navigator.pop(context);
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
                                onPressed: () {},
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
                  Padding(
                    padding: const EdgeInsets.all(10.0),
                    child: Column(
                      children: [
                        TextFormField(
                          controller: null,
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
                          controller: null,
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
                          controller: null,
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
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Expanded(
                              child: ElevatedButton.icon(
                                onPressed: () {
                                  // Navigator.pop(context);
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
                                onPressed: () {},
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
                  Padding(
                    padding: const EdgeInsets.fromLTRB(10, 30, 10, 0),
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
                                controller: null,
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
                                controller: null,
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
                                controller: null,
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
                                controller: null,
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
                                controller: null,
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
                                controller: null,
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
                                controller: null,
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
                                controller: null,
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
                        // row with button
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Expanded(
                              child: ElevatedButton.icon(
                                onPressed: () {
                                  // Navigator.pop(context);
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
                                onPressed: () {},
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
                ],
              ),
            )));
  }
}
