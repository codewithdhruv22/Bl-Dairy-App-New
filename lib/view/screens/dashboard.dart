import 'package:bl_dairy_app/view/widgets/SlideShower.dart';
import 'package:bl_dairy_app/view/widgets/main_chart.dart';
import 'package:flutter/material.dart';

class Dashboard_Scren extends StatelessWidget {
  const Dashboard_Scren({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
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

                            Text("Order Amount" , style: TextStyle(fontWeight: FontWeight.w600),),

                          ]
                      ),
                    ),
                    SizedBox(
                      height: 300,
                      child: ListView.builder(
                        shrinkWrap: true,
                          itemCount: 12,
                          itemBuilder: (context, index){
                            return   ListTile(
                              title: Text("Order Title"),
                              leading: Text("${index+1}"),
                              trailing: Text("Rs.${index*137}"),
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
