import 'package:flutter/material.dart';
import 'package:bl_dairy_app/view/widgets/main_chart.dart';
class ReportScreen extends StatelessWidget {
  const ReportScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xB3DDDCDC
      ),
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
                      Text("Reports" , style: TextStyle(fontSize: 25 , fontWeight: FontWeight.bold),),
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
                            child: Text("Daily Milk Purchase" , style: TextStyle(fontSize: 18 , fontWeight: FontWeight.bold),),
                          ),
                          Padding(
                            padding: const EdgeInsets.only(left: 15),
                            child: Text("Sample Text Sample Text Sample Text" , style: TextStyle(fontSize: 14 ),),

                          ),

                          SizedBox(height: 10,),


                          SizedBox(
                              height: 300,
                              child: ActvityChart()
                          ),

                          Padding(
                            padding: const EdgeInsets.only(left: 15),
                            child: Center(child: OutlinedButton(onPressed: (){},child: Text("Full Screen View"),)),

                          ),

                        ],
                      ),
                    ),

                  ),
                ),
                SizedBox(height: 20,),

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
                            child: Text("Daily Sale" , style: TextStyle(fontSize: 18 , fontWeight: FontWeight.bold),),
                          ),
                          Padding(
                            padding: const EdgeInsets.only(left: 15),
                            child: Text("Sample Text Sample Text Sample Text" , style: TextStyle(fontSize: 14 ),),

                          ),

                          SizedBox(height: 10,),


                          SizedBox(
                              height: 300,
                              child: ActvityChart()
                          ),

                          Padding(
                            padding: const EdgeInsets.only(left: 15),
                            child: Center(child: OutlinedButton(onPressed: (){},child: Text("Full Screen View"),)),

                          ),

                        ],
                      ),
                    ),

                  ),
                ),
                SizedBox(height: 20,),

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
                            child: Text("Daily Payement" , style: TextStyle(fontSize: 18 , fontWeight: FontWeight.bold),),
                          ),
                          Padding(
                            padding: const EdgeInsets.only(left: 15),
                            child: Text("Sample Text Sample Text Sample Text" , style: TextStyle(fontSize: 14 ),),

                          ),

                          SizedBox(height: 10,),


                          SizedBox(
                              height: 300,
                              child: ActvityChart()
                          ),

                          Padding(
                            padding: const EdgeInsets.only(left: 15),
                            child: Center(child: OutlinedButton(onPressed: (){},child: Text("Full Screen View"),)),

                          ),

                        ],
                      ),
                    ),

                  ),
                ),
                SizedBox(height: 20,),


              ],

            ),
          ),
        ),
      ),
    );
  }
}
