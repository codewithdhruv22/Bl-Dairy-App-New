import 'package:bl_dairy_app/constants/Theme.dart';
import 'package:bl_dairy_app/controller/book_order.dart';
import 'package:bl_dairy_app/model/BookOrderModel.dart';
import 'package:flutter/material.dart';

class BookOrderScreen extends StatefulWidget {
  const BookOrderScreen({Key? key}) : super(key: key);

  @override
  State<BookOrderScreen> createState() => _BookOrderScreenState();
}

class _BookOrderScreenState extends State<BookOrderScreen> {
  TextEditingController fullNameController = TextEditingController();

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
                  decoration: const InputDecoration(
                    contentPadding:
                        EdgeInsets.symmetric(vertical: 0, horizontal: 15),
                    labelStyle: TextStyle(fontSize: 14),
                    labelText: 'Mobile Number',
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
                    labelText: 'Advance',
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
                          onPressed: () {},
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
                const Text("Order No.1"),
                TextFormField(),
                const Text("Order No.2"),
                TextFormField(),
                const Text("Order No.3"),
                TextFormField(),
                const Text("Order No.4"),
                TextFormField(),
                const Text("REVIEW ORDER DETAILS AND THEN BOOK IT"),
                ElevatedButton(
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
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
