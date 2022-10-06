import 'package:bl_dairy_app/controller/book_order.dart';
import 'package:bl_dairy_app/model/BookOrderModel.dart';
import 'package:bl_dairy_app/view/widgets/Custom_TextFiled.dart';
import 'package:flutter/material.dart';
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
                CustomTextFiled(
                  textEditingController: fullNameController,
                  hintText: "Name",
                ),
                const SizedBox(
                  height: 10,
                ),
                CustomTextFiled(
                  textEditingController: mobileNumberController,
                  hintText: "Mobile Number",
                ),
                const SizedBox(
                  height: 10,
                ),
                CustomTextFiled(
                  textEditingController: advancePaymentController,
                  hintText: "Advance Payement",
                ),
                const SizedBox(
                  height: 10,
                ),
                CustomTextFiled(
                  textEditingController: remarkController,
                  hintText: "Remark",
                ),
                const SizedBox(
                  height: 10,
                ),
                Container(
                  decoration: BoxDecoration(
                    border: Border.all(
                      color: Colors.black,
                    ),
                  ),
                  child: Padding(
                    padding: const EdgeInsets.only(
                      left: 5,
                      right: 5,
                    ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        const Text('Create Order'),
                        ElevatedButton(
                          onPressed: () {
                            VxBottomSheet.bottomSheetView(
                              context,
                              roundedFromTop: true,
                              isDismissible: false,
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
                                                alignment: Alignment.topLeft,
                                                child: IconButton(
                                                  onPressed: () {
                                                    Navigator.pop(context);
                                                  },
                                                  icon: const Icon(Icons.close),
                                                ),
                                              ),
                                              const SizedBox(
                                                height: 10,
                                              ),
                                              CustomTextFiled(
                                                textEditingController:
                                                    bProductNameController,
                                                hintText: 'Product Name',
                                              ),
                                              const SizedBox(
                                                height: 20,
                                              ),
                                              Row(
                                                children: [
                                                  SizedBox(
                                                    width: 132,
                                                    child: CustomTextFiled(
                                                      textEditingController:
                                                          bQuantityController,
                                                      hintText: 'Quantity',
                                                    ),
                                                  ),
                                                  const SizedBox(
                                                    width: 8,
                                                  ),
                                                  SizedBox(
                                                    width: 100,
                                                    child: CustomTextFiled(
                                                      textEditingController:
                                                          bRateController,
                                                      hintText: 'Rate',
                                                    ),
                                                  ),
                                                  const SizedBox(
                                                    width: 8,
                                                  ),
                                                  SizedBox(
                                                    width: 100,
                                                    child: CustomTextFiled(
                                                      textEditingController:
                                                          bAmountController,
                                                      hintText: 'Amount',
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
                                                  SizedBox(
                                                    height: 50,
                                                    width: 170,
                                                    child: ElevatedButton.icon(
                                                      onPressed: () {},
                                                      icon: const Icon(
                                                        Icons.delete,
                                                      ),
                                                      label:
                                                          const Text('Deleted'),
                                                      style: ElevatedButton
                                                          .styleFrom(
                                                        backgroundColor:
                                                            Colors.red,
                                                        shape:
                                                            RoundedRectangleBorder(
                                                          borderRadius:
                                                              BorderRadius
                                                                  .circular(10),
                                                        ),
                                                      ),
                                                    ),
                                                  ),
                                                  SizedBox(
                                                    height: 50,
                                                    width: 170,
                                                    child: ElevatedButton.icon(
                                                      onPressed: () {},
                                                      icon: const Icon(
                                                        Icons.add,
                                                      ),
                                                      label: const Text('Add'),
                                                      style: ElevatedButton
                                                          .styleFrom(
                                                        backgroundColor:
                                                            Colors.green,
                                                        shape:
                                                            RoundedRectangleBorder(
                                                          borderRadius:
                                                              BorderRadius
                                                                  .circular(10),
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
                            backgroundColor: Colors.green,
                            shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(10)),
                          ),
                          child: const Text('add +'),
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
