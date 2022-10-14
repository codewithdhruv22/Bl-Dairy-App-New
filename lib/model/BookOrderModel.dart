import 'package:cloud_firestore/cloud_firestore.dart';

import '../view/screens/book_order.dart';

class Order {

  String CustomerName;
  String MobileNumber;
  String Advance;
  String Note;
  Timestamp OrderBookDate;
  Timestamp OrderDelivaryDate;
  List<OrderItem> items;



  Order({

    required this.CustomerName,
    required this.MobileNumber,
    required this.Advance,
    required this.Note,
    required this.OrderBookDate,
    required this.OrderDelivaryDate,
    required this.items


  });



  Map<String , dynamic> toJson(){
    List<Map<String,dynamic>> DataBaseItemList = [];

    items.forEach((item){
      DataBaseItemList.add(item.toJson());
    });
    return {
      "CustomerName" : CustomerName,
      "Advance": Advance,
      "MobileNumber" : MobileNumber,
      "Note" : Note,
      "OrderBookDate" : OrderBookDate,
      "OrderDelivaryDate" : OrderDelivaryDate,
      "items" : DataBaseItemList


    };
    
  }



  static Order fromSnap(DocumentSnapshot snap){
    var snapshot = snap.data() as Map<String , dynamic>;



    List<OrderItem> orderItemFromSnap = [];
    (snapshot["items"] as List<dynamic>).forEach((itemDet) {

      orderItemFromSnap.add(
          OrderItem(itemRate: itemDet["itemRate"], itemQty: itemDet["itemQty"], itemName: itemDet["itemName"], itemAmnt: itemDet["itemAmnt"])



      );
    });
   return Order(
       CustomerName : snapshot["CustomerName"] ?? "NO DATA",
     Advance : snapshot["Advance"] ?? "NO DATA",
     MobileNumber : snapshot["MobileNumber"] ?? "NO DATA",
     Note : snapshot["Note"] ?? "NO DATA",
     OrderBookDate : snapshot["OrderBookDate"] ,
     OrderDelivaryDate : snapshot["OrderDelivaryDate"],
     items: orderItemFromSnap


   );
  }
}








class OrderItem{
  String itemName;
  int itemRate;
  int itemQty;
  int itemAmnt;


  OrderItem({

    required this.itemRate,
    required this.itemQty,
    required this.itemName,
    required this.itemAmnt


  });

  Map<String , dynamic> toJson()=>{
    "itemRate" : itemRate,
    "itemQty" : itemQty,
    "itemName" : itemName,
    "itemAmnt" : itemAmnt,

  };



  static OrderItem fromSnap(DocumentSnapshot snap){
    var snapshot = snap.data() as Map<String , dynamic>;
    return OrderItem(
      itemRate : snapshot["itemRate"] ,
      itemQty : snapshot["itemQty"] ,
      itemName : snapshot["itemName"],
      itemAmnt : snapshot["itemAmnt"] ,
    );
  }
}


class ProductList{

  String ProductCategory;
  String ProductName;


  ProductList({

    required this.ProductCategory,
    required this.ProductName,


  });

  Map<String , dynamic> toJson()=>{
    "ProductCategory" : ProductCategory,
    "ProductName" : ProductName,

  };



  static ProductList fromSnap(DocumentSnapshot snap){
    var snapshot = snap.data() as Map<String , dynamic>;
    return ProductList(
      ProductCategory : snapshot["ProductCategory"] ?? "NO DATA",
      ProductName : snapshot["ProductName"] ?? "NO DATA",
    );
  }

}