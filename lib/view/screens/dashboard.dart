import 'package:bl_dairy_app/controller/book_order.dart';
import 'package:bl_dairy_app/view/widgets/SlideShower.dart';
import 'package:bl_dairy_app/view/widgets/main_chart.dart';
import 'package:flutter/material.dart';
import 'package:flutter_feather_icons/flutter_feather_icons.dart';
import 'package:velocity_x/velocity_x.dart';
import '../../constants/Theme.dart';
import '../../model/BookOrderModel.dart';
import '../widgets/Custom_TextFiled.dart';

class Dashboard_Scren extends StatefulWidget {
  const Dashboard_Scren({Key? key}) : super(key: key);

  @override
  State<Dashboard_Scren> createState() => _Dashboard_ScrenState();
}

class _Dashboard_ScrenState extends State<Dashboard_Scren> {
  late List<Order> dashOrderList;
  bool loading = true;

  GetOrders() async {
    await BookOrderController.fetchOrder().then((allOrders) {
      setState(() {
        dashOrderList = allOrders!;
        loading = false;
      });
    });
  }

  @override
  void initState() {
    super.initState();
    GetOrders();
  }

  bool _customTileExpanded = false;
  @override
  Widget build(BuildContext context) {
    return loading
        ? const Scaffold(
            body: Center(
              child: CircularProgressIndicator(),
            ),
          )
        : Scaffold(
            backgroundColor: const Color(0xB3DDDCDC),
            body: SafeArea(
              child: SingleChildScrollView(
                child: Container(
                  margin: const EdgeInsets.symmetric(horizontal: 10),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const SizedBox(
                        height: 60,
                      ),
                      // container for Dashboard Title
                      Container(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: const [
                            Text(
                              "Dashboard",
                              style: TextStyle(
                                  fontSize: 25, fontWeight: FontWeight.bold),
                            ),
                            Text(
                              "Sample Text Sample Text Sample Text",
                              style: TextStyle(fontSize: 14),
                            ),
                          ],
                        ),
                      ),
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
                                const CustomTextFiled(
                                  label: 'hello',
                                  value: 'Ashvin choudhry',
                                ),
                                ExpansionTile(
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
                                            final order = dashOrderList[index];
                                            return ListTile(
                                              onTap: () {
                                                VxBottomSheet.bottomSheetView(
                                                  context,
                                                  isDismissible: true,
                                                  backgroundColor: Colors.white,
                                                  isSafeAreaFromBottom: true,
                                                  child: Expanded(
                                                    // height: 300,
                                                    child: Column(
                                                      children: <Widget>[
                                                        SingleChildScrollView(
                                                          child: Expanded(
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
                                                                          CustomTextFiled(
                                                                              label: "Customer Name",
                                                                              value: order.CustomerName),
                                                                          const Expanded(
                                                                              child: SizedBox(
                                                                            width:
                                                                                10,
                                                                          )),
                                                                          CustomTextFiled(
                                                                              label: 'Number',
                                                                              value: order.MobileNumber),
                                                                          const Expanded(
                                                                              child: SizedBox(
                                                                            width:
                                                                                10,
                                                                          ))
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
                                                                          CustomTextFiled(
                                                                              label: "Order Date",
                                                                              value: order.OrderBookDate),
                                                                          const Expanded(
                                                                              child: SizedBox(
                                                                            width:
                                                                                10,
                                                                          )),
                                                                          CustomTextFiled(
                                                                              label: 'Dilivery Date',
                                                                              value: order.OrderDelivaryDate),
                                                                          const Expanded(
                                                                              child: SizedBox(
                                                                            width:
                                                                                10,
                                                                          )),
                                                                          CustomTextFiled(
                                                                              label: 'Advance Payment',
                                                                              value: order.OrderDelivaryDate),
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
                                                                          CustomTextFiled(
                                                                              label: "Notes",
                                                                              value: order.Note),
                                                                        ],
                                                                      ),
                                                                      const Divider(),
                                                                      Row(
                                                                        mainAxisAlignment:
                                                                            MainAxisAlignment.spaceBetween,
                                                                        children: const [
                                                                          Text(
                                                                              'Order Name'),
                                                                          Text(
                                                                              'Quanitiy'),
                                                                          Text(
                                                                              'Rate'),
                                                                          Text(
                                                                              'Amount'),
                                                                        ],
                                                                      ),
                                                                    ],
                                                                  ),
                                                                )
                                                              ],
                                                            ),
                                                          ),
                                                        ),
                                                      ],
                                                    ),
                                                  ),
                                                );

                                                // print(order.MobileNumber);
                                                // print(order.OrderBookDate);
                                                // print(order.CustomerName);
                                                // print(order.items);
                                                // print(order.Advance);
                                                // print(order.Note);
                                                // print(order.OrderDelivaryDate);

                                                // showDialog<String>(
                                                //     context: context,
                                                //     builder:
                                                //         (BuildContext context) {
                                                //       return const Text('data');
                                                //       // return AlertDialog(
                                                //       //   title: const Text(
                                                //       //       "Order Detials"),
                                                //       //   content: SizedBox(
                                                //       //     width: MediaQuery.of(
                                                //       //                 context)
                                                //       //             .size
                                                //       //             .width -
                                                //       //         50,
                                                //       //     height: 200,
                                                //       //     child:
                                                //       //         SingleChildScrollView(
                                                //       //       child: Column(
                                                //       //         children: [
                                                //       //           Text(order
                                                //       //               .CustomerName),
                                                //       //           Text(order
                                                //       //               .MobileNumber),
                                                //       //           Text(order
                                                //       //               .OrderBookDate),
                                                //       //           Text(order
                                                //       //               .OrderDelivaryDate),
                                                //       //           Text(
                                                //       //               order.Note),
                                                //       //           Text(order
                                                //       //               .Advance),
                                                //       //           const SizedBox(
                                                //       //             height: 20,
                                                //       //           ),
                                                //       //           const Text(
                                                //       //               "Item Details"),
                                                //       //           SizedBox(
                                                // //       //             height: 200,
                                                //                   child: ListView
                                                //                       .builder(
                                                //                           itemCount: order
                                                //                               .items
                                                //                               .length,
                                                //                           itemBuilder:
                                                //                               (context, index) {
                                                //                             final item =
                                                //                                 order.items[index];
                                                //                             return ListTile(
                                                //                               leading: Text(item.itemName),
                                                //                               title: Text(item.itemQty.toString()),
                                                //                               trailing: Text(item.itemRate.toString()),
                                                //                             );
                                                //                           }),
                                                //       //           )
                                                //       //         ],
                                                //       //       ),
                                                //       //     ),
                                                //       //   ),
                                                //       //   actions: <Widget>[
                                                //       //     TextButton(
                                                //       //         onPressed: () {
                                                //       //           Navigator.pop(
                                                //       //               context);
                                                //       //         },
                                                //       //         child: const Text(
                                                //       //             "Close"))
                                                //       //   ],
                                                //       // );
                                                //     });
                                              },
                                              title: Text(order.CustomerName),
                                              leading: Text("${index + 1}"),
                                              trailing:
                                                  Text(order.OrderBookDate),
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
                              children: const [
                                Padding(
                                  padding: EdgeInsets.only(left: 15),
                                  child: Text(
                                    "Daily Profit",
                                    style: TextStyle(
                                        fontSize: 18,
                                        fontWeight: FontWeight.bold),
                                  ),
                                ),
                                Padding(
                                  padding: EdgeInsets.only(left: 15),
                                  child: Text(
                                    "Sample Text Sample Text Sample Text",
                                    style: TextStyle(fontSize: 14),
                                  ),
                                ),
                                SizedBox(
                                  height: 10,
                                ),
                                SizedBox(height: 300, child: ActvityChart())
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
                              children: const [
                                Padding(
                                  padding: EdgeInsets.only(left: 15),
                                  child: Text(
                                    "Monthly Profit",
                                    style: TextStyle(
                                        fontSize: 18,
                                        fontWeight: FontWeight.bold),
                                  ),
                                ),
                                Padding(
                                  padding: EdgeInsets.only(left: 15),
                                  child: Text(
                                    "Sample Text Sample Text Sample Text",
                                    style: TextStyle(fontSize: 14),
                                  ),
                                ),
                                SizedBox(
                                  height: 10,
                                ),
                                SizedBox(height: 300, child: ActvityChart())
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
                                                color: const Color(0x71A4A4A4),
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
                                                color: const Color(0x71A4A4A4),
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
                                                color: const Color(0x71A4A4A4),
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
                                                color: const Color(0x71A4A4A4),
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
                                  "https://www.creativehatti.com/wp-content/uploads/edd/2021/04/Happy-Navratri-festival-sale-offer-banner-design-template-06-large.jpg"
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
          );
  }
}
