import 'package:flutter/material.dart';



class ContactUs extends StatelessWidget {
  const ContactUs({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Text("Contact Number: +65 98627989", style: TextStyle(fontSize: 25, fontWeight: FontWeight.bold), ),
        Text("Email: fitness_app@gmail.com", style: TextStyle(fontSize: 25, fontWeight: FontWeight.bold),),
      ],
    );
  }
}
