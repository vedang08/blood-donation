import 'package:flutter/material.dart';

class ViewRegPage extends StatelessWidget {
  final int regNo;
  ViewRegPage(this.regNo);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Registration Number"),
      ),
      body: SingleChildScrollView(
        
              child: Center(
          child: Padding(
            padding: const EdgeInsets.all(30.0),
            child: Text(
              "The registration number is " + regNo.toString(),
              textScaleFactor: 3.0,
            ),
          ),
        ),
      ),
    );
  }
}
