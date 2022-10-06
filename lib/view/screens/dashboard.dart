import 'package:bl_dairy_app/controller/book_order.dart';
import 'package:bl_dairy_app/view/widgets/SlideShower.dart';
import 'package:bl_dairy_app/view/widgets/main_chart.dart';
import 'package:flutter/material.dart';
import '../../model/BookOrderModel.dart';

class Dashboard_Scren extends StatefulWidget {
  const Dashboard_Scren({Key? key}) : super(key: key);

  @override
  State<Dashboard_Scren> createState() => _Dashboard_ScrenState();
}

class _Dashboard_ScrenState extends State<Dashboard_Scren> {
  late List<Order> dashOrderList;
bool loading = true;

  GetOrders() async{

   await  BookOrderController.fetchOrder().then((allOrders){
     setState(() {
       dashOrderList = allOrders!;
       loading = false;
     });
   });
   }
  @override
  void initState() {
    // TODO: implement initState



    super.initState();
GetOrders();


  }
  @override
  Widget build(BuildContext context) {
    return loading ? Scaffold(body: Center(child: CircularProgressIndicator(),),) :Scaffold(
backgroundColor: Color(0xB3DDDCDC),
body: SafeArea(
  child:   SingleChildScrollView(
    child: Container(
      margin: EdgeInsets.symmetric(horizontal: 10 ),
      child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(height: 60,),
Container(
  child: Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      Text("Dashboard" , style: TextStyle(fontSize: 25 , fontWeight: FontWeight.bold),),
      Text("Sample Text Sample Text Sample Text" , style: TextStyle(fontSize: 14 ),),
    ],
  ),
),
SizedBox(height: 15,),


          Container(

            child: Material(
              elevation: 4,
                borderRadius: BorderRadius.all(Radius.circular(12)),
              child: Container(
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.all(Radius.circular(12))
                ),

                margin: EdgeInsets.symmetric(horizontal: 12 , vertical: 20),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Padding(
                      padding: const EdgeInsets.only(left: 15),
                      child: Text("Pending Orders" , style: TextStyle(fontSize: 18 , fontWeight: FontWeight.bold),),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(left: 15),
                      child: Text("Sample Text Sample Text Sample Text" , style: TextStyle(fontSize: 14 ),),

                    ),

                    SizedBox(height: 10,),

                    ListTile(
                      onTap: null,
                      leading: CircleAvatar(
                        backgroundColor: Colors.transparent,
                      ),
                      title: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: <Widget>[
                            Text("Order Name" , style: TextStyle(fontWeight: FontWeight.w600),),

                            Text("Order Book Date" , style: TextStyle(fontWeight: FontWeight.w600),),

                          ]
                      ),
                    ),
                    SizedBox(
                      height: 300,
                      child: ListView.builder(
                        shrinkWrap: true,
                          itemCount: dashOrderList.length,
                          itemBuilder: (context, index){
                          final order = dashOrderList![index];
                            return   ListTile(
                              onTap: (){
                                print(order.MobileNumber);
                                print(order.OrderBookDate);
                                print(order.CustomerName);
                                print(order.items);
                                print(order.Advance);
                                print(order.Note);
                                print(order.OrderDelivaryDate);



                                showDialog<String>(

                                    context: context,
                                    builder: (BuildContext context){


                                      return AlertDialog(
                                          title:  Text("Order Detials"),

                                          content:  SizedBox(
                                            width: MediaQuery.of(context).size.width-50,
                                            height: 200,
                                            child: SingleChildScrollView(
                                              child: Column(
                                                children: [
                                                  Text(order.CustomerName),
                                                  Text(order.MobileNumber),
                                                  Text(order.OrderBookDate),
                                                  Text(order.OrderDelivaryDate),
                                                  Text(order.Note),
                                                  Text(order.Advance),
                                                  SizedBox(height: 20,),
                                                  Text("Item Details"),
                                                  Container(
                                                    height: 200,
                                                    child: ListView.builder(
                                              itemCount: order.items.length,
                                              itemBuilder: (context , index){
                                                final item = order.items[index];
                                                      return ListTile(
                                                        leading: Text(item.itemName),
                                                        title: Text(item.itemQty.toString()),
                                                        trailing: Text(item.itemRate.toString()),

                                                      );
                                                    }
                                                    ),
                                                  )
                                                ],
                                              ),
                                            ),
                                          ),
                                          actions: <Widget>[
                                            TextButton(onPressed: (){
                                              Navigator.pop(context);
                                            }, child: Text("Close"))
                                          ],
                                        );

                                    }
                                );
                              },
                              title: Text( order.CustomerName),
                              leading: Text("${index+1}"),
                              trailing: Text("${order.OrderBookDate}"),
                            );
                          }

                      ),
                    )
                  ],
                ),
              ),
            ),
          ),

SizedBox(height: 20,),



          Container(

            child: Material(
              elevation: 4,
              borderRadius: BorderRadius.all(Radius.circular(12)),
              child: Container(
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.all(Radius.circular(12))
                ),

                margin: EdgeInsets.symmetric(horizontal: 12 , vertical: 20),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Padding(
                      padding: const EdgeInsets.only(left: 15),
                      child: Text("Daily Profit" , style: TextStyle(fontSize: 18 , fontWeight: FontWeight.bold),),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(left: 15),
                      child: Text("Sample Text Sample Text Sample Text" , style: TextStyle(fontSize: 14 ),),

                    ),

                    SizedBox(height: 10,),


                    SizedBox(
                      height: 300,
                      child: ActvityChart()
                    )
                  ],
                ),
              ),
            ),
          ),


          SizedBox(height: 20,),



          Container(

            child: Material(
              elevation: 4,
              borderRadius: BorderRadius.all(Radius.circular(12)),
              child: Container(
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.all(Radius.circular(12))
                ),

                margin: EdgeInsets.symmetric(horizontal: 12 , vertical: 20),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Padding(
                      padding: const EdgeInsets.only(left: 15),
                      child: Text("Monthly Profit" , style: TextStyle(fontSize: 18 , fontWeight: FontWeight.bold),),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(left: 15),
                      child: Text("Sample Text Sample Text Sample Text" , style: TextStyle(fontSize: 14 ),),

                    ),

                    SizedBox(height: 10,),


                    SizedBox(
                        height: 300,
                        child: ActvityChart()
                    )
                  ],
                ),
              ),
            ),
          ),


SizedBox(height: 20,),


          Container(

            child: Material(
              elevation: 4,
              borderRadius: BorderRadius.all(Radius.circular(12)),
              child: Container(
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.all(Radius.circular(12))
                ),

                margin: EdgeInsets.symmetric(horizontal: 12 , vertical: 20),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Padding(
                      padding: const EdgeInsets.only(left: 15),
                      child: Text("Attendance Details" , style: TextStyle(fontSize: 18 , fontWeight: FontWeight.bold),),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(left: 15),
                      child: Text("Sample Text Sample Text Sample Text" , style: TextStyle(fontSize: 14 ),),

                    ),

                    SizedBox(height: 10,),


                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: [
                        Column(
                          children: [


                            Text("76%" ,style: TextStyle(fontSize: 30),),
                            SizedBox(height: 10,),
                            Text("Yesterday\nAttendance" , style: TextStyle(fontSize: 15  , fontWeight: FontWeight.w600), textAlign: TextAlign.center,)
                          ],
                        ),

                        Column(
                          children: [


                            Text("12Hrs" ,style: TextStyle(fontSize: 30),),
                            SizedBox(height: 10,),
                            Text("Average\nWorktime" , style: TextStyle(fontSize: 15  , fontWeight: FontWeight.w600), textAlign: TextAlign.center)
                          ],
                        ),

                      ],
                    ),
                  ],
                ),
              ),
            ),
          ),



SizedBox(height: 20,),



          Container(

            child: Material(
              elevation: 4,
              borderRadius: BorderRadius.all(Radius.circular(12)),
              child: Container(
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.all(Radius.circular(12))
                ),

                margin: EdgeInsets.symmetric(horizontal: 12 , vertical: 20),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Padding(
                      padding: const EdgeInsets.only(left: 15),
                      child: Text("More Utilities" , style: TextStyle(fontSize: 18 , fontWeight: FontWeight.bold),),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(left: 15),
                      child: Text("Sample Text Sample Text Sample Text" , style: TextStyle(fontSize: 14 ),),

                    ),

                    SizedBox(height: 10,),


                   SingleChildScrollView(
                     scrollDirection: Axis.horizontal,
                     child: Row(
                       children: [
                         Container(
                           padding: EdgeInsets.symmetric(horizontal: 10 , vertical: 20),
                            width: 100,

                           decoration: BoxDecoration(
                             border: Border.all(
                                 color: Color(0x71A4A4A4) ,
                                 width: 2),
                             borderRadius: BorderRadius.all(Radius.circular(12))

                           ),
                           child: Column(
                             children: [
                               Icon(Icons.access_alarm_rounded , size: 70,),
SizedBox(height: 10,),
                               Text("Pending Order Delivery" , style: TextStyle(fontSize: 15 , fontWeight: FontWeight.w800 , color: Colors.black54  ), textAlign: TextAlign.center, )
                             ],
                           ),
                         ),
                         SizedBox(width: 20,),
                         Container(
                           padding: EdgeInsets.symmetric(horizontal: 10 , vertical: 20),
                           width: 100,

                           decoration: BoxDecoration(
                               border: Border.all(
                                   color: Color(0x71A4A4A4) ,
                                   width: 2),
                               borderRadius: BorderRadius.all(Radius.circular(12))

                           ),
                           child: Column(
                             children: [
                               Icon(Icons.print , size: 70,),
                               SizedBox(height: 10,),
                               Text("Print Delivery Invoice" , style: TextStyle(fontSize: 15 , fontWeight: FontWeight.w800 , color: Colors.black54  ), textAlign: TextAlign.center, )
                             ],
                           ),
                         ),

                         SizedBox(width: 20,),
                         Container(
                           padding: EdgeInsets.symmetric(horizontal: 10 , vertical: 20),
                           width: 100,

                           decoration: BoxDecoration(
                               border: Border.all(
                                   color: Color(0x71A4A4A4) ,
                                   width: 2),
                               borderRadius: BorderRadius.all(Radius.circular(12))

                           ),
                           child: Column(
                             children: [
                               Icon(Icons.bar_chart , size: 70,),
                               SizedBox(height: 10,),
                               Text("Product Wise Sale" , style: TextStyle(fontSize: 15 , fontWeight: FontWeight.w800 , color: Colors.black54  ), textAlign: TextAlign.center, )
                             ],
                           ),
                         ),
                         SizedBox(width: 20,),
                         Container(
                           padding: EdgeInsets.symmetric(horizontal: 10 , vertical: 20),
                           width: 100,

                           decoration: BoxDecoration(
                               border: Border.all(
                                   color: Color(0x71A4A4A4) ,
                                   width: 2),
                               borderRadius: BorderRadius.all(Radius.circular(12))

                           ),
                           child: Column(
                             children: [
                               Icon(Icons.featured_play_list , size: 70,),
                               SizedBox(height: 10,),
                               Text("One More Feature" , style: TextStyle(fontSize: 15 , fontWeight: FontWeight.w800 , color: Colors.black54  ), textAlign: TextAlign.center, )
                             ],
                           ),
                         ),
                         SizedBox(width: 20,),
                       ],
                     ),
                   )
                  ],
                ),
              ),
            ),
          ),

          SizedBox(height: 20,),


          Container(

            child: Material(
              elevation: 4,
              borderRadius: BorderRadius.all(Radius.circular(12)),
              child: Container(
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.all(Radius.circular(12))
                ),

                margin: EdgeInsets.symmetric(horizontal: 12 , vertical: 20),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Padding(
                      padding: const EdgeInsets.only(left: 15),
                      child: Text("Upcoming Festivals" , style: TextStyle(fontSize: 18 , fontWeight: FontWeight.bold),),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(left: 15),
                      child: Text("Sample Text Sample Text Sample Text" , style: TextStyle(fontSize: 14 ),),

                    ),

                    SizedBox(height: 10,),


                   SlideShower(items: [
                     "https://image.shutterstock.com/image-vector/biggest-diwali-sale-promotion-yellow-260nw-1523982320.jpg",
                     "https://www.creativehatti.com/wp-content/uploads/edd/2021/04/Happy-Navratri-festival-sale-offer-banner-design-template-06-large.jpg"
                   ])
                  ],
                ),
              ),
            ),
          ),

          SizedBox(height: 40,),
        ],

      ),
    ),
  ),
),
    );
  }
}
