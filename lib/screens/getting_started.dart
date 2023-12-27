import 'package:flutter/material.dart';

class GetReadyPage extends StatelessWidget {
  const GetReadyPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          SizedBox(
            height: 200,
            child: ClipRRect(
                borderRadius: BorderRadius.circular(200.0),
                child: Image.asset('assets/girl2.jpeg')),
          ),
          SizedBox(
            height: 200,
            child: ClipRRect(
                borderRadius: BorderRadius.circular(200.0),
                child: Image.asset('assets/girl1.jpeg')),
          ),
          Text('Let\'s get started'),
          Text('Grow Together'),
          ElevatedButton(
              onPressed: () {

              },
              child: Text('Join Now'))
        ],
      ),
    );
  }
}
