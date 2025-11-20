import 'package:flutter/material.dart';
//الاسم:رامي شيخ
class Buttons extends StatelessWidget {
   Buttons({super.key, required this.press, this.child});
   VoidCallback? press;
   Widget? child;

  @override
  Widget build(BuildContext context) {
    return ElevatedButton( 
       onPressed: press,
       child:
           child ?? Row(children: [Icon(Icons.lock), Text("My Default Button")]),
     );
  }
}