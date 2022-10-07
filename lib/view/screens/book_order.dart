import 'package:bl_dairy_app/constants/Theme.dart';
import 'package:bl_dairy_app/controller/book_order.dart';
import 'package:bl_dairy_app/model/BookOrderModel.dart';
import 'package:flutter/material.dart';
import 'package:flutter_feather_icons/flutter_feather_icons.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:velocity_x/velocity_x.dart';

class BookOrderScreen extends ConsumerStatefulWidget {
  const BookOrderScreen({Key? key}) : super(key: key);

  @override
  ConsumerState<BookOrderScreen> createState() => _BookOrderScreenState();
}

class _BookOrderScreenState extends ConsumerState<BookOrderScreen> {
  TextEditingController fullNameController = TextEditingController();
  TextEditingController mobileNumberController = TextEditingController();
  TextEditingController advancePaymentController = TextEditingController();
  TextEditingController remarkController = TextEditingController();

  TextEditingController bProductNameController = TextEditingController();
  TextEditingController bQuantityController = TextEditingController();
  TextEditingController bRateController = TextEditingController();
  TextEditingController bAmountController = TextEditingController();

  final _dateProvider = StateProvider<DateTime>((ref) {
    return DateTime(2020, 11, 17);
  });
  void _selectDate(WidgetRef ref) async {
    final DateTime? newDate = await showDatePicker(
      context: context,
      initialDate: ref.watch(_dateProvider),
      firstDate: DateTime(2017, 1),
      lastDate: DateTime(2022, 7),
      helpText: 'Select a date',
    );
    if (newDate != null) {
      ref.read(_dateProvider.notifier).state = newDate;
    }
  }

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
    final date = ref.watch(_dateProvider.notifier).state;
    final Size size = MediaQuery.of(context).size;
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
                  keyboardType: TextInputType.number,
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
                Row(
                  children: [
                    SizedBox(
                      width: MediaQuery.of(context).size.width * 0.5,
                      height: 50,
                      child: TextFormField(
                        decoration: const InputDecoration(
                          contentPadding:
                              EdgeInsets.symmetric(vertical: 0, horizontal: 15),
                          labelStyle: TextStyle(fontSize: 14),
                          labelText: 'Advance Payment',
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
                          height: 45,
                          decoration: BoxDecoration(
                            border: Border.all(
                              color: MyColors.defaultColor,
                            ),
                            borderRadius: BorderRadius.circular(5),
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
                              elevation: 20,
                              roundedFromTop: false,
                              isDismissible: true,
                              backgroundColor: Colors.white,
                              isSafeAreaFromBottom: true,
                              child: SizedBox(
                                height: MediaQuery.of(context).size.height,
                                child: Column(
                                  children: [
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
                                    Padding(
                                      padding: const EdgeInsets.symmetric(
                                          horizontal: 20, vertical: 10),
                                      child: Column(
                                        children: <Widget>[
                                          const SizedBox(
                                            height: 5,
                                          ),
                                          TextFormField(
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
                                            onChanged: (value) {
                                              BookOrderController.fetchItems(
                                                  value);
                                            },
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
                                                        EdgeInsets.symmetric(
                                                            vertical: 0,
                                                            horizontal: 15),
                                                    labelStyle:
                                                        TextStyle(fontSize: 14),
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


    // InkWell(
    //                   onTap:()=> _selectDate(ref),
    //                   child: SizedBox(
    //                     width: MediaQuery.of(context).size.width * 0.4,
    //                     child: Container(
    //                       height: 45,
    //                       decoration: BoxDecoration(
    //                         border: Border.all(
    //                           color: Colors.black,
    //                         ),
    //                         borderRadius: BorderRadius.circular(5),
    //                       ),
    //                       child: Center(
    //                         child: Text(
    //                           "${_date.day}-${_date.month}-${_date.year}",
    //                           style: const TextStyle(
    //                             fontSize: 16,
    //                           ),
    //                         ),
    //                       ),
    //                     ),
    //                   ),
    //                 ),








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
