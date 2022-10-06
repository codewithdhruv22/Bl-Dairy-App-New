import 'package:bl_dairy_app/controller/book_order.dart';
import 'package:bl_dairy_app/model/BookOrderModel.dart';
import 'package:bl_dairy_app/view/widgets/Custom_TextFiled.dart';
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
                CustomTextFiled(
                  textEditingController: fullNameController,
                  hintText: "Full Name",
                ),
                const SizedBox(
                  height: 10,
                ),
                CustomTextFiled(
                  textEditingController: fullNameController,
                  hintText: "Contanct Details",
                ),
                const SizedBox(
                  height: 10,
                ),
                CustomTextFiled(
                  textEditingController: fullNameController,
                  hintText: "Advance Payement",
                ),
                const SizedBox(
                  height: 10,
                ),
                CustomTextFiled(
                  textEditingController: fullNameController,
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
                          onPressed: () {},
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
