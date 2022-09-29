import 'package:flutter/material.dart';

class LoginScreen extends StatelessWidget {
  const LoginScreen({Key? key}) : super(key: key);

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
                  CircleAvatar(backgroundColor: Colors.indigo,),
                  Column(
                    children: [
                      Text("Welcome"),
                      Text("Login to autobackup...")
                    ],
                  ),

                ],
              ),
            ),

            SizedBox(width: 400,
              child: TextField(),
            ),


            ElevatedButton(onPressed: (){}, child: Text("Send otp"))
          ],
        ),
      ),
    );
  }
}
