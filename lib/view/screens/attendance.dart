import 'package:bl_dairy_app/view/widgets/main_chart.dart';
import 'package:bl_dairy_app/view/widgets/pie_chart.dart';
import 'package:flutter/material.dart';

class AttendanceScreen extends StatelessWidget {
  const AttendanceScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(

      body: SingleChildScrollView(
        child: SafeArea(
          child: Column(
            children: [
              Text("Attendance"),
              TextButton(onPressed: (){}, child: Text("Enter your attendance")),
              TextButton(onPressed: (){}, child: Text("Update your Attendace")),
Text("Attendance Report"),




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
                          child: Text("Attendance Report" , style: TextStyle(fontSize: 18 , fontWeight: FontWeight.bold),),
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


Text("Yesterday Attendace"),
              PieChart()

            ],
          ),
        ),
      ),
    );
  }
}
