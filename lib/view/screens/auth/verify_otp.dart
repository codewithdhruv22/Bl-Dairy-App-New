import 'package:flutter/material.dart';

class verifyOtp extends StatelessWidget {
  const verifyOtp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: Column(
          children: [

            Container(
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  CircleAvatar(backgroundColor: Colors.indigo, radius: 40,),
                  Column(

                    children: [
                      Text("verify OTP"),
                      Text("We have sent ...."),
                      TextButton(onPressed: (){}, child: Text("Wrong Number... OTP"))

                    ],
                  )
                ],
              ),
            ),

            TextField(),
            Text("Resned OTP in ..."),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                ElevatedButton(onPressed: (){}, child: Text("SMS")),
                ElevatedButton(onPressed: (){}, child: Text("Whatsapp")),
              ],
            )
          ],
        ),
      ),
    );
  }
}
