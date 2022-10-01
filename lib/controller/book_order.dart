import 'package:bl_dairy_app/model/BookOrderModel.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class BookOrderController{
late List<Order> orderList;
fetchOrder() async{
  FirebaseFirestore.instance.collection("BookOrder").snapshots().map((QuerySnapshot query){
    for (var element in query.docs){
      orderList.add(Order.fromSnap(element));
      print(orderList);
    }


  });

  // fetchComment() async{
  //   _comments.bindStream(FirebaseFirestore.instance.collection("videos").doc(_postID).collection("comments").snapshots().map((QuerySnapshot query){
  //     List<Comment> retVal = [];
  //     for (var element in query.docs){
  //       retVal.add(Comment.fromSnap(element));
  //     }
  //     return retVal;
  //   }));
  // }
}
}