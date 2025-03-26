export '/pages/user.dart';

import 'package:flutter/material.dart';

class UserPage extends StatelessWidget {
  final String testData;

  UserPage({Key? key, required this.testData}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: ListView(
        children: [
          AppBar(
            title: Text('Quin'),
            centerTitle: true,
          ),
          Text('test data: $testData'),
          ElevatedButton(onPressed: () {
            Navigator.pop(context);
          }, child: Text('返回')),
        ],
      )
    );
  }
}
