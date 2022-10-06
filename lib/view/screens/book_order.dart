import 'package:bl_dairy_app/controller/book_order.dart';
import 'package:bl_dairy_app/model/BookOrderModel.dart';
import 'package:flutter/material.dart';

class BookOrderScreen extends StatelessWidget {
  const BookOrderScreen({Key? key}) : super(key: key);





  @override
  Widget build(BuildContext context) {



    return Scaffold(
      body: SingleChildScrollView(
        child: SafeArea(
          child: Column(
            children: [
              Text("Full Name"),
              TextFormField(),


              Text("Contanct Details"),
              TextFormField(),

              Text("Advance Payement"),
              TextFormField(),

              Text("Notes"),
              TextFormField(),

Text("Order"),
              SizedBox(height: 10,),

              Text("Order No.1"),
              TextFormField(),
              Text("Order No.2"),
              TextFormField(),
              Text("Order No.3"),
              TextFormField(),
              Text("Order No.4"),
              TextFormField(),
              Text("REVIEW ORDER DETAILS AND THEN BOOK IT"),
              ElevatedButton(onPressed: (){


                BookOrderController.addOrder(Order(CustomerName: "DEMO", MobileNumber: "999", Advance: "1000", Note: "DEMO NOTE", OrderBookDate: "DEMO DATE", OrderDelivaryDate: "DEMO DATE", items: []));
              }, child: Text("Book Order"))
            ],
          ),
        ),
      ),
    );
  }
}
