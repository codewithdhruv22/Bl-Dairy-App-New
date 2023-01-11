import 'package:bl_dairy_app/view/screens/PaymentPage.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:velocity_x/velocity_x.dart';

Widget ShopItemCard(
    { required context,
    required String orderName,
    required String orderPrice,
    required String orderPic,
    required String orderCategory,
    required bool isPerKg}) {
  Color OrderStatusColor = Colors.green;

  TextEditingController quantityController = TextEditingController();

  return InkWell(
    onTap: () {
      VxBottomSheet.bottomSheetView(
        context,
        isDismissible: true,
        backgroundColor: Colors.white,
        isSafeAreaFromBottom: true,
        child: Container(
          height: 350,
          child: Column(
            children: <Widget>[
              SingleChildScrollView(
                  child: Padding(
                padding: const EdgeInsets.symmetric(vertical: 30),
                child: Column(
                  children: [
                    Text(
                      "How much kg/l you want to buy ?",
                      style: TextStyle(fontSize: 25),
                      textAlign: TextAlign.center,
                    ),
                    SizedBox(
                      height: 10,
                      width: MediaQuery.of(context).size.width,
                    ),
                    Container(
                      margin:
                          EdgeInsets.symmetric(horizontal: 20, vertical: 10),
                      decoration: BoxDecoration(
                          border: Border.all(color: Colors.black),
                          borderRadius: BorderRadius.circular(15)),
                      child: TextField(
                        controller: quantityController,
                        cursorColor: Colors.black,
                        keyboardType: TextInputType.number,
                        decoration: InputDecoration(
                            border: InputBorder.none,
                            focusedBorder: InputBorder.none,
                            enabledBorder: InputBorder.none,
                            errorBorder: InputBorder.none,
                            disabledBorder: InputBorder.none,
                            contentPadding: EdgeInsets.only(
                                left: 15, bottom: 11, top: 11, right: 15),
                            hintText: "in Kg/l"),
                      ),
                    ),
                    ElevatedButton(
                        onPressed: () {
                       
                          Fluttertoast.showToast(
                              msg: "Please Complete The Payment");
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => PaymentScreen(
                                      amount: (double.parse(orderPrice) * double.parse(quantityController.text.toString())))));
                        },
                        child: Text("Complete Payment"))
                  ],
                ),
              )),
            ],
          ),
        ),
      );
    },
    child: Card(
      elevation: 0.4,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
      child: Container(
        padding: EdgeInsets.symmetric(vertical: 10, horizontal: 10),
        decoration: BoxDecoration(borderRadius: BorderRadius.circular(23)),
        margin: EdgeInsets.symmetric(vertical: 10, horizontal: 5),
        child: Row(crossAxisAlignment: CrossAxisAlignment.start, children: [
          Container(
            height: 90,
            width: 90,
            decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(19),
                image: DecorationImage(
                    fit: BoxFit.cover, image: NetworkImage(orderPic))),
          ),
          SizedBox(
            width: 20,
          ),
          Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                orderName,
                style: TextStyle(fontSize: 20),
              ),
              SizedBox(
                height: 5,
              ),
              Text(
                orderCategory,
                style: TextStyle(color: Colors.grey),
              ),
              SizedBox(
                height: 5,
              ),
            ],
          ),
          Spacer(),
          Column(
            children: [
              SizedBox(
                height: 6,
              ),
              Text(
                "Rs.$orderPrice",
                style: TextStyle(fontSize: 18, color: OrderStatusColor),
              ),
              SizedBox(
                height: 10,
              ),
              Text(
                isPerKg ? "Per Kg" : "Per Liter",
                style: TextStyle(
                  fontSize: 15,
                ),
              )
            ],
          ),
          SizedBox(
            width: 20,
          ),
        ]),
      ),
    ),
  );
}
