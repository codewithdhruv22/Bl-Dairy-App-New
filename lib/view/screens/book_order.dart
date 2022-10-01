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
              ElevatedButton(onPressed: (){}, child: Text("Book Order"))
            ],
          ),
        ),
      ),
    );
  }
}
