import 'package:ashdod_port_flutter/components/app_buttons.dart';
import 'package:flutter/material.dart';

class GetReadyPage extends StatelessWidget {
  const GetReadyPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          Image.asset('assets/first_page_bg.png'),
          Padding(
          padding: const EdgeInsets.only(bottom: 30.0, left: 30.0, right: 30.0),
          child: Column(
            children: [
              Align(
                alignment: Alignment.topRight,
                child: Padding(
                  padding: const EdgeInsets.only(bottom: 18.0),
                  child: SizedBox(
                    height: 100,
                    child: ClipRRect(
                        borderRadius: BorderRadius.circular(200.0),
                        child: Image.asset('assets/girl2.jpeg')),
                  ),
                ),
              ),
              Align(
                alignment: Alignment.topRight,
                child: Padding(
                  padding: const EdgeInsets.only(right: 20.0),
                  child: SizedBox(
                    height: 200,
                    child: ClipRRect(
                        borderRadius: BorderRadius.circular(200.0),
                        child: Image.asset('assets/girl1.jpeg')),
                  ),
                ),
              ),
              // Spacer(),
              ConstrainedBox(constraints: BoxConstraints(maxHeight: 390),
              child: Text('Let\'s get started', style: TextStyle(fontSize: 70, fontWeight: FontWeight.bold,overflow: TextOverflow.fade),)),
              Spacer(),
              Align(
                  alignment: Alignment.topLeft,
                  child: Text('Grow Together', style: TextStyle(fontSize: 12), overflow: TextOverflow.ellipsis,)),
              Padding(
                padding: const EdgeInsets.only(top: 8.0),
                child: LoginButton(
                  onPressed: () {
                    Navigator.pushNamed(context, '/home_page');
                  },
                  text: 'Join Now',)
              )
            ],
          ),
        ),
        ],
      ),
    );
  }
}
