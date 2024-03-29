import 'package:bl_dairy_app/controller/book_order.dart';
import 'package:bl_dairy_app/controller/milkPurchaseController.dart';
import 'package:bl_dairy_app/controller/paymentController.dart';
import 'package:bl_dairy_app/controller/productionController.dart';
import 'package:bl_dairy_app/model/ledgerModel.dart';
import 'package:bl_dairy_app/model/paymentModel.dart';
import 'package:bl_dairy_app/model/productionModel.dart';
import 'package:bl_dairy_app/view/widgets/main_chart.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_feather_icons/flutter_feather_icons.dart';
import 'package:intl/intl.dart';
import 'package:velocity_x/velocity_x.dart';
import '../../constants/Theme.dart';
import '../../model/BookOrderModel.dart';
import '../../model/milkPurchaseModel.dart';
import '../widgets/Custom_TextFiled.dart';
import '../widgets/SlideShower.dart';
import 'detail_report.dart';
import 'home.dart';
import 'package:get/get.dart';

import 'milkPurchase.dart';

class Dashboard_Scren extends StatefulWidget {
  const Dashboard_Scren({Key? key}) : super(key: key);

  @override
  State<Dashboard_Scren> createState() => _Dashboard_ScrenState();
}

class _Dashboard_ScrenState extends State<Dashboard_Scren> {
  late List<Order> dashOrderList;
  late List<Production> dashPrdList;
  late List<PaymentModel> paymentList;
  //*************************************************************
  List<MilkPurchaseModel> RecentPurchaseList = [];
  List<Widget> RecentPurchaseListTiles = [];
  //*************************************************************
  double today_milkPrch_liter = 0;
  double cowMilk = 0;
  double buffaloMilk = 0;
  bool loading = true;
  double TotalQty = 0;
  double TotalAmount = 0;

  GetOrders() async {
    await BookOrderController.fetchOrder().then((allOrders) {
      setState(() {
        dashOrderList = allOrders!;
        loading = false;
      });

      print("DASHBOARD ORDER LIST");
      print(dashOrderList);
      print("RETURNED LIST");
      print(allOrders);
    });
  }

  ProductionPrinter() async {
    await ProductionController.fetchProduction().then((production) {
      setState(() {
        dashPrdList = production;
      });
    });
  }

  GetMilkPurchaseByDate() async {
    await MilkPurchaseController.allMilkPurchaseByDate(Timestamp.now())
        .then((resultList) {
      int i = 0;
      setState(() {
        RecentPurchaseList = resultList;
        GetTodayMilkPurchaseLiter();
        for (var element in RecentPurchaseList) {
          RecentPurchaseListTiles.add(ListTile(
            title: Text(element.SupplierName),
            trailing: Text(element.milkQty.toStringAsFixed(2)),
          ));
          i += 1;
          if (i == 3) {
            break;
          }
        }
      });
    });
  }

  GetTodayMilkPurchaseLiter() {
    for (var milkPurchaseEntry in RecentPurchaseList) {
      today_milkPrch_liter += milkPurchaseEntry.milkQty;
      if (milkPurchaseEntry.milkType == "Cow") {
        cowMilk += milkPurchaseEntry.milkQty;
      } else {
        buffaloMilk += milkPurchaseEntry.milkQty;
      }
    }

    setState(() {});
  }

  GetPaymentDet() async {
    await PaymentController.fetchAllPayments().then((allPayment) {
      setState(() {
        paymentList = allPayment;
      });
    });
  }

  bool ProductionStatus = false;
  bool DeliveryStatus = false;

  @override
  void initState() {
    super.initState();
    GetOrders();
    ProductionPrinter();
    GetMilkPurchaseByDate();
    GetPaymentDet();

   
  }

  bool _customTileExpanded = false;
  var myFormat = DateFormat('d-MM-yyyy');
  @override
  Widget build(BuildContext context) {
    final Size size = MediaQuery.of(context).size;
    return loading
        ? const Scaffold(
            body: Center(
              child: CircularProgressIndicator(),
            ),
          )
        : RefreshIndicator(
            onRefresh: () async {
              Navigator.pushReplacement(context,
                  MaterialPageRoute(builder: (context) => const Home()));
            },
            child: Scaffold(
              backgroundColor: const Color(0xB3DDDCDC),
              body: SafeArea(
                child: SingleChildScrollView(
                  child: Container(
                    margin: const EdgeInsets.symmetric(horizontal: 10),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const SizedBox(
                          height: 10,
                        ),
                        // container for Dashboard Title

                        const SizedBox(
                          height: 15,
                        ),
                        // container for Peinding order
                        Container(
                          child: Material(
                            elevation: 4,
                            borderRadius:
                                const BorderRadius.all(Radius.circular(12)),
                            child: Container(
                              decoration: const BoxDecoration(
                                  borderRadius:
                                      BorderRadius.all(Radius.circular(12))),
                              margin: const EdgeInsets.symmetric(
                                  horizontal: 12, vertical: 20),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  ExpansionTile(
                                    tilePadding:
                                        const EdgeInsets.fromLTRB(2, 0, 2, 0),
                                    title: const Text('Pending Orders'),
                                    // trailing: Icon(
                                    //   _customTileExpanded
                                    //       ? FeatherIcons.chevronUp
                                    //       : FeatherIcons.chevronDown,
                                    // ),
                                    children: [
                                      SizedBox(
                                        height: 300,
                                        child: ListView.builder(
                                            shrinkWrap: true,
                                            itemCount: dashOrderList.length,
                                            itemBuilder: (context, index) {
                                              final order =
                                                  dashOrderList[index];

                                              return (order.ProductionDone &&
                                                      order.Delivered)
                                                  ? Container()
                                                  : ListTile(
                                                      onTap: () {
                                                        setState(() {
                                                          ProductionStatus = order
                                                              .ProductionDone;
                                                          DeliveryStatus =
                                                              order.Delivered;
                                                        });
                                                        VxBottomSheet
                                                            .bottomSheetView(
                                                          context,
                                                          isDismissible: true,
                                                          backgroundColor:
                                                              Colors.white,
                                                          isSafeAreaFromBottom:
                                                              true,
                                                          child: Column(
                                                            children: <Widget>[
                                                              SingleChildScrollView(
                                                                child: Column(
                                                                  children: <
                                                                      Widget>[
                                                                    Material(
                                                                      elevation:
                                                                          2,
                                                                      child:
                                                                          Align(
                                                                        alignment:
                                                                            Alignment.centerRight,
                                                                        child:
                                                                            IconButton(
                                                                          onPressed:
                                                                              () {
                                                                            Navigator.pop(context);
                                                                          },
                                                                          icon:
                                                                              const Icon(
                                                                            FeatherIcons.x,
                                                                            color:
                                                                                MyColors.defaultColor,
                                                                          ),
                                                                        ),
                                                                      ),
                                                                    ),
                                                                    const SizedBox(
                                                                      height: 5,
                                                                    ),
                                                                    Container(
                                                                      padding: const EdgeInsets
                                                                              .fromLTRB(
                                                                          10,
                                                                          0,
                                                                          10,
                                                                          15),
                                                                      child:
                                                                          Column(
                                                                        children: [
                                                                          const SizedBox(
                                                                            height:
                                                                                10,
                                                                          ),
                                                                          Row(
                                                                            mainAxisAlignment:
                                                                                MainAxisAlignment.start,
                                                                            children: [
                                                                              borderContainer(
                                                                                height: size.height / 17,
                                                                                width: size.width * 0.4,
                                                                                child: CustomTextFiled(
                                                                                  label: "Customer Name",
                                                                                  value: order.CustomerName,
                                                                                ),
                                                                              ),
                                                                              const SizedBox(
                                                                                width: 10,
                                                                              ),
                                                                              borderContainer(
                                                                                height: size.height / 17,
                                                                                width: size.width * 0.5,
                                                                                child: CustomTextFiled(label: 'Number', value: order.MobileNumber),
                                                                              ),
                                                                            ],
                                                                          ),
                                                                          const SizedBox(
                                                                            height:
                                                                                10,
                                                                          ),
                                                                          Row(
                                                                            mainAxisAlignment:
                                                                                MainAxisAlignment.spaceBetween,
                                                                            children: [
                                                                              borderContainer(
                                                                                height: size.height / 17,
                                                                                width: size.width * 0.33,
                                                                                child: Center(
                                                                                  child: CustomTextFiled(label: "Order Date", value: myFormat.format(order.OrderBookDate.toDate())),
                                                                                ),
                                                                              ),
                                                                              const Expanded(
                                                                                  child: SizedBox(
                                                                                width: 10,
                                                                              )),
                                                                              borderContainer(
                                                                                height: size.height / 17,
                                                                                width: size.width * 0.3,
                                                                                child: Center(
                                                                                  child: CustomTextFiled(label: 'Delivery Date', value: myFormat.format(order.OrderDelivaryDate.toDate())),
                                                                                ),
                                                                              ),
                                                                              const Expanded(
                                                                                  child: SizedBox(
                                                                                width: 10,
                                                                              )),
                                                                              borderContainer(
                                                                                height: size.height / 17,
                                                                                width: size.width * 0.3,
                                                                                child: Center(
                                                                                  child: CustomTextFiled(
                                                                                    label: 'Advance Payment',
                                                                                    value: order.Advance,
                                                                                  ),
                                                                                ),
                                                                              ),
                                                                            ],
                                                                          ),
                                                                          const SizedBox(
                                                                            height:
                                                                                10,
                                                                          ),
                                                                          Row(
                                                                            mainAxisAlignment:
                                                                                MainAxisAlignment.start,
                                                                            children: [
                                                                              borderContainer(
                                                                                height: size.height / 17,
                                                                                width: size.width * 0.90,
                                                                                child: Padding(
                                                                                  padding: const EdgeInsets.symmetric(
                                                                                    horizontal: 1,
                                                                                    vertical: 2,
                                                                                  ),
                                                                                  child: CustomTextFiled(label: "Notes", value: order.Note),
                                                                                ),
                                                                              ),
                                                                            ],
                                                                          ),
                                                                          const Divider(
                                                                            thickness:
                                                                                3,
                                                                          ),
                                                                          Row(
                                                                            mainAxisAlignment:
                                                                                MainAxisAlignment.spaceBetween,
                                                                            children: [
                                                                              SizedBox(
                                                                                width: size.width * 0.4,
                                                                                child: const Text(
                                                                                  'Order',
                                                                                  style: TextStyle(fontWeight: FontWeight.bold),
                                                                                ),
                                                                              ),
                                                                              SizedBox(
                                                                                width: size.width * 0.2,
                                                                                child: const Text('Qty', style: TextStyle(fontWeight: FontWeight.bold)),
                                                                              ),
                                                                              SizedBox(
                                                                                width: size.width * 0.15,
                                                                                child: const Text('Rate', style: TextStyle(fontWeight: FontWeight.bold)),
                                                                              ),
                                                                              const Text('Amount', style: TextStyle(fontWeight: FontWeight.bold)),
                                                                            ],
                                                                          ),
                                                                          SizedBox(
                                                                            height:
                                                                                200,
                                                                            child:
                                                                                ListView.builder(
                                                                              shrinkWrap: true,
                                                                              itemCount: order.items.length,
                                                                              itemBuilder: (context, index) {
                                                                                final item = order.items[index];
                                                                                return Row(
                                                                                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                                                                  children: [
                                                                                    SizedBox(width: size.width * 0.4, child: Text(item.itemName.toString())),
                                                                                    SizedBox(width: size.width * 0.2, child: Text(item.itemQty.toString())),
                                                                                    SizedBox(width: size.width * 0.15, child: Text(item.itemRate.toString())),
                                                                                    Text(item.itemAmnt.toString())
                                                                                  ],
                                                                                );
                                                                              },
                                                                            ),
                                                                          ),
                                                                          const SizedBox(
                                                                            height:
                                                                                10,
                                                                          ),
                                                                          Row(
                                                                            mainAxisAlignment:
                                                                                MainAxisAlignment.spaceBetween,
                                                                            children: [
                                                                              Expanded(
                                                                                  child: ElevatedButton(
                                                                                child: Text("Production"),
                                                                                onPressed: () {
                                                                                  setState(() {
                                                                                    ProductionStatus = !ProductionStatus;
                                                                                  });
                                                                                  Get.snackbar("Production Status Change", 'STATUS : ${ProductionStatus ? "DONE" : "NOT DONE"}', snackPosition: SnackPosition.BOTTOM);

                                                                                  BookOrderController.ChangeProductionStatus(order.id, ProductionStatus);
                                                                                },
                                                                              )),
                                                                              SizedBox(
                                                                                width: 10,
                                                                              ),
                                                                              Expanded(
                                                                                  child: ElevatedButton(
                                                                                child: Text("Delivery"),
                                                                                onPressed: () {
                                                                                  setState(() {
                                                                                    DeliveryStatus = !DeliveryStatus;
                                                                                  });
                                                                                  Get.snackbar("Delivery Status Change", 'STATUS : ${DeliveryStatus ? "DONE" : "NOT DONE"}', snackPosition: SnackPosition.BOTTOM);

                                                                                  BookOrderController.ChangeDeliveryStatus(order.id, DeliveryStatus);
                                                                                },
                                                                              )),
                                                                            ],
                                                                          ),
                                                                        ],
                                                                      ),
                                                                    )
                                                                  ],
                                                                ),
                                                              ),
                                                            ],
                                                          ),
                                                        );
                                                      },
                                                      title: Text(
                                                          order.CustomerName),
                                                      leading: const Text("->"),
                                                      trailing: Text(
                                                          myFormat.format(order
                                                                  .OrderDelivaryDate
                                                              .toDate())),
                                                    );
                                            }),
                                      ),
                                    ],
                                    onExpansionChanged: (bool expanded) {
                                      setState(
                                          () => _customTileExpanded = expanded);
                                    },
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ),
                        const SizedBox(
                          height: 20,
                        ),
                        Container(
                          child: Material(
                            elevation: 4,
                            borderRadius:
                                const BorderRadius.all(Radius.circular(12)),
                            child: Container(
                              decoration: const BoxDecoration(
                                  borderRadius:
                                      BorderRadius.all(Radius.circular(12))),
                              margin: const EdgeInsets.symmetric(
                                  horizontal: 12, vertical: 20),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  ExpansionTile(
                                    tilePadding:
                                        const EdgeInsets.fromLTRB(2, 0, 2, 0),
                                    title: const Text('Production'),
                                    children: [
                                      SizedBox(
                                          height: 300,
                                          child: ListView.builder(
                                              itemCount: dashPrdList.length,
                                              itemBuilder: (context, index) {
                                                final PrdItem =
                                                    dashPrdList[index];
                                                return ListTile(
                                                  onTap: () {
                                                    VxBottomSheet
                                                        .bottomSheetView(
                                                      context,
                                                      isDismissible: true,
                                                      backgroundColor:
                                                          Colors.white,
                                                      isSafeAreaFromBottom:
                                                          true,
                                                      child: Column(
                                                        children: <Widget>[
                                                          SingleChildScrollView(
                                                            child: Column(
                                                              children: <
                                                                  Widget>[
                                                                Material(
                                                                  elevation: 2,
                                                                  child: Align(
                                                                    alignment:
                                                                        Alignment
                                                                            .centerRight,
                                                                    child:
                                                                        IconButton(
                                                                      onPressed:
                                                                          () {
                                                                        Navigator.pop(
                                                                            context);
                                                                      },
                                                                      icon:
                                                                          const Icon(
                                                                        FeatherIcons
                                                                            .x,
                                                                        color: MyColors
                                                                            .defaultColor,
                                                                      ),
                                                                    ),
                                                                  ),
                                                                ),
                                                                const SizedBox(
                                                                  height: 5,
                                                                ),
                                                                Container(
                                                                  padding:
                                                                      const EdgeInsets
                                                                              .fromLTRB(
                                                                          10,
                                                                          0,
                                                                          10,
                                                                          0),
                                                                  child: Column(
                                                                    children: [
                                                                      const SizedBox(
                                                                        height:
                                                                            10,
                                                                      ),
                                                                      Row(
                                                                        mainAxisAlignment:
                                                                            MainAxisAlignment.start,
                                                                        children: [
                                                                          borderContainer(
                                                                            height:
                                                                                size.height / 17,
                                                                            width:
                                                                                size.width * 0.4,
                                                                            child:
                                                                                CustomTextFiled(
                                                                              label: 'Product Name',
                                                                              value: PrdItem.FinishGoods,
                                                                            ),
                                                                          ),
                                                                          const SizedBox(
                                                                            width:
                                                                                10,
                                                                          ),
                                                                          borderContainer(
                                                                            height:
                                                                                size.height / 17,
                                                                            width:
                                                                                size.width * 0.5,
                                                                            child:
                                                                                CustomTextFiled(label: 'Quantity', value: PrdItem.FinishGoodsQty.toString()),
                                                                          ),
                                                                        ],
                                                                      ),
                                                                      const SizedBox(
                                                                        height:
                                                                            10,
                                                                      ),
                                                                      Row(
                                                                        mainAxisAlignment:
                                                                            MainAxisAlignment.start,
                                                                        children: [
                                                                          borderContainer(
                                                                            height:
                                                                                size.height / 17,
                                                                            width:
                                                                                size.width * 0.92,
                                                                            child:
                                                                                CustomTextFiled(
                                                                              label: "Date",
                                                                              value: myFormat.format(PrdItem.ProductionDate.toDate()),
                                                                            ),
                                                                          ),
                                                                          const SizedBox(
                                                                            width:
                                                                                10,
                                                                          ),
                                                                        ],
                                                                      ),
                                                                      const Divider(),
                                                                      Text(
                                                                          "Cost Per KG  - ${PrdItem.costPerKG.toStringAsFixed(2)}"),
                                                                      Row(
                                                                        mainAxisAlignment:
                                                                            MainAxisAlignment.spaceBetween,
                                                                        children: [
                                                                          SizedBox(
                                                                            width:
                                                                                size.width * 0.55,
                                                                            child:
                                                                                const Text(
                                                                              'Raw Material Name',
                                                                              style: TextStyle(fontSize: 15, fontWeight: FontWeight.bold),
                                                                            ),
                                                                          ),
                                                                          SizedBox(
                                                                            width:
                                                                                size.width * 0.2,
                                                                            child:
                                                                                const Text(
                                                                              'Qty',
                                                                              style: TextStyle(fontSize: 15, fontWeight: FontWeight.bold),
                                                                            ),
                                                                          ),
                                                                          const Text(
                                                                            'Rate',
                                                                            style:
                                                                                TextStyle(fontSize: 15, fontWeight: FontWeight.bold),
                                                                          ),
                                                                        ],
                                                                      ),
                                                                      SizedBox(
                                                                          height:
                                                                              200,
                                                                          child: ListView.builder(
                                                                              itemCount: PrdItem.rawMaterialList.length,
                                                                              itemBuilder: (context, index) {
                                                                                final rmItem = PrdItem.rawMaterialList[index];

                                                                                return Row(
                                                                                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                                                                  children: [
                                                                                    SizedBox(width: size.width * 0.55, child: Text(rmItem.Rm)),
                                                                                    SizedBox(width: size.width * 0.2, child: Text(rmItem.RmQty.toString())),
                                                                                    Text(rmItem.RmRate.toString()),
                                                                                  ],
                                                                                );
                                                                              }))
                                                                    ],
                                                                  ),
                                                                )
                                                              ],
                                                            ),
                                                          ),
                                                        ],
                                                      ),
                                                    );
                                                  },
                                                  title:
                                                      Text(PrdItem.FinishGoods),
                                                  leading: Text('${index + 1}'),
                                                  trailing: Text(
                                                      myFormat.format(
                                                          PrdItem.ProductionDate
                                                              .toDate())),
                                                );
                                              })),
                                    ],
                                    onExpansionChanged: (bool expanded) {
                                      setState(
                                          () => _customTileExpanded = expanded);
                                    },
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ),
                        const SizedBox(
                          height: 20,
                        ),
                        Container(
                          child: Material(
                            elevation: 4,
                            borderRadius:
                                const BorderRadius.all(Radius.circular(12)),
                            child: Container(
                              margin: const EdgeInsets.symmetric(
                                  horizontal: 12, vertical: 20),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  const Padding(
                                    padding: EdgeInsets.fromLTRB(15, 0, 0, 5),
                                    child: Text(
                                      "Today's Purchase",
                                      style: TextStyle(
                                        fontSize: 15,
                                      ),
                                    ),
                                  ),
                                  Padding(
                                    padding: const EdgeInsets.only(left: 15),
                                    child: Text(
                                      "${today_milkPrch_liter.toStringAsFixed(2)} Litr",
                                      style: const TextStyle(
                                          fontSize: 20,
                                          fontWeight: FontWeight.bold),
                                    ),
                                  ),
                                  Padding(
                                    padding: const EdgeInsets.only(left: 15.0),
                                    child: Text(
                                        "Cow Milk - ${cowMilk.toStringAsFixed(2)}"),
                                  ),
                                  Padding(
                                    padding: const EdgeInsets.only(left: 15.0),
                                    child: Text(
                                        "Buffalo Milk - ${buffaloMilk.toStringAsFixed(2)}"),
                                  ),
                                  const SizedBox(
                                    height: 10,
                                  ),
                                  Row(
                                    children: [
                                      const SizedBox(
                                        width: 10,
                                      ),
                                      Expanded(
                                        child: ElevatedButton.icon(
                                          style: ElevatedButton.styleFrom(
                                              padding:
                                                  const EdgeInsets.fromLTRB(
                                                      0, 8, 0, 8),
                                              backgroundColor: MyColors.green,
                                              shape: RoundedRectangleBorder(
                                                  borderRadius:
                                                      BorderRadius.circular(
                                                          10))),
                                          onPressed: () {
                                            Navigator.of(context).push(
                                                MaterialPageRoute(
                                                    builder: (context) =>
                                                        const MilkPurchaseScreen()));
                                          },
                                          label: const Text('Make Purchase'),
                                          icon: const Icon(FeatherIcons.plus),
                                        ),
                                      ),
                                      const SizedBox(
                                        width: 15,
                                      ),
                                      Expanded(
                                        child: ElevatedButton.icon(
                                          style: ElevatedButton.styleFrom(
                                              padding:
                                                  const EdgeInsets.fromLTRB(
                                                      0, 8, 0, 8),
                                              backgroundColor: MyColors.primary,
                                              shape: RoundedRectangleBorder(
                                                  borderRadius:
                                                      BorderRadius.circular(
                                                          10))),
                                          onPressed: () {
                                            Navigator.of(context).push(
                                                MaterialPageRoute(
                                                    builder: (context) =>
                                                        const DetailReportScreen()));
                                          },
                                          label: const Text('Detailed View'),
                                          icon: const Icon(
                                              FeatherIcons.maximize2),
                                        ),
                                      ),
                                      const SizedBox(
                                        width: 10,
                                      ),
                                    ],
                                  ),
                                  ExpansionTile(
                                    tilePadding:
                                        const EdgeInsets.fromLTRB(15, 0, 15, 0),
                                    title: const Text('Recent Purchase'),
                                    children: RecentPurchaseListTiles.length > 0
                                        ? RecentPurchaseListTiles
                                        : [Text("No Purchases!")],
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ),

                        const SizedBox(
                          height: 20,
                        ),

                        Container(
                          child: Material(
                            elevation: 4,
                            borderRadius:
                                const BorderRadius.all(Radius.circular(12)),
                            child: Container(
                              decoration: const BoxDecoration(
                                  borderRadius:
                                      BorderRadius.all(Radius.circular(12))),
                              margin: const EdgeInsets.symmetric(
                                  horizontal: 12, vertical: 20),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  ExpansionTile(
                                    tilePadding:
                                        const EdgeInsets.fromLTRB(2, 0, 2, 0),
                                    title: const Text('Payment Details'),
                                    // trailing: Icon(
                                    //   _customTileExpanded
                                    //       ? FeatherIcons.chevronUp
                                    //       : FeatherIcons.chevronDown,
                                    // ),
                                    children: [
                                      SizedBox(
                                        height: 300,
                                        child: ListView.builder(
                                            shrinkWrap: true,
                                            itemCount: paymentList.length,
                                            itemBuilder: (context, index) {
                                              final payment =
                                                  paymentList[index];

                                              return ListTile(
                                                title:
                                                    Text(payment.SupplierName),
                                                leading: const Text("->"),
                                                trailing: Text(
                                                    payment.PaidAmount
                                                        .toStringAsFixed(2)),
                                              );
                                            }),
                                      ),
                                    ],
                                    onExpansionChanged: (bool expanded) {
                                      setState(
                                          () => _customTileExpanded = expanded);
                                    },
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ),

                        const SizedBox(
                          height: 20,
                        ),

                        // Container(
                        //   child: Material(
                        //     elevation: 4,
                        //     borderRadius:
                        //         const BorderRadius.all(Radius.circular(12)),
                        //     child: Container(
                        //       decoration: const BoxDecoration(
                        //           borderRadius:
                        //               BorderRadius.all(Radius.circular(12))),
                        //       margin: const EdgeInsets.symmetric(
                        //           horizontal: 12, vertical: 20),
                        //       child: Column(
                        //         crossAxisAlignment: CrossAxisAlignment.start,
                        //         children: const [
                        //           Padding(
                        //             padding: EdgeInsets.only(left: 15),
                        //             child: Text(
                        //               "Daily Profit",
                        //               style: TextStyle(
                        //                   fontSize: 18,
                        //                   fontWeight: FontWeight.bold),
                        //             ),
                        //           ),
                        //           Padding(
                        //             padding: EdgeInsets.only(left: 15),
                        //             child: Text(
                        //               "Sample Text Sample Text Sample Text",
                        //               style: TextStyle(fontSize: 14),
                        //             ),
                        //           ),
                        //           SizedBox(
                        //             height: 10,
                        //           ),
                        //           SizedBox(height: 300, child: ActvityChart())
                        //         ],
                        //       ),
                        //     ),
                        //   ),
                        // // ),
                        // const SizedBox(
                        //   height: 20,
                        // ),
                        // Container(
                        //   child: Material(
                        //     elevation: 4,
                        //     borderRadius:
                        //         const BorderRadius.all(Radius.circular(12)),
                        //     child: Container(
                        //       decoration: const BoxDecoration(
                        //           borderRadius:
                        //               BorderRadius.all(Radius.circular(12))),
                        //       margin: const EdgeInsets.symmetric(
                        //           horizontal: 12, vertical: 20),
                        //       child: Column(
                        //         crossAxisAlignment: CrossAxisAlignment.start,
                        //         children: const [
                        //           Padding(
                        //             padding: EdgeInsets.only(left: 15),
                        //             child: Text(
                        //               "Monthly Profit",
                        //               style: TextStyle(
                        //                   fontSize: 18,
                        //                   fontWeight: FontWeight.bold),
                        //             ),
                        //           ),
                        //           Padding(
                        //             padding: EdgeInsets.only(left: 15),
                        //             child: Text(
                        //               "Sample Text Sample Text Sample Text",
                        //               style: TextStyle(fontSize: 14),
                        //             ),
                        //           ),
                        //           SizedBox(
                        //             height: 10,
                        //           ),
                        //           SizedBox(height: 300, child: ActvityChart())
                        //         ],
                        //       ),
                        //     ),
                        //   ),
                        // ),
                        // const SizedBox(
                        //   height: 20,
                        // ),
                        Container(
                          child: Material(
                            elevation: 4,
                            borderRadius:
                                const BorderRadius.all(Radius.circular(12)),
                            child: Container(
                              decoration: const BoxDecoration(
                                  borderRadius:
                                      BorderRadius.all(Radius.circular(12))),
                              margin: const EdgeInsets.symmetric(
                                  horizontal: 12, vertical: 20),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  const Padding(
                                    padding: EdgeInsets.only(left: 15),
                                    child: Text(
                                      "Attendance Details",
                                      style: TextStyle(
                                          fontSize: 18,
                                          fontWeight: FontWeight.bold),
                                    ),
                                  ),
                                  const Padding(
                                    padding: EdgeInsets.only(left: 15),
                                    child: Text(
                                      "Sample Text Sample Text Sample Text",
                                      style: TextStyle(fontSize: 14),
                                    ),
                                  ),
                                  const SizedBox(
                                    height: 10,
                                  ),
                                  Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceAround,
                                    children: [
                                      Column(
                                        children: const [
                                          Text(
                                            "76%",
                                            style: TextStyle(fontSize: 30),
                                          ),
                                          SizedBox(
                                            height: 10,
                                          ),
                                          Text(
                                            "Yesterday\nAttendance",
                                            style: TextStyle(
                                                fontSize: 15,
                                                fontWeight: FontWeight.w600),
                                            textAlign: TextAlign.center,
                                          )
                                        ],
                                      ),
                                      Column(
                                        children: const [
                                          Text(
                                            "12Hrs",
                                            style: TextStyle(fontSize: 30),
                                          ),
                                          SizedBox(
                                            height: 10,
                                          ),
                                          Text("Average\nWorktime",
                                              style: TextStyle(
                                                  fontSize: 15,
                                                  fontWeight: FontWeight.w600),
                                              textAlign: TextAlign.center)
                                        ],
                                      ),
                                    ],
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ),
                        const SizedBox(
                          height: 20,
                        ),
                        Container(
                          child: Material(
                            elevation: 4,
                            borderRadius:
                                const BorderRadius.all(Radius.circular(12)),
                            child: Container(
                              decoration: const BoxDecoration(
                                  borderRadius:
                                      BorderRadius.all(Radius.circular(12))),
                              margin: const EdgeInsets.symmetric(
                                  horizontal: 12, vertical: 20),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  const Padding(
                                    padding: EdgeInsets.only(left: 15),
                                    child: Text(
                                      "More Utilities",
                                      style: TextStyle(
                                          fontSize: 18,
                                          fontWeight: FontWeight.bold),
                                    ),
                                  ),
                                  const Padding(
                                    padding: EdgeInsets.only(left: 15),
                                    child: Text(
                                      "Sample Text Sample Text Sample Text",
                                      style: TextStyle(fontSize: 14),
                                    ),
                                  ),
                                  const SizedBox(
                                    height: 10,
                                  ),
                                  SingleChildScrollView(
                                    scrollDirection: Axis.horizontal,
                                    child: Row(
                                      children: [
                                        Container(
                                          padding: const EdgeInsets.symmetric(
                                              horizontal: 10, vertical: 20),
                                          width: 100,
                                          decoration: BoxDecoration(
                                              border: Border.all(
                                                  color:
                                                      const Color(0x71A4A4A4),
                                                  width: 2),
                                              borderRadius:
                                                  const BorderRadius.all(
                                                      Radius.circular(12))),
                                          child: Column(
                                            children: const [
                                              Icon(
                                                Icons.access_alarm_rounded,
                                                size: 70,
                                              ),
                                              SizedBox(
                                                height: 10,
                                              ),
                                              Text(
                                                "Pending Order Delivery",
                                                style: TextStyle(
                                                    fontSize: 15,
                                                    fontWeight: FontWeight.w800,
                                                    color: Colors.black54),
                                                textAlign: TextAlign.center,
                                              )
                                            ],
                                          ),
                                        ),
                                        const SizedBox(
                                          width: 20,
                                        ),
                                        Container(
                                          padding: const EdgeInsets.symmetric(
                                              horizontal: 10, vertical: 20),
                                          width: 100,
                                          decoration: BoxDecoration(
                                              border: Border.all(
                                                  color:
                                                      const Color(0x71A4A4A4),
                                                  width: 2),
                                              borderRadius:
                                                  const BorderRadius.all(
                                                      Radius.circular(12))),
                                          child: Column(
                                            children: const [
                                              Icon(
                                                Icons.print,
                                                size: 70,
                                              ),
                                              SizedBox(
                                                height: 10,
                                              ),
                                              Text(
                                                "Print Delivery Invoice",
                                                style: TextStyle(
                                                    fontSize: 15,
                                                    fontWeight: FontWeight.w800,
                                                    color: Colors.black54),
                                                textAlign: TextAlign.center,
                                              )
                                            ],
                                          ),
                                        ),
                                        const SizedBox(
                                          width: 20,
                                        ),
                                        Container(
                                          padding: const EdgeInsets.symmetric(
                                              horizontal: 10, vertical: 20),
                                          width: 100,
                                          decoration: BoxDecoration(
                                              border: Border.all(
                                                  color:
                                                      const Color(0x71A4A4A4),
                                                  width: 2),
                                              borderRadius:
                                                  const BorderRadius.all(
                                                      Radius.circular(12))),
                                          child: Column(
                                            children: const [
                                              Icon(
                                                Icons.bar_chart,
                                                size: 70,
                                              ),
                                              SizedBox(
                                                height: 10,
                                              ),
                                              Text(
                                                "Product Wise Sale",
                                                style: TextStyle(
                                                    fontSize: 15,
                                                    fontWeight: FontWeight.w800,
                                                    color: Colors.black54),
                                                textAlign: TextAlign.center,
                                              )
                                            ],
                                          ),
                                        ),
                                        const SizedBox(
                                          width: 20,
                                        ),
                                        Container(
                                          padding: const EdgeInsets.symmetric(
                                              horizontal: 10, vertical: 20),
                                          width: 100,
                                          decoration: BoxDecoration(
                                              border: Border.all(
                                                  color:
                                                      const Color(0x71A4A4A4),
                                                  width: 2),
                                              borderRadius:
                                                  const BorderRadius.all(
                                                      Radius.circular(12))),
                                          child: Column(
                                            children: const [
                                              Icon(
                                                Icons.featured_play_list,
                                                size: 70,
                                              ),
                                              SizedBox(
                                                height: 10,
                                              ),
                                              Text(
                                                "One More Feature",
                                                style: TextStyle(
                                                    fontSize: 15,
                                                    fontWeight: FontWeight.w800,
                                                    color: Colors.black54),
                                                textAlign: TextAlign.center,
                                              )
                                            ],
                                          ),
                                        ),
                                        const SizedBox(
                                          width: 20,
                                        ),
                                      ],
                                    ),
                                  )
                                ],
                              ),
                            ),
                          ),
                        ),
                        const SizedBox(
                          height: 20,
                        ),
                        Container(
                          child: Material(
                            elevation: 4,
                            borderRadius:
                                const BorderRadius.all(Radius.circular(12)),
                            child: Container(
                              decoration: const BoxDecoration(
                                  borderRadius:
                                      BorderRadius.all(Radius.circular(12))),
                              margin: const EdgeInsets.symmetric(
                                  horizontal: 12, vertical: 20),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  const Padding(
                                    padding: EdgeInsets.only(left: 15),
                                    child: Text(
                                      "Upcoming Festivals",
                                      style: TextStyle(
                                          fontSize: 18,
                                          fontWeight: FontWeight.bold),
                                    ),
                                  ),
                                  const Padding(
                                    padding: EdgeInsets.only(left: 15),
                                    child: Text(
                                      "Sample Text Sample Text Sample Text",
                                      style: TextStyle(fontSize: 14),
                                    ),
                                  ),
                                  const SizedBox(
                                    height: 10,
                                  ),
                                  SlideShower(items: const [
                                    "https://image.shutterstock.com/image-vector/biggest-diwali-sale-promotion-yellow-260nw-1523982320.jpg",
                                    // "https://www.creativehatti.com/wp-content/uploads/edd/2021/04/Happy-Navratri-festival-sale-offe r-banner-design-template-06-large.jpg"
                                  ])
                                ],
                              ),
                            ),
                          ),
                        ),
                        const SizedBox(
                          height: 40,
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ),
          );
  }

  Widget borderContainer(
      {required Widget child, required double height, required double width}) {
    return Container(
      height: height,
      width: width,
      decoration: BoxDecoration(
        border: Border.all(
          color: Colors.grey,
        ),
        borderRadius: BorderRadius.circular(5),
      ),
      child: Align(
        alignment: Alignment.centerLeft,
        child: child,
      ),
    );
  }
}
