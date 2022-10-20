import 'package:bl_dairy_app/model/paymentModel.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class PaymentController{

static Future<void> addPayment(PaymentModel paymentModel) async{
  await FirebaseFirestore.instance.collection("NewPayment").add(paymentModel.toJson());
}


static Future<List<PaymentModel>> fetchAllPayments() async{
  List<PaymentModel> all_payment = [];

  await FirebaseFirestore.instance.collection("NewPayment").get().then((result){
    result.docs.forEach((payment) {
      all_payment.add(PaymentModel.fromSnap(payment));
    });
  });
  return all_payment;
}
}