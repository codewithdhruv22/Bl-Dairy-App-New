import 'package:carousel_slider/carousel_options.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
class SlideShower extends StatelessWidget {
  SlideShower({Key? key ,required this.items}) : super(key: key);


  List items;
  int i = -1;

  @override
  Widget build(BuildContext context) {
    return  CarouselSlider(
      items : items.map((item) {
        i == items.length ? print("ROLLIN") :  i+=1;
        print(i);
        return Builder(
            builder: (BuildContext context){
              return InkWell(
                onTap: () async{
                  print("PIT GAYA MEIN");
                },
                child: Container(
                  margin : const EdgeInsets.symmetric(horizontal : 5 , vertical : 14),
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(15),
                      image: DecorationImage(

                          fit: BoxFit.cover,

                          image: NetworkImage(item)
                      )

                  ),
                ),
              );
            }
        );
      }).toList(),
      options : CarouselOptions(
          height : 200,
          autoPlay : true,
          enlargeCenterPage : true
      ),);
  }
}