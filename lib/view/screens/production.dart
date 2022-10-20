import 'package:bl_dairy_app/controller/productionController.dart';
import 'package:bl_dairy_app/model/productionModel.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_feather_icons/flutter_feather_icons.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:intl/intl.dart';
import 'package:textfield_search/textfield_search.dart';
import 'package:velocity_x/velocity_x.dart';

import '../../constants/Theme.dart';

class ProductionScreen extends ConsumerStatefulWidget {
  const ProductionScreen({Key? key}) : super(key: key);

  @override
  ConsumerState<ProductionScreen> createState() => _ProductionScreenState();
}

class _ProductionScreenState extends ConsumerState<ProductionScreen> {
  TextEditingController PrdNameController = TextEditingController();

  TextEditingController PrdQuantityController = TextEditingController();

  TextEditingController RmController = TextEditingController();

  TextEditingController RmQtyController = TextEditingController();

  TextEditingController RmRateController = TextEditingController();

  TextEditingController RmAmntController = TextEditingController();

  List<RawMaterialModel> rawMaterialNeeded = [];
  final searchList = [];
  final RmsearchList = [];
  double grandTotal = 0;

  DateTime TodayDate = DateTime.now();

  var myFormat = DateFormat('d-MM-yyyy');
  final _dateProvider = StateProvider<DateTime>((ref) {
    return DateTime.now();
  });
  void _selectDate(WidgetRef ref) async {
    final DateTime? newDate = await showDatePicker(
      context: context,
      initialDate: ref.watch(_dateProvider),
      firstDate: DateTime.now(),
      lastDate: DateTime(2101),
      helpText: 'Select a date',
    );
    if (newDate != null) {
      ref.read(_dateProvider.notifier).state = newDate;
    }
  }

  @override
  void initState() {
    PrdNameController.addListener(() async {
      final String value = PrdNameController.value.text;
      searchList.clear();
      searchList.addAll(await ProductionController.fetchFinishGoodsName(value));
      searchList.toSet().toList();

      setState(() {

        print(searchList);
      });
      // YOUR CODE
    });




    RmController.addListener(() async {
      String FetchedRmRate  = "0";
      final String value = RmController.value.text;
      RmsearchList.clear();
      RmsearchList.addAll(await ProductionController.fetchRmName(value));
      RmsearchList.toSet().toList();
      FetchedRmRate  = await ProductionController.fetchRmPrice(value);
      setState(() {
        RmRateController.text = FetchedRmRate;
        print(searchList);
      });
      // YOUR CODE
    });

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final date = ref.watch(_dateProvider);
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
                Row(
                  children: [
                    Flexible(
                      child: TextFieldSearch(
                        initialList: searchList,
                        itemsInView: 10,
                        label: 'Product Name',
                        controller: PrdNameController,
                        decoration: const InputDecoration(
                          labelText: 'Product Name',
                          border: OutlineInputBorder(),
                        ),
                      ),
                    ),
                    const SizedBox(
                      width: 12,
                    ),
                    InkWell(
                      onTap: () => _selectDate(ref),
                      child: SizedBox(
                        width: MediaQuery.of(context).size.width * 0.4,
                        child: Container(
                          height: 60,
                          decoration: BoxDecoration(
                            border: Border.all(
                              color: MyColors.defaultColor,
                            ),
                            borderRadius: BorderRadius.circular(4),
                          ),
                          child: Center(
                            child: Text(
                              "${date.day}-${date.month}-${date.year}",
                              style: const TextStyle(
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
                  height: 20,
                ),
                TextField(

                  keyboardType: TextInputType.number,
                  controller: PrdQuantityController,
                  decoration: const InputDecoration(
                    contentPadding:
                    EdgeInsets.symmetric(vertical: 0, horizontal: 15),
                    labelStyle: TextStyle(fontSize: 14),
                    labelText: 'Quantity',
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
                        const Text('Add Raw Material'),
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
                                          TextFieldSearch(
                                            initialList: RmsearchList,
                                            itemsInView: 10,
                                            label: 'Raw Material Name',
                                            controller: RmController,
                                            decoration: const InputDecoration(
                                              labelText: "Raw Material Name",
                                              border: OutlineInputBorder(),
                                            ),
                                          ),
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
                                                          .text = (double.parse(
                                                          RmQtyController
                                                              .text) *
                                                          double.parse(
                                                              RmRateController
                                                                  .text))
                                                          .toStringAsFixed(2);
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
                                                          .text = (double.parse(
                                                          RmQtyController
                                                              .text) *
                                                          double.parse(
                                                              RmRateController
                                                                  .text))
                                                          .toStringAsFixed(2);
                                                    });
                                                  },
                                                  keyboardType: TextInputType.number,
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
                                                  keyboardType: TextInputType.number,
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
                                                      RmAmntController.clear();
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
                                                      grandTotal += double.parse(
                                                          RmQtyController
                                                              .text) *
                                                          double.parse(
                                                              RmRateController
                                                                  .text);
                                                      rawMaterialNeeded.add(
                                                          RawMaterialModel(
                                                              Rm: RmController
                                                                  .text,
                                                              RmQty: double.parse(
                                                                  RmQtyController
                                                                      .text),
                                                              RmRate: double.parse(
                                                                  RmRateController
                                                                      .text)));

                                                      RmController.clear();
                                                      RmRateController.clear();
                                                      RmQtyController.clear();
                                                      RmAmntController.clear();
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
                      Text(grandTotal.toStringAsFixed(2)),
                    ],
                  ),
                ),
                ElevatedButton(
                    onPressed: () {
                      const snackBar = SnackBar(
                        content: Text('Product Added to production'),
                      );
                      ScaffoldMessenger.of(context).showSnackBar(snackBar);

                      ProductionController.addProduction(Production(
                          FinishGoods: PrdNameController.text,
                          FinishGoodsQty: int.parse(PrdQuantityController.text),
                          ProductionDate: Timestamp.fromDate(date),
                          rawMaterialList: rawMaterialNeeded));

                      PrdNameController.clear();
                      PrdQuantityController.clear();
                      rawMaterialNeeded.clear();
                      RmAmntController.clear();
                      RmController.clear();
                      RmRateController.clear();
                      RmQtyController.clear();
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