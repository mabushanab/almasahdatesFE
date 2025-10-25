import 'package:flutter/material.dart';

// ...

class LandingPage extends StatefulWidget {
  @override
  State<LandingPage> createState() => _LandingPageState();
}

class _LandingPageState extends State<LandingPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('data')),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              spacing: MediaQuery.of(context).size.width *.25,
              children: [
                Card(child:
                 Column(
                   children: [
                     Text('data'),
                     Text('data'),
                     Text('data'),
                   ],
                 ),

                 ),
                Card(child: 
                                 Column(
                   children: [
                     Text('data'),
                     Text('data'),
                     Text('data'),
                   ],
                 ),),
                Card(child: Text('data')),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
