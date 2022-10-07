import 'package:bl_dairy_app/constants/Theme.dart';
import 'package:bl_dairy_app/controller/book_order.dart';
import 'package:bl_dairy_app/model/BookOrderModel.dart';
import 'package:flutter/material.dart';
import 'package:flutter_feather_icons/flutter_feather_icons.dart';
import 'package:velocity_x/velocity_x.dart';

class BookOrderScreen extends StatefulWidget {
  const BookOrderScreen({Key? key}) : super(key: key);

  @override
  State<BookOrderScreen> createState() => _BookOrderScreenState();
}

class _BookOrderScreenState extends State<BookOrderScreen> {
  TextEditingController fullNameController = TextEditingController();
  TextEditingController mobileNumberController = TextEditingController();
  TextEditingController advancePaymentController = TextEditingController();
  TextEditingController remarkController = TextEditingController();

  TextEditingController bProductNameController = TextEditingController();
  TextEditingController bQuantityController = TextEditingController();
  TextEditingController bRateController = TextEditingController();
  TextEditingController bAmountController = TextEditingController();
  @override
  void dispose() {
    fullNameController.dispose();
    mobileNumberController.dispose();
    advancePaymentController.dispose();
    remarkController.dispose();
    bProductNameController.dispose();
    bQuantityController.dispose();
    bRateController.dispose();
    bAmountController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: SafeArea(
          child: Padding(
            padding: const EdgeInsets.symmetric(
              horizontal: 10,
              vertical: 10,
            ),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                TextFormField(
                  decoration: const InputDecoration(
                    contentPadding:
                        EdgeInsets.symmetric(vertical: 0, horizontal: 15),
                    labelStyle: TextStyle(fontSize: 14),
                    labelText: 'Name',
                    border: OutlineInputBorder(),
                  ),
                ),
                const SizedBox(
                  height: 12,
                ),
                TextFormField(
                  maxLength: 10,
                  decoration: const InputDecoration(
                    contentPadding:
                        EdgeInsets.symmetric(vertical: 0, horizontal: 15),
                    labelStyle: TextStyle(fontSize: 14),
                    labelText: 'Mobile Number',
                    helperText: 'Without Country Code',
                    border: OutlineInputBorder(),
                  ),
                ),
                const SizedBox(
                  height: 12,
                ),
                TextFormField(
                  decoration: const InputDecoration(
                    contentPadding:
                        EdgeInsets.symmetric(vertical: 0, horizontal: 15),
                    labelStyle: TextStyle(fontSize: 14),
                    labelText: 'Advance Payment',
                    border: OutlineInputBorder(),
                  ),
                ),
                const SizedBox(
                  height: 12,
                ),
                TextFormField(
                  decoration: const InputDecoration(
                    contentPadding:
                        EdgeInsets.symmetric(vertical: 0, horizontal: 15),
                    labelStyle: TextStyle(fontSize: 14),
                    labelText: 'Remark',
                    border: OutlineInputBorder(),
                  ),
                ),
                const SizedBox(
                  height: 12,
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
                              roundedFromTop: true,
                              isDismissible: true,
                              backgroundColor: Colors.white,
                              isSafeAreaFromBottom: true,
                              child: SizedBox(
                                height: 300,
                                child: Padding(
                                  padding: const EdgeInsets.symmetric(
                                    horizontal: 20,
                                  ),
                                  child: Column(
                                    children: <Widget>[
                                      SingleChildScrollView(
                                        child: Expanded(
                                          child: Column(
                                            children: <Widget>[
                                              Align(
                                                alignment:
                                                    Alignment.centerRight,
                                                child: IconButton(
                                                  onPressed: () {
                                                    Navigator.pop(context);
                                                  },
                                                  icon: const Icon(
                                                    FeatherIcons.x,
                                                    color:
                                                        MyColors.defaultColor,
                                                  ),
                                                ),
                                              ),
                                              const SizedBox(
                                                height: 5,
                                              ),
                                              TextFormField(

                                                decoration:
                                                    const InputDecoration(
                                                  contentPadding:
                                                      EdgeInsets.symmetric(
                                                          vertical: 0,
                                                          horizontal: 15),
                                                  labelStyle:
                                                      TextStyle(fontSize: 14),
                                                  labelText: 'Product',
                                                  border: OutlineInputBorder(),
                                                ),

                                                onChanged: (value){

                                                  BookOrderController.fetchItems(value);
                                                },
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
                                                    child: TextFormField(
                                                      decoration:
                                                          const InputDecoration(
                                                        contentPadding:
                                                            EdgeInsets
                                                                .symmetric(
                                                                    vertical: 0,
                                                                    horizontal:
                                                                        15),
                                                        labelStyle: TextStyle(
                                                            fontSize: 14),
                                                        labelText: 'Quantity',
                                                        border:
                                                            OutlineInputBorder(),
                                                      ),
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
                                                            EdgeInsets
                                                                .symmetric(
                                                                    vertical: 0,
                                                                    horizontal:
                                                                        15),
                                                        labelStyle: TextStyle(
                                                            fontSize: 14),
                                                        labelText: 'Rate',
                                                        border:
                                                            OutlineInputBorder(),
                                                      ),
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
                                                            EdgeInsets
                                                                .symmetric(
                                                                    vertical: 0,
                                                                    horizontal:
                                                                        15),
                                                        labelStyle: TextStyle(
                                                            fontSize: 14),
                                                        labelText: 'Amount',
                                                        border:
                                                            OutlineInputBorder(),
                                                      ),
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
                                                    MainAxisAlignment
                                                        .spaceBetween,
                                                children: [
                                                  Expanded(
                                                    child: ElevatedButton.icon(
                                                      onPressed: () {
                                                        Navigator.pop(context);
                                                      },
                                                      icon: const Icon(
                                                        FeatherIcons.trash2,
                                                        size: 18,
                                                      ),
                                                      label:
                                                          const Text('Delete'),
                                                      style: ElevatedButton
                                                          .styleFrom(
                                                        padding:
                                                            const EdgeInsets
                                                                    .fromLTRB(
                                                                0, 4, 0, 4),
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
                                                ],
                                              ),
                                            ],
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
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
                const SizedBox(
                  height: 10,
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
                    ListTile(
                      title: Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: const [
                          Text('Ice Creame'),
                          Text('500'),
                          Text('10'),
                          Text('5000'),
                        ],
                      ),
                    ),
                    const Divider(
                      thickness: 0.5,
                      color: Colors.grey,
                    ),
                    ListTile(
                      title: Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: const [
                          Text('Milk Packet'),
                          Text('300'),
                          Text('20'),
                          Text('6000'),
                        ],
                      ),
                    ),
                    const Divider(
                      thickness: 0.5,
                      color: Colors.grey,
                    ),
                    ListTile(
                      title: Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: const [
                          Text('Grand Total'),
                          Text('--'),
                          Text('--'),
                          Text('11000'),
                        ],
                      ),
                    ),
                  ],
                ),
                const SizedBox(
                  height: 20,
                ),
                SizedBox(
                  height: 50,
                  width: double.infinity,
                  child: ElevatedButton(
                    onPressed: () {
                      BookOrderController.addOrder(Order(
                        CustomerName: "DEMO",
                        MobileNumber: "999",
                        Advance: "1000",
                        Note: "DEMO NOTE",
                        OrderBookDate: "DEMO DATE",
                        OrderDelivaryDate: "DEMO DATE",
                        items: [],
                      ));
                    },
                    child: const Text("Book Order"),
                  ),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}

// ElevatedButton(
//                 onPressed: () {
//                   BookOrderController.addOrder(Order(
//                     CustomerName: "DEMO",
//                     MobileNumber: "999",
//                     Advance: "1000",
//                     Note: "DEMO NOTE",
//                     OrderBookDate: "DEMO DATE",
//                     OrderDelivaryDate: "DEMO DATE",
//                     items: [],
//                   ));
//                 },
//                 child: const Text("Book Order"),
//               )

// const Text("Order No.1"),
//             TextFormField(),
//             const Text("Order No.2"),
//             TextFormField(),
//             const Text("Order No.3"),
//             TextFormField(),
//             const Text("Order No.4"),
//             TextFormField(),
//             const Text("REVIEW ORDER DETAILS AND THEN BOOK IT"),
